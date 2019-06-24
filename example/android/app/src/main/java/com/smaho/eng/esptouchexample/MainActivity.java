package com.smaho.eng.esptouchexample;

import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "eng.smaho.com/esptouch_plugin/example";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                switch (call.method) {
                  case "bssid": handleBSSID(call, result); return;
                  case "ssid": handleSSID(call, result); return;
                  default: result.notImplemented(); return;
                }
              }
            }
    );
  }

  private void handleBSSID(MethodCall call, MethodChannel.Result result) {
    WifiInfo wifiInfo = getWifiInfo();
    String bssid = null;
    if (wifiInfo != null) {
      bssid = wifiInfo.getBSSID();
    }
    result.success(bssid);
  }

  private void handleSSID(MethodCall call, MethodChannel.Result result) {
    WifiInfo wifiInfo = getWifiInfo();
    String ssid = null;
    if (wifiInfo != null) {
      ssid = wifiInfo.getSSID();
      if (ssid.equals("<unknown ssid>")) {
        ssid = null;
      }
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
        if (ssid != null && ssid.startsWith("\"") && ssid.endsWith("\"")) {
          ssid = ssid.substring(1, ssid.length() - 1);
        }
      }
    }
    result.success(ssid);
  }

  private WifiInfo getWifiInfo() {
    WifiManager wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
    WifiInfo wifiInfo = null;
    if (wifiManager != null) {
      wifiInfo = wifiManager.getConnectionInfo();
    }
    return wifiInfo;
  }
}
