//
//  ZXToolDevice.m
//  ZXTools
//
//  Created by Max on 2020/7/20.
//

#import "ZXToolDevice.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Security/Security.h>
#import <sys/utsname.h>
#import "ZXToolUUID.h"
#import <StoreKit/StoreKit.h>
@implementation ZXToolDevice
/*获取当前设备的IMSI值*/
+ (NSString *)getDeviceIMSIValue
{
    return nil;
}

/*获取当前设备的IMEI值*/
+ (NSString *)getDeviceIMEIValue
{
    return nil;
}

/*获取当前设备的MacId值*/
+ (NSString *)getDeviceMacIdValue
{
    return nil;
}

/*获取当前设备的通讯运营商名称
 @return 返回运营商标示符(成功返回标示符,失败返回nil)
 
 中国移动 00 02 07
 中国联通 01 06
 中国电信 03 05
 中国铁通 20
 */
+ (NSString *)getDeviceCarrierCode
{
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *network_carrier_code = [carrier mobileNetworkCode];
    NSString *network_country_code = [carrier mobileCountryCode];
    
    if (network_carrier_code) {
        return [NSString stringWithFormat:@"%@%@",network_country_code,network_carrier_code];
    } else {
        return @"NULL";
    }

}

+ (NSString *)getDeviceCarrierName
{
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *network_carrier_name = [carrier carrierName];
    
    if (network_carrier_name) {
        return network_carrier_name;
    } else {
        return @"NULL";
    }

}


/*获取当前设备的网络通讯名称值*/
+ (NSString *)getDeviceNetworkName
{
    /*
        CTRadioAccessTechnologyGPRS             //介于2G和3G之间(2.5G)
        CTRadioAccessTechnologyEdge             //GPRS到第三代移动通信的过渡(2.75G)
        CTRadioAccessTechnologyWCDMA
        CTRadioAccessTechnologyHSDPA            //亦称为3.5G(3?G)
        CTRadioAccessTechnologyHSUPA            //3G到4G的过度技术
        CTRadioAccessTechnologyCDMA1x           //3G
        CTRadioAccessTechnologyCDMAEVDORev0     //3G标准
        CTRadioAccessTechnologyCDMAEVDORevA
        CTRadioAccessTechnologyCDMAEVDORevB
        CTRadioAccessTechnologyeHRPD            //电信一种3G到4G的演进技术(3.75G)
        CTRadioAccessTechnologyLTE              //接近4G
     */
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    NSString * networkName = [info currentRadioAccessTechnology];
    
    return networkName ? networkName : @"NULL";
}

/*获取当前设备的横向最大值*/
+ (NSNumber *)getDeviceXMaxValue
{
    CGFloat xoffset = CGRectZero.origin.x;
    xoffset = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    return [NSNumber numberWithFloat:xoffset];
}

/*获取当前设备的纵向最大值*/
+ (NSNumber *)getDeviceYMaxValue
{
    CGFloat yoffset = CGRectZero.origin.x;
    yoffset = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    return [NSNumber numberWithFloat:yoffset];
}

/*获取当前设备的横向分辨率值*/
+ (NSNumber *)getDeviceXResolution
{
    CGFloat width = CGRectZero.size.width;
    CGFloat scale = [[UIScreen mainScreen] scale];
    width = [[[self class] getDeviceXMaxValue] floatValue];
    return [NSNumber numberWithFloat:(width * scale)];
}

/*获取当前设备的纵向分辨率值*/
+ (NSNumber *)getDeviceYResolution
{
    CGFloat height = CGRectZero.size.height;
    CGFloat scale = [[UIScreen mainScreen] scale];
    height = [[[self class] getDeviceYMaxValue] floatValue];
    return [NSNumber numberWithFloat:(height * scale)];
}

/*获取当前设备的型号名称*/
+ (NSString *)getDeviceModel
{
    NSString *platform = nil;
    struct utsname systemInfo;
    uname(&systemInfo);
    platform = [NSString stringWithCString:systemInfo.machine
                                  encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@",platform];
}

/*获取当前设备的操作系统名称*/
+ (NSString *)getDeviceOSName
{
    return @"ios";
}

/*获取当前设备的操作系统版本号*/
+ (NSString *)getDeviceOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

/**
 *  获取当前应用版本号
 */
+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appCurVersion;
}

+ (NSString *)getBuildVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *buildCurVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    return buildCurVersion;
}

/*获取当前设备的唯一编号*/
+ (NSString *)getDeviceUUID
{
    NSString *uuid = [ZXToolUUID readUUIDFromKeyChain];
    
    if (!uuid) {
        [ZXToolUUID saveUUIDToKeyChain];
    } else {
        return uuid;
    }
    return [ZXToolUUID readUUIDFromKeyChain];
}

/**
 *  获取当前应用名称
 */
+ (NSString *)getAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

/**
 *  获取当前应用BundleID
 */
+ (NSString *)getBundleID {
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    return bundleID;
}


+ (BOOL)goApplicationOpenSettings {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)goAppStoreDownload:(NSString *)appId {
    NSString *urlPath = [appId containsString:@"http"] ? appId : [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", appId];
    NSURL *url = [NSURL URLWithString:urlPath];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        return YES;
    } else {
        return NO;
    }
}

+ (void)goAppModeDownload:(NSString *)appId viewController:(UIViewController *)viewController{
    NSDictionary *appParameters = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];

    SKStoreProductViewController *productViewController = [[SKStoreProductViewController alloc] init];
    [productViewController setDelegate:viewController];
    [productViewController loadProductWithParameters:appParameters completionBlock:^(BOOL result, NSError *error) { }];
    [viewController presentViewController:productViewController animated:YES completion:^{ }];
}

+ (BOOL)goAppStoreComment:(NSString *)appId {
    
    NSString *urlPath = [appId containsString:@"http"] ? appId : [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appId];
    NSURL *url = [NSURL URLWithString:urlPath];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        return YES;
    } else {
        return NO;
    }
}

@end
