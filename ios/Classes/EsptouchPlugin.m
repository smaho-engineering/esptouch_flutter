#import "EsptouchPlugin.h"
#import "EsptouchTaskUtil.h"

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

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    NSDictionary *args = arguments;
    NSString *bssid = args[@"bssid"];
    NSString *ssid = args[@"ssid"];
    NSString *password = args[@"password"];
    // TODO(smaho): packet is a bool value, should pass it as such
    // This requires Dart+Java+ObjC refactors as it's the plugin's interface
    BOOL packet = [args[@"packet"] isEqual:@"1"];
    NSLog(@"packet argument value is %d", packet);
    EsptouchTaskUtil *taskUtil = [[EsptouchTaskUtil alloc]
        initWithBSSID:bssid
              andSSID:ssid
          andPassword:password
             andCount:5
        withBroadcast:packet
    ];
    [taskUtil listen:eventSink];
    // self._taskUtil = taskUtil;
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    // TODO(smaho): Make sure we can cancel tasks properly from Dart/Flutter
    // if (self._taskUtil != nil) {
    //   [self._taskUtil cancel];
    // }
    return nil;
}

@end
