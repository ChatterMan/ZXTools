//
//  ZXToolUUID.h
//  ZXTools
//
//  Created by Max on 2020/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXToolUUID : NSObject

/**储存UUID在钥匙串*/
+ (void)saveUUIDToKeyChain;

/**从钥匙串读取UUID*/
+ (NSString *)readUUIDFromKeyChain;

/**从钥匙串删除UUID*/
+ (void)deletekeyChain;

@end

NS_ASSUME_NONNULL_END
