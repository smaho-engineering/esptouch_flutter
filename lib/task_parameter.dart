class ESPTouchTaskParameter {
  // I couldn't figure out what all of these values actually mean.
  // The "official" documentation is not very helpful, either.
  // iOS Objective-C: https://github.com/EspressifApp/EsptouchForIOS/blob/master/EspTouchDemo/ESPTouchTaskParameter.h
  // Android Java: https://github.com/EspressifApp/EsptouchForAndroid/blob/master/esptouch/src/main/java/com/espressif/iot/esptouch/task/IEsptouchTaskParameter.java
  /// the time between each guide code sending
  Duration intervalGuideCode;
  /// the time between each data code sending
  Duration intervalDataCode;
  Duration timeoutGuideCode;
  Duration timeoutDataCode;
  int repeat;
  int oneLength;
  /// MAC length in result
  int macLength;
  /// IP length in result
  int ipLength;
  /// Listening port, used by the server
  int portListening;
  /// Target port, used by the client
  int portTarget;
  /// Wait UDP receiving, without sending
  Duration waitUdpReceiving;
  /// Wait UDP sending, including receiving
  Duration waitUdpSending;
  /// Threshold for how many correct broadcast should be received
  int thresholdSucBroadcastCount;
  int expectedTaskResults;

  ESPTouchTaskParameter({
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

  get totalLength {
    return oneLength + macLength + ipLength;
  }

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
      'esptouchResultTotalLen': totalLength,
      'portListening': portListening,
      'targetPort': portTarget,
      'waitUdpReceivingMillisecond': waitUdpReceiving.inMilliseconds,
      'waitUdpSendingMillisecond': waitUdpSending.inMilliseconds,
      'thresholdSucBroadcastCount': thresholdSucBroadcastCount,
      'expectTaskResultCount': expectedTaskResults,
    };
  }
}
