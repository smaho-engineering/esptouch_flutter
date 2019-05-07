#import "EsptouchTaskUtil.h"
#import "ESPViewController.h"
#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"
#import "ESPAES.h"
// Double check which imports are actually needed

@implementation EsptouchTaskUtil

FlutterEventSink _eventSink;

-(void) onEsptouchResultAddedWithResult: (ESPTouchResult *) result {
  NSString* bssid = result.bssid;
  NSString* ip = [ESP_NetUtil descriptionInetAddr4ByData:result.ipAddrData];
  NSDictionary* resultDictionairy = @{ @"bssid": bssid, @"ip" : ip};
  // _eventSink(resultDictionairy);
  dispatch_async(dispatch_get_current_queue(), ^{
    _eventSink(resultDictionairy);
  });
}

- (id) initWithBSSID: (NSString*) bssid andSSID:(NSString*)ssid andPassword:(NSString*)password andCount:(int)count {
  self = [super init];
  self.bssid = bssid;
  self.ssid = ssid;
  self.password = password;
  self.count = count;
  return self;
}

- (void)listen:(FlutterEventSink)eventSink {
  NSLog(@"Listening with parameters:");
  NSLog(@"bssid %@", self.bssid);
  NSLog(@"ssid %@", self.ssid);
  NSLog(@"password %@", self.password);
  _eventSink = eventSink;
  [self._condition lock];
  self._esptouchTask = [[ESPTouchTask alloc]initWithApSsid:self.ssid andApBssid:self.bssid andApPwd:self.password];
  [self._esptouchTask setEsptouchDelegate:self];
  [self._esptouchTask setPackageBroadcast:TRUE];
  [self._condition unlock];
  dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_async(queue, ^{
    NSArray * esptouchResults = [self._esptouchTask executeForResults:5];
    NSLog(@"ESPViewController executeForResult() result is: %@", esptouchResults);
  });
}


- (void) cancel {
  [self._condition lock];
  if (self._esptouchTask != nil) {
    [self._esptouchTask interrupt];
  }
  [self._condition unlock];
}

@end
