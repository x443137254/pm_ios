//
//  Time.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/18.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject


/**
 时间戳转时间

 @param str 需要转换的时间戳
 @return 返回已经转好的时间
 */

+ (NSString *)getDateStringWithTimeStr:(NSString *)str;

@end
