package com.smaho.eng.esptouch;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.espressif.iot.esptouch.task.EsptouchTaskParameter;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/** EsptouchPlugin */
public class EsptouchPlugin implements EventChannel.StreamHandler, FlutterPlugin, ActivityAware {
  private static final String TAG = "EsptouchPlugin";
  private static final String CHANNEL_NAME= "eng.smaho.com/esptouch_plugin/results";

  /** backward compatibility with embedding v1 **/
  @SuppressWarnings("deprecation") // Registrar deprecated (v1 plugin embedding).
  public static void registerWith(Registrar registrar) {
    EsptouchPlugin plugin = new EsptouchPlugin();
    plugin.activity = registrar.activity();
    plugin.context = registrar.context();
    plugin.setupMethodChannel(registrar.messenger());
  }

  private EventChannel channel;
  private Activity activity;
  private Context context;
  private EspTouchTaskUtil taskUtil;

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
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    context = binding.getApplicationContext();
    setupMethodChannel(binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setStreamHandler(null);
    channel = null;
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }

  private void setupMethodChannel(BinaryMessenger messenger) {
    channel = new EventChannel(messenger, CHANNEL_NAME);
    channel.setStreamHandler(this);
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
