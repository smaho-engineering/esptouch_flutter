//
//  ESPNetUtil.h
//  EspTouchDemo
//
//  Created by 白 桦 on 5/15/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESP_NetUtil : NSObject

/**
 * Get local IPv4
 * @return local ip v4 or nil
 */
+ (NSString *)getLocalIPv4;

/**
 * Get local IPv6
 * @return local ip v6 or nil
 */
+ (NSString *)getLocalIPv6;

/**
 * Check whether the ipAddr is IPv4
 * @return whether the ipAddr is IPv4
 */
+ (BOOL)isIPv4Addr:(NSString *)ipAddr;

/**
 * Checks whether the ipAddr (IPv4) is private
 * @return whether the ipAddr is private
 */
+ (BOOL)isIPv4PrivateAddr:(NSString *)ipAddr;

/**
 * Get the local IP address by local inetAddress ip4
 * @param localInetAddr4 local inetAddress ip4
 */
+ (NSData *)getLocalInetAddress4ByAddr:(NSString *)localInetAddr4;

/**
 * Get the invented local ip address by local port
 */
+ (NSData *)getLocalInetAddress6ByPort:(int)localPort;

/**
 * Parse InetAddress
 */
+ (NSData *)parseInetAddrByData:(NSData *)inetAddrData andOffset:(int)offset andCount:(int)count;

/**
 * Description inetAddrData for pretty-print IPv4
 */
+ (NSString *)descriptionInetAddr4ByData:(NSData *)inetAddrData;

/**
 * Description inetAddrData for pretty-print IPv6
 */
+ (NSString *)descriptionInetAddr6ByData:(NSData *)inetAddrData;

/**
 * Parse bssid
 * @param bssid the bssid
 * @return byte converted from bssid
 */
+ (NSData *)parseBssid2bytes:(NSString *)bssid;

/**
 * Send a dummy GET to "https://8.8.8.8" just to get Network Permission after ios10.0(including)
 */
+ (void)tryOpenNetworkPermission;

@end
