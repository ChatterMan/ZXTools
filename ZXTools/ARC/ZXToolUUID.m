//
//  ZXToolUUID.m
//  ZXTools
//
//  Created by Max on 2020/7/20.
//

#import "ZXToolUUID.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCrypto.h>
static NSString * const kPDDictionaryKey = @"com.qnvip.ypcx.dictionaryKey";
static NSString * const kPDKeyChainKey = @"com.qnvip.ypcx.keychainKey";
@implementation ZXToolUUID
#pragma mark - 钥匙串管理
+ (void)keyChainSave:(NSString *)service {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:service forKey:kPDDictionaryKey];
    [self save:kPDKeyChainKey data:tempDic];
}

+ (NSString *)keyChainLoad{
    NSMutableDictionary *tempDic = (NSMutableDictionary *)[self load:kPDKeyChainKey];
    return [tempDic objectForKey:kPDDictionaryKey];
}

+ (void)keyChainDelete{
    [self delete:kPDKeyChainKey];
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

#pragma mark - UUID + 钥匙串唯一标识

+ (void)saveUUIDToKeyChain {
    //如果更新了provisioning profile的话, Keychain data会丢失.所以我们应该将UUID在NSUserDefault备份.
    NSString *string = [self readUUIDFromKeyChain];
    if ([string isEqualToString:@""] || !string) {
        NSString *UUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
        if (UUID) {
             [self keyChainSave:UUID];
        }else {
            
            NSString *uuid = [self getUUIDString];
            [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"UUID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self keyChainSave:uuid];
        }
    } else {
        NSLog(@"%@",string);
        NSString *UUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
        if (![UUID isEqualToString:string]) {
            [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"UUID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

+ (NSString *)readUUIDFromKeyChain {
    
    return [self keyChainLoad];
}

+ (void)deletekeyChain {
    [self keyChainDelete];
}

+ (NSString *)getUUIDString {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"-%.0f", time];
    NSString *uuid = [[[NSUUID UUID] UUIDString] stringByAppendingString:timeString];
    
    NSString *md5_uuid = [self MD5Value:uuid];
    
    return md5_uuid;
}

+ (NSString *)MD5Value:(NSString *)str{
    if (str==nil) {
        return nil;
    }
    
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSString *output = [NSString stringWithFormat:
                        @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                        result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
                        ];
    NSLog(@"md5:%@",output);
    return output;
    
}

@end
