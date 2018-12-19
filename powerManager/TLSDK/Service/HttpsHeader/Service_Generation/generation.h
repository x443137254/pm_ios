//
//  generation.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/20.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "https.h"

NS_ASSUME_NONNULL_BEGIN

@interface generation : NSObject

//获取用户所有区域信息 26
+ (void)getAreaInfo:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取指定区域的所有发电设备 27
+ (void)getGenerateElectricitys:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取单个设备日月年发电量信息 28
+ (void)getGenerateElectricity:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

////获取用户所有设备信息接口 29
//+ (void)getAreaInfo:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取发电模块概览数据  30
+ (void)getGenerateEleOverview:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//根据时间获取光伏系统发电信息和能源产耗   31
+ (void)getOutputAndInputOfEle:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//
//根据时间获取储能系统能源信息、能源产耗、充放电信息 32
+ (void)getStorageSystemData:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//
//添加采集器 33
+ (void)getAddCollector:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

@end

NS_ASSUME_NONNULL_END
