#import "EsptouchTaskUtil.h"
// TODO(smaho): Double check which imports are actually needed

@implementation EsptouchTaskUtil

FlutterEventSink _eventSink;

- (void)onEsptouchResultAddedWithResult:(ESPTouchResult *)result {
    NSString *bssid = result.bssid;
    NSString *ip = [ESP_NetUtil descriptionInetAddr4ByData:result.ipAddrData];
    NSDictionary *resultDictionary = @{@"bssid": bssid, @"ip": ip};
    // TODO(smaho): Verify is main queue would not be better. Or is it the main queue?
    dispatch_async(dispatch_get_current_queue(), ^{
        _eventSink(resultDictionary);
    });
}

- (id)initWithBSSID:(NSString *)bssid
            andSSID:(NSString *)ssid
        andPassword:(NSString *)password
  andTaskParameters:(ESPTaskParameter *)taskParameter
      withBroadcast:(BOOL)packet {
    self = [super init];
    self.bssid = bssid;
    self.ssid = ssid;
    self.password = password;
    self.packet = packet;
    self.taskParameter = taskParameter;
    return self;
}

- (void)listen:(FlutterEventSink)eventSink {
    _eventSink = eventSink;
    [self._condition lock];
    // TODO(smaho): Handle all supported task parameters
    self._esptouchTask = [[ESPTouchTask alloc]
        initWithApSsid:self.ssid
            andApBssid:self.bssid
              andApPwd:self.password
                andAES:nil
      andTaskParameter:self.taskParameter
    ];
    [self._esptouchTask setEsptouchDelegate:self];
    // TODO(smaho): Set package broadcast based on Flutter plugin's parameter
    [self._esptouchTask setPackageBroadcast:self.packet];
    [self._condition unlock];
    // TODO(smaho): Use QoS. Read docs for dispatch_get_global_queue's identifier parameter
    // > It is recommended to use quality of service class values to identify the
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSArray *results = [self._esptouchTask executeForResults:5];
        NSLog(@"ESPViewController executeForResult() result is: %@", results);
    });
}

- (void)cancel {
    [self._condition lock];
    if (self._esptouchTask != nil) {
        [self._esptouchTask interrupt];
    }
    [self._condition unlock];
}

@end
