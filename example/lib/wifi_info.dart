import 'package:flutter/services.dart';

const platform = MethodChannel('eng.smaho.com/esptouch_plugin/example');

Future<String> get ssid async {
  return await platform.invokeMethod('ssid');
}

Future<String> get bssid async {
  return await platform.invokeMethod('bssid');
}
