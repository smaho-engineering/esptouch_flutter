import 'package:flutter/services.dart';

const platform = MethodChannel('eng.smaho.com/esptouch_plugin/example');

/// Get WiFi SSID using platform channels.
///
/// Can return null if BSSID information is not available.
Future<String> get ssid async {
  return await platform.invokeMethod('ssid');
}

/// Get WiFi BSSID using platform channels.
///
/// Can return null if BSSID information is not available.
Future<String> get bssid async {
  return await platform.invokeMethod('bssid');
}
