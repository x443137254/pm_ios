//
//  Time.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/18.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "Time.h"

@implementation Time


+ (NSString *)getDateStringWithTimeStr:(NSString *)str{
    return [[[Time alloc] init] getDateStringWithTimeStr:str];
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SS"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

@end
