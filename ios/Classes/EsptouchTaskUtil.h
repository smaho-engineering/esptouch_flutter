#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

#import "ESPViewController.h"
#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"
#import "ESPAES.h"
#import "ESPTouchTaskParameter.h"


@interface EsptouchTaskUtil : NSObject <ESPTouchDelegate>

// TODO(smaho): Do we need to specify atomic/nonatomic and strong?
// Atomic is the default. Strong might not be necessary
@property(nonatomic, strong) NSCondition *_condition;
@property(atomic, strong) ESPTouchTask *_esptouchTask;
@property NSString *bssid;
@property NSString *ssid;
@property NSString *password;
@property ESPTaskParameter *taskParameter;
@property BOOL packet;
@property int count;

- (id)initWithBSSID:(NSString *)bssid
            andSSID:(NSString *)ssid
        andPassword:(NSString *)password
    andTaskParameters:(ESPTaskParameter *)taskParameter
      withBroadcast:(BOOL)packet;

- (void)listen:(FlutterEventSink)sink;

- (void)cancel;

@end
