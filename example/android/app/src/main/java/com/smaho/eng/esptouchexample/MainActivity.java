package com.smaho.eng.esptouchexample;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "eng.smaho.com/esptouch_plugin/example";
  private static final int REQUEST_CODE = 1357;

  private MethodCall call;
  private MethodChannel.Result result;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
        (call, result) -> {
          this.call = call;
          this.result = result;
          // https://developer.android.com/about/versions/marshmallow/android-6.0-changes#behavior-hardware-id
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            handlePermissions();
          } else {
            handleMethodCall();
          }
        }
    );
  }

  /**
   * Ensure ACCESS_FINE_LOCATION permission is either requested or granted to the app.
   */
  private void handlePermissions() {
    final String ACCESS_FINE_LOCATION = Manifest.permission.ACCESS_FINE_LOCATION;
    if (ContextCompat.checkSelfPermission(this, ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
      handleMethodCall();
    } else {
      ActivityCompat.requestPermissions(this, new String[]{ACCESS_FINE_LOCATION}, REQUEST_CODE);
    }
  }

  @Override
  public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    if (requestCode == REQUEST_CODE) {
      // I don't need to check the permission result for the example app, because the example
      // app handles null cases and has editable form fields for the WiFi BSSID and SSID.
      // ... So without checking the grant results, we just try to "trigger" the original
      // method call again.
      handleMethodCall();
    }
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
  }

  private void handleMethodCall() {
    switch (call.method) {
      case "bssid":
        handleBSSID(); break;
      case "ssid":
        handleSSID(); break;
      default:
        result.notImplemented(); break;
    }
    call = null;
    result = null;
  }

  private void handleBSSID() {
    WifiInfo wifiInfo = getWifiInfo();
    String bssid = null;
    if (wifiInfo != null) {
      bssid = wifiInfo.getBSSID();
    }
    result.success(bssid);
  }

  private void handleSSID() {
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
