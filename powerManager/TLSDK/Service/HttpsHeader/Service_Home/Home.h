//
//  Home.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/19.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "https.h"

NS_ASSUME_NONNULL_BEGIN

@interface Home : NSObject

//获取能源概览数据 21
+ (void)getHome:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//根据时间获取能源趋势数据 22
+ (void)getEnergyTendency:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取当月环保效益 23
+ (void)getGreenBenifit:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取当月环保效益 24
+ (void)getWeather:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取
+ (void)getAllArea:(void(^)(id data))dataBLock;

//获取电池系统概览信息 25
+ (void)getStorge:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取电池系统详细信息 26
+ (void)getStargeDetail:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

@end

NS_ASSUME_NONNULL_END
