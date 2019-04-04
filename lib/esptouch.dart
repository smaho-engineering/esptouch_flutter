import 'dart:async';

import 'package:esptouch/task_parameter.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

export 'package:esptouch/task_parameter.dart';

enum ESPTouchPacket {
  broadcast,
  multicast,
}

class ESPTouchResult {
  final String ip;
  final String bssid;

  ESPTouchResult(this.ip, this.bssid);

  ESPTouchResult.fromMap(Map<dynamic, dynamic> m)
      : ip = m['ip'],
        bssid = m['bssid'];

  @override
  bool operator ==(o) => o is ESPTouchResult && o.ip == ip && o.bssid == bssid;

  @override
  int get hashCode => ip.hashCode ^ bssid.hashCode;
}

const _eventChannel = EventChannel('eng.smaho.com/esptouch_plugin/results');

class ESPTouchTask {
  final String ssid;
  final String bssid;
  final String password;
  final ESPTouchPacket packet;
  ESPTouchTaskParameter taskParameter;

  ESPTouchTask({
    @required this.ssid,
    @required this.bssid,
    this.password = '',
    this.packet = ESPTouchPacket.broadcast,
    this.taskParameter,
  });

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
