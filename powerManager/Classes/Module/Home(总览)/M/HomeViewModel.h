//
//  HomeViewModel.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/19.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *collectorNum;
@property (nonatomic, copy) NSString *collectorCheckCode;
@property (nonatomic, copy) NSString *thirdUnique;
@property (nonatomic, copy) NSString *appType;
@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *registTime;
@property (nonatomic, copy) NSString *uniqueId;
@property (nonatomic, copy) NSString *hasMsg;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *temprate;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *wind;
@property (nonatomic, copy) NSString *windD;
@property (nonatomic, copy) NSString *temp1;
@property (nonatomic, copy) NSString *temp2;
@property (nonatomic, copy) NSString *CO2;
@property (nonatomic, copy) NSString *Coal;
@property (nonatomic, copy) NSString *Tree;

@property (nonatomic,strong) NSMutableArray *photovoltaic_y;   //光伏产出
@property (nonatomic,strong) NSMutableArray *charger_y;    //电池发电
@property (nonatomic,strong) NSMutableArray *grid_y;   //电网取电
@property (nonatomic,strong) NSMutableArray *cost_y;   //用户消耗

@property (nonatomic,strong) NSMutableArray *photovoltaic_x;   //光伏产出
@property (nonatomic,strong) NSMutableArray *charger_x;    //电池发电
@property (nonatomic,strong) NSMutableArray *grid_x;   //电网取电
@property (nonatomic,strong) NSMutableArray *cost_x;   //用户消耗

/**
 当月发电
 */
@property (nonatomic, copy) NSString *ele_out;

/**
 当月电费
 */
@property (nonatomic, copy) NSString *ele_cost;

/**
 当月收益
 */
@property (nonatomic, copy) NSString *ele_earnings;

/**
 当月用电
 */
@property (nonatomic, copy) NSString *ele_in;

/**
 累计发电
 */
@property (nonatomic, copy) NSString *ele_out_total;

/**
 空调
 */
@property (nonatomic, copy) NSString *aircondition;

/**
 电表
 */
@property (nonatomic, copy) NSString *ameter;

/**
 逆变器
 */
@property (nonatomic, copy) NSString *inverter;

/**
 插座
 */
@property (nonatomic, copy) NSString *socket;

/**
 恒温器
 */
@property (nonatomic, copy) NSString *thermostat;

/**
 总负载功率
 */
@property (nonatomic, copy) NSString *devicesPower;

/**
 电网功率
 */
@property (nonatomic, copy) NSString *gridPower;

/**
 运行容量
 */
@property (nonatomic, copy) NSString *photovoltaicRuntimePower;

/**
 装机容量
 */
@property (nonatomic, copy) NSString *photovoltaicTheroyPower;

/**
 是否有储能系统
 */
@property (nonatomic, copy) NSString *storageSystem;

@end

NS_ASSUME_NONNULL_END
