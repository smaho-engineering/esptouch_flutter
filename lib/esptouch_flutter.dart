import 'dart:async';

import 'package:flutter/services.dart';

/// ESPTouch packet type, either broadcast or multicast.
enum ESPTouchPacket { broadcast, multicast }

/// Contain the configured device's IP and MAC addresses.
///
/// When working with ESPTouch's [ESPTouchTask], the output of a task is basically
/// a [Stream]<[ESPTouchResult]>.
class ESPTouchResult {
  /// Create ESPTouchResult
  const ESPTouchResult(this.ip, this.bssid);

  /// Create strongly-typed ESPTouchResult instance from a map.
  ESPTouchResult.fromMap(Map<dynamic, dynamic> m)
      : ip = m['ip'],
        bssid = m['bssid'];

  /// IP address of the connected device on the local network in string representation.
  ///
  /// Example: 127.0.0.55
  final String ip;

  /// BSSID (MAC address) of the connected device.
  ///
  /// Example: `ab:cd:ef:c0:ff:33`, or without colons `abcdefc0ff33`
  final String bssid;

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
  final ESPTouchTaskParameter taskParameter;

  const ESPTouchTask({
    required this.ssid,
    required this.bssid,
    this.password = '',
    this.packet = ESPTouchPacket.broadcast,
    this.taskParameter = const ESPTouchTaskParameter(),
  });

  /// Launch ESPTouch task and listen for events.
  ///
  /// The
  Stream<ESPTouchResult> execute() {
    assert(ssid.isNotEmpty, 'SSID can\'t be empty');
    assert(bssid.isNotEmpty, 'BSSID can\'t be empty');
    return _eventChannel.receiveBroadcastStream({
      'ssid': ssid,
      'bssid': bssid,
      'password': password,
      'packet': packet == ESPTouchPacket.broadcast ? '1' : '0',
      'taskParameter': taskParameter.toMap(),
    }).map((event) => ESPTouchResult.fromMap(event));
  }
}

/// Configure [ESPTouchTask] using an [ESPTouchTaskParameter] instance.
///
/// This provides great flexibility, you can for example run an [ESPTouchTask]
/// for hours, if this is what your workflow requires.
class ESPTouchTaskParameter {
  /// Create ESPTouchTaskParameter.
  const ESPTouchTaskParameter({
    this.intervalGuideCode = const Duration(milliseconds: 8),
    this.intervalDataCode = const Duration(milliseconds: 8),
    this.timeoutGuideCode = const Duration(seconds: 2),
    this.timeoutDataCode = const Duration(seconds: 4),
    this.repeat = 1,
    this.oneLength = 1,
    this.macLength = 6,
    this.ipLength = 4,
    this.portListening = 18266,
    this.portTarget = 7001,
    this.waitUdpReceiving = const Duration(seconds: 15),
    this.waitUdpSending = const Duration(seconds: 45),
    this.thresholdSucBroadcastCount = 1,
    this.expectedTaskResults = 1,
  });

  // I couldn't figure out what all of these values actually mean.
  // The "official" documentation is not very helpful, either.
  // iOS Objective-C: https://github.com/EspressifApp/EsptouchForIOS/blob/master/EspTouchDemo/ESPTouchTaskParameter.h
  // Android Java: https://github.com/EspressifApp/EsptouchForAndroid/blob/master/esptouch/src/main/java/com/espressif/iot/esptouch/task/IEsptouchTaskParameter.java
  /// the time between each guide code sending
  final Duration intervalGuideCode;

  /// the time between each data code sending
  final Duration intervalDataCode;
  final Duration timeoutGuideCode;
  final Duration timeoutDataCode;
  final int repeat;
  final int oneLength;

  /// MAC length in result
  final int macLength;

  /// IP length in result
  final int ipLength;

  /// Listening port, used by the server
  final int portListening;

  /// Target port, used by the client
  final int portTarget;

  /// Wait UDP receiving, without sending
  final Duration waitUdpReceiving;

  /// Wait UDP sending, including receiving
  final Duration waitUdpSending;

  /// Threshold for how many correct broadcast should be received
  final int thresholdSucBroadcastCount;

  /// Return results up to [expectedTaskResults] count.
  final int expectedTaskResults;

  get _totalLength {
    return oneLength + macLength + ipLength;
  }

  /// Convert [ESPTouchTaskParameter] instance to a [Map] of
  /// type `Map<String, int>`.
  ///
  /// Converting to a map is needed for sending information over the
  /// platform channels.
  ///
  /// You can read more about writing platform-specific code and supported
  /// formats for sending data to the hosts (Android and iOS):
  /// * [Platform channel data types support and codecs](https://flutter.dev/docs/development/platform-integration/platform-channels#platform-channel-data-types-support-and-codecs)
  ///
  /// We define all values (default or specified) in Dart so that we don't need
  /// to handle different default values twice for each platforms.
  Map<String, int> toMap() {
    // I'm using the ESPTouch library terminology as keys, but tried
    // to use Dart objects and renamed the parameters
    // for creating a more convenient library for Flutter
    return {
      'intervalGuideCodeMillisecond': intervalGuideCode.inMilliseconds,
      'intervalDataCodeMillisecond': intervalDataCode.inMilliseconds,
      'timeoutGuideCodeMillisecond': timeoutGuideCode.inMilliseconds,
      'timeoutDataCodeMillisecond': timeoutDataCode.inMilliseconds,
      'totalRepeatTime': repeat,
      'esptouchResultOneLen': oneLength,
      'esptouchResultMacLen': macLength,
      'esptouchResultIpLen': ipLength,
      'esptouchResultTotalLen': _totalLength,
      'portListening': portListening,
      'targetPort': portTarget,
      'waitUdpReceivingMillisecond': waitUdpReceiving.inMilliseconds,
      'waitUdpSendingMillisecond': waitUdpSending.inMilliseconds,
      'thresholdSucBroadcastCount': thresholdSucBroadcastCount,
      'expectTaskResultCount': expectedTaskResults,
    };
  }

  /// Copy the task parameter with some fields changed.
  ESPTouchTaskParameter copyWith({
    Duration? intervalGuideCode,
    Duration? intervalDataCode,
    Duration? timeoutGuideCode,
    Duration? timeoutDataCode,
    int? repeat,
    int? oneLength,
    int? macLength,
    int? ipLength,
    int? portListening,
    int? portTarget,
    Duration? waitUdpReceiving,
    Duration? waitUdpSending,
    int? thresholdSucBroadcastCount,
    int? expectedTaskResults,
  }) {
    return ESPTouchTaskParameter(
      intervalGuideCode: intervalGuideCode ?? this.intervalGuideCode,
      intervalDataCode: intervalDataCode ?? this.intervalDataCode,
      timeoutGuideCode: timeoutGuideCode ?? this.timeoutGuideCode,
      timeoutDataCode: timeoutDataCode ?? this.timeoutDataCode,
      repeat: repeat ?? this.repeat,
      oneLength: oneLength ?? this.oneLength,
      macLength: macLength ?? this.macLength,
      ipLength: ipLength ?? this.ipLength,
      portListening: portListening ?? this.portListening,
      portTarget: portTarget ?? this.portTarget,
      waitUdpReceiving: waitUdpReceiving ?? this.waitUdpReceiving,
      waitUdpSending: waitUdpSending ?? this.waitUdpSending,
      thresholdSucBroadcastCount:
          thresholdSucBroadcastCount ?? this.thresholdSucBroadcastCount,
      expectedTaskResults: expectedTaskResults ?? this.expectedTaskResults,
    );
  }
}
