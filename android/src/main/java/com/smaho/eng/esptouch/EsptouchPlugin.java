package com.smaho.eng.esptouch;

import android.content.Context;
import android.util.Log;

import com.espressif.iot.esptouch.task.EsptouchTaskParameter;

import java.util.Map;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** EsptouchPlugin */
public class EsptouchPlugin implements EventChannel.StreamHandler {
  private static final String TAG = "EsptouchPlugin";
  private static final String CHANNEL_NAME= "eng.smaho.com/esptouch_plugin/results";

  public static void registerWith(Registrar registrar) {
    final EventChannel eventChannel = new EventChannel(registrar.messenger(), CHANNEL_NAME);
    eventChannel.setStreamHandler(new EsptouchPlugin(registrar.context()));
  }

  private final Context context;
  private EspTouchTaskUtil taskUtil;

  private EsptouchPlugin(Context context) {
    this.context = context;
  }

  private EsptouchTaskParameter buildTaskParameter(Map<String, Integer> m) {
    EsptouchTaskParameter.Builder b = new EsptouchTaskParameter.Builder();
    b.setIntervalGuideCodeMillisecond(m.get("intervalGuideCodeMillisecond"));
    b.setIntervalDataCodeMillisecond(m.get("intervalDataCodeMillisecond"));
    b.setTimeoutGuideCodeMillisecond(m.get("timeoutGuideCodeMillisecond"));
    b.setTimeoutDataCodeMillisecond(m.get("timeoutDataCodeMillisecond"));
    b.setTotalRepeatTime(m.get("totalRepeatTime"));
    b.setEsptouchResultOneLen(m.get("esptouchResultOneLen"));
    b.setEsptouchResultMacLen(m.get("esptouchResultMacLen"));
    b.setEsptouchResultIpLen(m.get("esptouchResultIpLen"));
    b.setEsptouchResultTotalLen(m.get("esptouchResultTotalLen"));
    b.setPortListening(m.get("portListening"));
    b.setTargetPort(m.get("targetPort"));
    b.setWaitUdpReceivingMilliseond(m.get("waitUdpReceivingMillisecond"));
    b.setWaitUdpSendingMillisecond(m.get("waitUdpSendingMillisecond"));
    b.setThresholdSucBroadcastCount(m.get("thresholdSucBroadcastCount"));
    b.setExpectTaskResultCount(m.get("expectTaskResultCount"));
    return new EsptouchTaskParameter(b);
  }

  @Override
  @SuppressWarnings("unchecked")
  public void onListen(Object o, EventChannel.EventSink eventSink) {
    Log.d(TAG, "Event Listener is triggered");
    Map<String, Object> map = (Map<String, Object>) o;
    String ssid = (String) map.get("ssid");
    String bssid = (String) map.get("bssid");
    String password = (String) map.get("password");
    // TODO(smaho): packet is a bool value, should pass it as such
    String packet = (String) map.get("packet");
    Map<String, Integer> taskParameterMap = (Map<String, Integer>) map.get("taskParameter");
    Log.d(TAG, String.format("Received stream configuration arguments: SSID: %s, BBSID: %s, Password: %s, Packet: %s, Task parameter: %s", ssid, bssid, password, packet, taskParameterMap));
    EsptouchTaskParameter taskParameter = buildTaskParameter(taskParameterMap);
    Log.d(TAG, String.format("Converted taskUtil parameter from map %s to EsptouchTaskParameter %s.", taskParameterMap, taskParameter));
    taskUtil = new EspTouchTaskUtil(context, ssid, bssid, password, packet.equals("1"), taskParameter);
    taskUtil.listen(eventSink);
  }

  @Override
  public void onCancel(Object o) {
    Log.d(TAG, "Cancelling stream with configuration arguments" + o);
    if (taskUtil != null) {
      Log.d(TAG, "Task existed, cancelling manually");
      taskUtil.cancel();
    }
  }
}
