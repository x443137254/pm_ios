//
//  TLMD5.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/6.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "TLMD5.h"

#import <CommonCrypto/CommonDigest.h>

@implementation TLMD5

+ (NSString *)getMD5HashWithMessage:(NSString*)message AndType:(md5Type)type{
    
    TLMD5 *md5 = [[TLMD5 alloc] init];
    if (type == Lowercase16bit) {
        return [md5 get16md5HashWithMessage:message];
    } else {
        return [md5 get16MD5HashWithMessage:message];
    }
}

- (NSString *)get16md5HashWithMessage:(NSString*)message{
    
    const char *cStr = [message UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, (unsigned)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

- (NSString *)get16MD5HashWithMessage:(NSString*)message{
    
    const char *cStr = [message UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, (unsigned)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
