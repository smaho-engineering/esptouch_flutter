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
    EsptouchTaskUtil *taskUtil = [[EsptouchTaskUtil alloc] initWithBSSID:bssid andSSID:ssid andPassword:password andCount:5];
    [taskUtil listen:eventSink];
    // self._taskUtil = taskUtil;
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    // if (self._taskUtil != nil) {
    //   [self._taskUtil cancel];
    // }
    return nil;
}

@end
