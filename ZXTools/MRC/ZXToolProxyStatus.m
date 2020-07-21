//
//  ZXToolProxyStatus.m
//  ZXTools
//
//  Created by Max on 2020/7/21.
//

#import "ZXToolProxyStatus.h"
#import <CFNetwork/CFProxySupport.h>
@implementation ZXToolProxyStatus
//需要设置为MRC的程序添加 -fno-objc-arc

+ (BOOL)getProxyStatus:(NSString *)url {
    NSDictionary *proxySettings = NSMakeCollectable([(NSDictionary *)CFNetworkCopySystemProxySettings() autorelease]);
    NSArray *proxies = NSMakeCollectable([(NSArray *)CFNetworkCopyProxiesForURL((CFURLRef)[NSURL URLWithString:url], (CFDictionaryRef)proxySettings) autorelease]);
    NSDictionary *settings = [proxies objectAtIndex:0];
    NSLog(@"判断是否设置代理");
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        //没有设置代理
        return NO;
    }
    else
    {
        //设置代理了
        return YES;
    }
}

@end
