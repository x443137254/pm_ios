//
//  https.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/6.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#ifndef https_h
#define https_h


//正式
#define http @"http://energy.growatt.com/energy/"

#import "AFNetworking.h"
#import "JSONKit.h"
#import "httpContent.h"
#import "common.h"


#pragma mark - 注册登录模块
//用户注册 1
#define CMD_Register                     [NSString stringWithFormat:@"%@regist",http]
//判断用户名是否存在 2
#define CMD_AccountExist                 [NSString stringWithFormat:@"%@accountExist",http]
//第三方账号登录 3
#define CMD_LoginSDK                     [NSString stringWithFormat:@"%@thirdLogin",http]
//通过手机发送验证码 4
#define CMD_sendCode                     [NSString stringWithFormat:@"%@sendCode",http]
//获取所有省市区字段 5
#define CMD_strCountry                   [NSString stringWithFormat:@"%@allArea",http]
//第三方账号（微信、QQ）注册 6
#define CMD_thirdRegist                  [NSString stringWithFormat:@"%@thirdRegist",http]
//获取国家列表接口 7
#define CMD_CountryList                  [NSString stringWithFormat:@"%@countryList",http]
//用户登录 8
#define CMD_Login                        [NSString stringWithFormat:@"%@login",http]

#pragma mark - 我的（个人中心模块）
//修改用户个人信息 9
#define CMD_UpdateUser                   [NSString stringWithFormat:@"%@updateUser",http]
//获取电站信息维护 10
#define CMD_                             [NSString stringWithFormat:@"%@",http]
//获取定义的峰谷等电价类型 11
#define CMD_ElePrice                     [NSString stringWithFormat:@"%@elePrice",http]
//编辑电站信息 12

//获取电价配置信息 13
#define CMD_ElePriceInfo                 [NSString stringWithFormat:@"%@elePriceInfo",http]
//编辑电价配置信息 14
#define CMD_UpdateElePrice               [NSString stringWithFormat:@"%@elePrice",http]
//新增电价配置信息 15
#define CMD_AddElePrice                  [NSString stringWithFormat:@"%@updateUser",http]

#pragma mark - 通知模块
//分页获取通知信息 16
#define CMD_Notice                       [NSString stringWithFormat:@"%@notice",http]
//根据通知id获取详情数据 17
#define CMD_NoticeInfo                   [NSString stringWithFormat:@"%@noticeInfo",http]
//获取各种设备类型 18
#define CMD_GetDevWarningNum             [NSString stringWithFormat:@"%@getDevWarningNum",http]
//按通知类型删除通知列表数据 19
#define CMD_DelNotice                    [NSString stringWithFormat:@"%@delNotice",http]

#pragma mark - 首页模块
//获取能源概览数据 20
#define CMD_Home                         [NSString stringWithFormat:@"%@home",http]
//根据时间获取能源趋势数据（多种类型个时间节点图标） 21
#define CMD_EnergyTendency               [NSString stringWithFormat:@"%@energyTendency",http]
//获取当月环保数据 22
#define CMD_GreenBenifit                 [NSString stringWithFormat:@"%@greenBenifit",http]
//获取天气信息（可以返回多日或近期一周）23
#define CMD_Weather                      [NSString stringWithFormat:@"%@weather",http]
//获取电池系统概览信息（储能系统才有） 24
#define CMD_Storge                       [NSString stringWithFormat:@"%@storge",http]
//获取电池系统详细信息 25
#define CMD_StargeDetail                 [NSString stringWithFormat:@"%@stargeDetail",http]

#pragma mark - 发电模块
//获取用户所有区域信息 26
#define CMD_AreaInfo                     [NSString stringWithFormat:@"%@areaInfo",http]
//获取指定区域的所有发电设备 27
#define CMD_GenerateElectricitys         [NSString stringWithFormat:@"%@generateElectricitys",http]
//获取单个设备日月年发电量信息 28
#define CMD_GenerateElectricity          [NSString stringWithFormat:@"%@generateElectricity",http]
//获取用户所有设备信息接口 29
#define CMD_       [NSString stringWithFormat:@"%@",http]
//获取发电模块概览数据 30
#define CMD_GenerateEleOverview          [NSString stringWithFormat:@"%@generateEleOverview",http]
//根据时间获取光伏系统发电信息和能源产耗 31
#define CMD_OutputAndInputOfEle          [NSString stringWithFormat:@"%@outputAndInputOfEle",http]
//根据时间获取储能系统能源信息、能源产耗、充放电信息 32
#define CMD_StorageSystemData            [NSString stringWithFormat:@"%@storageSystemData",http]
//添加采集器 33
#define CMD_AddCollector                 [NSString stringWithFormat:@"%@addCollector",http]


#pragma mark - 能耗模块
//根据时间（日月年）获取能耗电量信息 34
#define CMD_EleCost                      [NSString stringWithFormat:@"%@eleCost",http]
//获取用户所有设备信息接口 35
#define CMD_AreaEleRank                  [NSString stringWithFormat:@"%@areaEleRank",http]
//根据区域id和时间（日月年）获取区域详细耗电量信息 36
#define CMD_AreaEleInfo                  [NSString stringWithFormat:@"%@areaEleInfo",http]
//获取区域实时功率信息 37
#define CMD_RealTimePower                [NSString stringWithFormat:@"%@realTimePower",http]
//根据时间获取用户所有能耗设备概览数据 38
#define CMD_DevRunningState              [NSString stringWithFormat:@"%@devRunningState",http]
//根据设备类型获取能耗列表详细数据 39
#define CMD_DevsDetailInfo               [NSString stringWithFormat:@"%@devsDetailInfo",http]
//根据设备id和时间获取能耗详细数据 40
#define CMD_DevEleCost                   [NSString stringWithFormat:@"%@devEleCost",http]
//修改单个设备各参数信息 41
#define CMD_           [NSString stringWithFormat:@"%@",http]
//根据设备类型和时间（日月年）获取单种设备类型日月年能耗数据 42
#define CMD_DevTypeEleCost               [NSString stringWithFormat:@"%@devTypeEleCost",http]


#pragma mark - 分析模块
//获取当前用户下电表设备列表信息 43
#define CMD_Ammeters                     [NSString stringWithFormat:@"%@ammeters",http]
//根据电表id和时间获取电表 44
#define CMD_QualityData                  [NSString stringWithFormat:@"%@qualityData",http]
//获取能源分析概览数据 45
#define CMD_AnalysisData                 [NSString stringWithFormat:@"%@analysisData",http]
//根据时间获取能源分析详情数据 46
#define CMD_AnalysisInfo                 [NSString stringWithFormat:@"%@analysisInfo",http]

#pragma mark - 更新模块
//App内部更新说明 47


#endif /* https_h */
