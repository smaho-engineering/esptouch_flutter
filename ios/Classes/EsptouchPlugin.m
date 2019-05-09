#import "EsptouchPlugin.h"

@implementation EsptouchPlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterEventChannel *channel = [FlutterEventChannel
        eventChannelWithName:@"eng.smaho.com/esptouch_plugin/results"
             binaryMessenger:[registrar messenger]];
    EsptouchResultsStreamHandler *resultsStreamHandler = [[EsptouchResultsStreamHandler alloc] init];
    [channel setStreamHandler:resultsStreamHandler];
}

@end


@implementation EsptouchResultsStreamHandler

- (ESPTaskParameter *)buildTaskParameter:(NSDictionary *)d {
    // TODO(smaho): Dart does send this too: d[@"esptouchResultIpLen"];
    return [[ESPTaskParameter alloc]
        initWithIntervalGuideCodeMillisecond:[d[@"intervalGuideCodeMillisecond"] intValue]
                 intervalDataCodeMillisecond:[d[@"intervalDataCodeMillisecond"] intValue]
                 timeoutGuideCodeMillisecond:[d[@"timeoutGuideCodeMillisecond"] intValue]
                  timeoutDataCodeMillisecond:[d[@"timeoutDataCodeMillisecond"] intValue]
                             totalRepeatTime:[d[@"totalRepeatTime"] intValue]
                        esptouchResultOneLen:[d[@"esptouchResultOneLen"] intValue]
                        esptouchResultMacLen:[d[@"esptouchResultMacLen"] intValue]
                               portListening:[d[@"portListening"] intValue]
                                  targetPort:[d[@"targetPort"] intValue]
                 waitUdpReceivingMillisecond:[d[@"waitUdpReceivingMillisecond"] intValue]
                   waitUdpSendingMillisecond:[d[@"waitUdpSendingMillisecond"] intValue]
                  thresholdSucBroadcastCount:[d[@"thresholdSucBroadcastCount"] intValue]
                       expectTaskResultCount:[d[@"expectTaskResultCount"] intValue]
    ];

}

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    NSDictionary *args = arguments;
    NSString *bssid = args[@"bssid"];
    NSString *ssid = args[@"ssid"];
    NSString *password = args[@"password"];
    // TODO(smaho): packet is a bool value, should pass it as such
    // This requires Dart+Java+ObjC refactors as it's the plugin's interface
    BOOL packet = [args[@"packet"] isEqual:@"1"];
    NSDictionary *taskParameterArgs = args[@"taskParameter"];
    ESPTaskParameter *taskParameter = [self buildTaskParameter:taskParameterArgs];
    EsptouchTaskUtil *taskUtil = [[EsptouchTaskUtil alloc]
        initWithBSSID:bssid
              andSSID:ssid
          andPassword:password
    andTaskParameters:taskParameter
        withBroadcast:packet
    ];
    [taskUtil listen:eventSink];
    self.taskUtil = taskUtil;
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    if (self.taskUtil != nil) {
        [self.taskUtil cancel];
    }
    return nil;
}

@end
