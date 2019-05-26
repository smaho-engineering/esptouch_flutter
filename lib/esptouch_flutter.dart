import 'dart:async';

import 'package:esptouch_flutter/task_parameter.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

export 'package:esptouch_flutter/task_parameter.dart';

/// ESPTouch packet type, either broadcast or multicast.
enum ESPTouchPacket {
  broadcast,
  multicast,
}

/// Contain the configured device's IP and MAC addresses.
///
/// When working with ESPTouch's [ESPTouchTask], this is basically the output of a task:
/// a [Stream] of [ESPTouchResult]s.
class ESPTouchResult {
  /// IP address of the connected device on the local network in string representation.
  ///
  /// Example: 127.0.0.55
  final String ip;

  /// BSSID (MAC address) of the connected device.
  ///
  /// Example: `ab:cd:ef:c0:ff:33`
  final String bssid;

  /// Create ESPTouchResult
  ESPTouchResult(this.ip, this.bssid);

  /// Create strongly-typed ESPTouchResult instance from a map.
  ESPTouchResult.fromMap(Map<dynamic, dynamic> m)
      : ip = m['ip'],
        bssid = m['bssid'];

  /// We provide == operator implementation: if two results have the same IP
  /// and BSSID, we consider them the same.
  ///
  /// This can be useful when working with sets, maps, etc... where equality check becomes important
  @override
  bool operator ==(o) => o is ESPTouchResult && o.ip == ip && o.bssid == bssid;

  /// We provide a hashcode implementation.
  ///
  /// This can be useful when working with sets, maps, etc... where equality check becomes important
  @override
  int get hashCode => ip.hashCode ^ bssid.hashCode;
}

const _eventChannel = EventChannel('eng.smaho.com/esptouch_plugin/results');

/// Class to pass all required information to the platform-specific implementations
/// to fire an ESP-Touch task.
///
/// By passing the WiFi name, MAC address and password, you can configure
/// network for ESP8266 and ESP32 devices.
class ESPTouchTask {
  /// WiFi name
  ///
  /// Example: `WLAN-12345`, `Vince's iPhone`.
  ///
  /// SSID stands for service set identifier.
  ///
  /// You can use the [connectivity](https://pub.dev/packages/connectivity)
  /// plugin to fetch the WiFi SSID for your ESP-Touch task.
  ///
  /// Alternatively, you can use simply platform channels to request the WiFi name,
  /// you can see an example for that in the `example` project:
  /// * Dart code: https://github.com/smaho-engineering/esptouch_flutter/blob/master/example/lib/wifi_info.dart
  /// * iOS code: https://github.com/smaho-engineering/esptouch_flutter/blob/master/example/ios/Runner/AppDelegate.m
  /// * Android code: https://github.com/smaho-engineering/esptouch_flutter/blob/master/example/android/app/src/main/java/com/smaho/eng/esptouchexample/MainActivity.java
  final String ssid;

  /// WiFi BSSID is the MAC address of the wireless access point.
  ///
  /// Example: `ab:cd:ef:12:34:56`.
  ///
  /// BSSID stands for service set identifier. You can use the [connectivity](https://pub.dev/packages/connectivity)
  /// plugin to fetch the WiFi BSSID for your ESP-Touch task.
  ///
  /// Alternatively, you can use simply platform channels to request the WiFi name,
  /// you can see an example for that in the `example` project:
  /// * Dart code: https://github.com/smaho-engineering/esptouch_flutter/blob/master/example/lib/wifi_info.dart
  /// * iOS code: https://github.com/smaho-engineering/esptouch_flutter/blob/master/example/ios/Runner/AppDelegate.m
  /// * Android code: https://github.com/smaho-engineering/esptouch_flutter/blob/master/example/android/app/src/main/java/com/smaho/eng/esptouchexample/MainActivity.java
  final String bssid;

  /// Password for the wireless access point.
  ///
  /// Example: `S3CR3t_P@ssW0rD`
  final String password;

  /// Broadcast or Multicast
  final ESPTouchPacket packet;

  /// Configuration parameters for the task,
  ESPTouchTaskParameter taskParameter;

  ESPTouchTask({
    @required this.ssid,
    @required this.bssid,
    this.password = '',
    this.packet = ESPTouchPacket.broadcast,
    this.taskParameter,
  });

  /// Launch ESPTouch task and listen for events.
  ///
  /// The
  Stream<ESPTouchResult> execute() {
    if (ssid == null || bssid == null) {
      throw ArgumentError('SSID and BSSID for Wi-Fi network is required.');
    }
    return _eventChannel.receiveBroadcastStream({
      'ssid': ssid,
      'bssid': bssid,
      'password': password,
      'packet': packet == ESPTouchPacket.broadcast ? '1' : '0',
      'taskParameter': (taskParameter ?? ESPTouchTaskParameter()).toMap(),
    }).map((event) => ESPTouchResult.fromMap(event));
  }
}
