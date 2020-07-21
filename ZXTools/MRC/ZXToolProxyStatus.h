//
//  ZXToolProxyStatus.h
//  ZXTools
//
//  Created by Max on 2020/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXToolProxyStatus : NSObject
/// YES 已设置代理 NO 未设置代理
+ (BOOL)getProxyStatus:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
