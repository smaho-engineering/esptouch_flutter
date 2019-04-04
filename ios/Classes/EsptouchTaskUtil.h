#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

#import "ESPViewController.h"
#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"
#import "ESPAES.h"


@interface EsptouchTaskUtil : NSObject<ESPTouchDelegate>

@property (nonatomic, strong) NSCondition* _condition;
@property (atomic, strong) ESPTouchTask* _esptouchTask;
@property NSString* bssid;
@property NSString* ssid;
@property NSString* password;
@property int count;

- (id) initWithBSSID: (NSString*) bssid andSSID:(NSString*)ssid andPassword:(NSString*)password andCount:(int)count;
- (void)listen:(FlutterEventSink)sink;
- (void)cancel;

@end
