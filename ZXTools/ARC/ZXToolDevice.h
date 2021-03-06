//
//  ZXToolDevice.h
//  ZXTools
//
//  Created by Max on 2020/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXToolDevice : NSObject

+ (NSString *)getDeviceCarrierName;
/**
 * 获取当前设备的通讯运营商标识
 */
+ (NSString *)getDeviceCarrierCode;

/**
 *  获取当前设备的网络通讯名称值
 */
+ (NSString *)getDeviceNetworkName;

/**
 *  获取当前设备的横向最大值
 */
+ (NSNumber *)getDeviceXMaxValue;

/**
 *  获取当前设备的纵向最大值
 */
+ (NSNumber *)getDeviceYMaxValue;

/**
 *  获取当前设备的横向分辨率值
 */
+ (NSNumber *)getDeviceXResolution;

/**
 *  获取当前设备的纵向分辨率值
 */
+ (NSNumber *)getDeviceYResolution;

/**
 *  获取当前设备的型号名称
 */
+ (NSString *)getDeviceModel;

/**
 *  获取当前设备的操作系统名称
 */
+ (NSString *)getDeviceOSName;

/**
 *  获取当前设备的操作系统版本号
 */
+ (NSString *)getDeviceOSVersion;

/**
 *  获取当前应用版本号
 */
+ (NSString *)getAppVersion;

/**
 *  获取当前应用版本号
 */
+ (NSString *)getBuildVersion;

/**
 *  获取当前设备的唯一编号
 */
+ (NSString *)getDeviceUUID;

/**
 *  获取当前应用名称
 */
+ (NSString *)getAppName;

/**
 *  获取当前应用BundleID
 */
+ (NSString *)getBundleID;

/// 跳转至系统设置
+ (BOOL)goApplicationOpenSettings;

/// 跳转至App Store下载页
+ (BOOL)goAppStoreDownload:(NSString *)appId;
/// 模态至APP内部下载页
+ (void)goAppModeDownload:(NSString *)appId viewController:(UIViewController *)viewController;

/// 跳转至App Store评价页
+ (BOOL)goAppStoreComment:(NSString *)appId;
@end

NS_ASSUME_NONNULL_END
