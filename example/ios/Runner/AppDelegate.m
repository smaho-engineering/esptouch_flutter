#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "SystemConfiguration/CaptiveNetwork.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application
didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"eng.smaho.com/esptouch_plugin/example" binaryMessenger:controller];
  __weak typeof(self) weakSelf = self;
  [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
    if ([@"ssid" isEqualToString:call.method]) {
      NSString *ssid = [weakSelf getSSID];
      result(ssid);
      return;
    }
    if ([@"bssid" isEqualToString:call.method]) {
      NSString *bssid = [weakSelf getBSSID];
      result(bssid);
      return;
    }
  }];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

/**
 Look up network information value by key.
 
 Inspired by: https://stackoverflow.com/a/20836590
 @param key one of SSID, BSSID or SSIDData
 @return the value of the requested network information key
 */
- (NSString*)findNetworkInfo:(NSString*) key {
  NSArray* interfaceNames = (__bridge_transfer id)CNCopySupportedInterfaces();
  for (NSString* interfaceName in interfaceNames) {
    NSDictionary* networkInfo = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName);
    if (networkInfo[key]) {
      return networkInfo[key];
    }
  }
  return nil;
}


/**
 Get BSSID of the current Wi-Fi network
 @return BSSID string, e.g: "22:a1:b2:c3:d4:e5"
 */
- (NSString*)getBSSID {
  return [self findNetworkInfo:@"BSSID"];
}

/**
 Get SSID of the current Wi-Fi network
 @return BSSID string, e.g: "Vince's iPhone"
 */
- (NSString*)getSSID {
  return [self findNetworkInfo:@"SSID"];
}

@end
