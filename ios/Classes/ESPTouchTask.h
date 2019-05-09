//
//  ESPTouchTask.h
//  EspTouchDemo
//
//  Created by 白 桦 on 4/14/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESPTouchResult.h"
#import "ESPTouchDelegate.h"
#import "ESPAES.h"
#import "ESPTouchTaskParameter.h"

#define ESPTOUCH_VERSION    @"v0.3.7.0"

#define DEBUG_ON   YES

@interface ESPTouchTask : NSObject

@property(atomic, assign) BOOL isCancelled;

- (id)initWithApSsid:(NSString *)apSsid andApBssid:(NSString *)apBssid andApPwd:(NSString *)apPwd andAES:(ESPAES *)aes andTaskParameter:(ESPTaskParameter *) taskParameter;

- (id)initWithApSsid:(NSString *)apSsid andApBssid:(NSString *)apBssid andApPwd:(NSString *)apPwd andAES:(ESPAES *)aes;

/**
 * Constructor of EsptouchTask
 * @param apSsid the Ap's ssid
 * @param apBssid the Ap's bssid
 * @param apPwd the Ap's password
 */
- (id)initWithApSsid:(NSString *)apSsid andApBssid:(NSString *)apBssid andApPwd:(NSString *)apPwd;

/**
 * @deprecated
 */
- (id)initWithApSsid:(NSString *)apSsid andApBssid:(NSString *)apBssid andApPwd:(NSString *)apPwd andIsSsidHiden:(BOOL)isSsidHidden __deprecated_msg("Use initWithApSsid:(NSString *) andApBssid:(NSString *) andApPwd:(NSString *) instead.");

/**
 * Constructor of EsptouchTask
 * @param apSsid the Ap's ssid
 * @param apBssid the Ap's bssid
 * @param apPwd the Ap's password
 * @param timeoutMillisecond millisecond of total timeout (it should be >= 15000+6000)
 */
- (id)initWithApSsid:(NSString *)apSsid andApBssid:(NSString *)apBssid andApPwd:(NSString *)apPwd andTimeoutMillisecond:(int)timeoutMillisecond;

/**
 * Constructor of EsptouchTask
 * @param apSsid the Ap's ssid
 * @param apBssid the Ap's bssid
 * @param apPwd the Ap's password
 * @param isSsidHidden whether the Ap's ssid is hidden
 * @param timeoutMillisecond millisecond of total timeout (it should be >= 15000+6000)
 */
- (id)initWithApSsid:(NSString *)apSsid andApBssid:(NSString *)apBssid andApPwd:(NSString *)apPwd andIsSsidHiden:(BOOL)isSsidHidden andTimeoutMillisecond:(int)timeoutMillisecond  __deprecated_msg("Use initWithApSsid:(NSString *) andApBssid:(NSString *) andApPwd:(NSString *) andTimeoutMillisecond:(int) instead.");

/**
 * Interrupt the Esptouch Task when User tap back or close the Application.
 */
- (void)interrupt;

/**
 * Note: !!!Don't call the task at UI Main Thread
 * Smart Config v2.4 support the API
 * @return the ESPTouchResult
 */
- (ESPTouchResult *)executeForResult;

/**
 * Note: !!!Don't call the task at UI Main Thread
 * Smart Config v2.4 support the API
 * It will be blocked until the client receive result count >= expectTaskResultCount.
 * If it fail, it will return one fail result will be returned in the list.
 * If it is cancelled while executing,
 *     if it has received some results, all of them will be returned in the list.
 *     if it hasn't received any results, one cancel result will be returned in the list.
 * @param expectTaskResultCount
 *            the expect result count(if expectTaskResultCount <= 0,
 *            expectTaskResultCount = INT32_MAX)
 * @return the NSArray of EsptouchResult
 * @throws RuntimeException
 */
- (NSArray *)executeForResults:(int)expectTaskResultCount;

/**
 * set the esptouch delegate, when one device is connected to the Ap, it will be called back
 * @param esptouchDelegate when one device is connected to the Ap, it will be called back
 */
- (void)setEsptouchDelegate:(NSObject <ESPTouchDelegate> *)esptouchDelegate;

/**
 * Set broadcast or multicast when post config info
 * @param broadcast YES is broadcast, NO is multicast
 */
- (void)setPackageBroadcast:(BOOL)broadcast;
@end
