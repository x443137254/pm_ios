//
//  TLMD5.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/6.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    Uppercase16bit = 0,
    Lowercase16bit,
} md5Type;

@interface TLMD5 : NSObject

+ (NSString *)getMD5HashWithMessage:(NSString*)message AndType:(md5Type)type;

@end
