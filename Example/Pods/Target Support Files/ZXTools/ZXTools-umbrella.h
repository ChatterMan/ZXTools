#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZXToolDevice.h"
#import "ZXToolFileManger.h"
#import "ZXTools.h"
#import "ZXToolUUID.h"
#import "ZXToolProxyStatus.h"

FOUNDATION_EXPORT double ZXToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char ZXToolsVersionString[];

