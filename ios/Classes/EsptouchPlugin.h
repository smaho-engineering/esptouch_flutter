#import <Flutter/Flutter.h>
#import "EsptouchTaskUtil.h"

@interface EsptouchPlugin : NSObject <FlutterPlugin>
@end

@interface EsptouchResultsStreamHandler : NSObject <FlutterStreamHandler>

@property EsptouchTaskUtil *taskUtil;

@end
