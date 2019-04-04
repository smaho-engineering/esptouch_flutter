package com.smaho.eng.esptouch;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;

import com.espressif.iot.esptouch.EsptouchTask;
import com.espressif.iot.esptouch.IEsptouchListener;
import com.espressif.iot.esptouch.IEsptouchResult;
import com.espressif.iot.esptouch.IEsptouchTask;
import com.espressif.iot.esptouch.task.IEsptouchTaskParameter;
import com.espressif.iot.esptouch.util.ByteUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;

public class EspTouchTaskUtil {
  private static final String TAG = "EspTouchTaskUtil";
  private final byte[] ssid;
  private final byte[] bssid;
  private final byte[] password;
  private final boolean broadcast;
  private final Context context;
  private final IEsptouchTaskParameter taskParameter;
  private EventChannel.EventSink eventSink;
  private EspTouchAsyncTask asyncTask;

  private static class EspTouchAsyncTask extends AsyncTask<Void, Void, List<IEsptouchResult>> {
    private static final String TAG = "EspTouchAsyncTask";
    private final Object lock = new Object();
    private final EspTouchTaskUtil espTouchTaskUtil;
    private IEsptouchTask esptouchTask;

    public EspTouchAsyncTask(EspTouchTaskUtil espTouchTaskUtil) {
      this.espTouchTaskUtil = espTouchTaskUtil;
    }

    @Override
    protected List<IEsptouchResult> doInBackground(Void... params) {
      synchronized (lock) {
        esptouchTask = new EsptouchTask(
            espTouchTaskUtil.ssid,
            espTouchTaskUtil.bssid,
            espTouchTaskUtil.password,
            espTouchTaskUtil.context,
            espTouchTaskUtil.taskParameter
        );
        esptouchTask.setPackageBroadcast(espTouchTaskUtil.broadcast);
        esptouchTask.setEsptouchListener(new IEsptouchListener() {
          @Override
          public void onEsptouchResultAdded(IEsptouchResult esptouchResult) {
            Log.d(TAG, "Received result: " + esptouchResult);
            if (!esptouchResult.isSuc()) {
              // TODO: Handle errors better. For that, I need to reproduce this error
              // and see what is sent to the Dart code first.
              final String msg = "Received unsuccessful result: " + esptouchResult;
              Log.e(TAG, msg);
              espTouchTaskUtil.eventSink.error(msg, msg, null);
              return;
            }
            Map<String, String> result = new HashMap();
            result.put("bssid", esptouchResult.getBssid());
            result.put("ip", esptouchResult.getInetAddress().getHostAddress());
            espTouchTaskUtil.eventSink.success(result);
          }
        });
      }
      final int count = espTouchTaskUtil.taskParameter.getExpectTaskResultCount();
      Log.d(TAG, "Expected task result count is : " + count);
      return esptouchTask.executeForResults(count);
    }

    public void cancelEsptouch() {
      Log.d(TAG, "cancelEsptouch");
      cancel(true);
      if (esptouchTask != null) {
        Log.d(TAG, "Task in cancelEsptouch has to be interrupted");
        esptouchTask.interrupt();
      }
    }
  }


  public EspTouchTaskUtil(
      Context context,
      String ssid,
      String bssid,
      String password,
      Boolean broadcast,
      IEsptouchTaskParameter taskParameter
  ) {
    this.context = context;
    this.ssid = ByteUtil.getBytesByString(ssid);
    ;
    this.bssid = ByteUtil.getBytesByString(bssid);
    this.password = ByteUtil.getBytesByString(password);
    this.broadcast = broadcast;
    this.taskParameter = taskParameter;
  }

  public void listen(final EventChannel.EventSink eventSink) {
    this.eventSink = eventSink;
    asyncTask = new EspTouchAsyncTask(this);
    asyncTask.execute();
  }

  public void cancel() {
    Log.d(TAG, "cancel");
    asyncTask.cancelEsptouch();
  }
}
