//
//  generation.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/20.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "generation.h"

@implementation generation

//获取用户所有区域信息 26
+ (void)getAreaInfo:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_AreaInfo Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[generation alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//获取指定区域的所有发电设备 27
+ (void)getGenerateElectricitys:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_GenerateElectricitys Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[generation alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//获取单个设备日月年发电量信息 28
+ (void)getGenerateElectricity:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_GenerateElectricity Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[generation alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

////获取用户所有设备信息接口 29
//+ (void)get:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
//    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_GenerateElectricity Success:^(id data) {
//        NSLog(@"data = %@",data);
//
//        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
//
//        if ([strcode isEqualToString:@"0"]) {
//            dataBLock(data);
//        }
//
//    } Failure:^(id errmessage) {
//        NSLog(@"error = %@",errmessage);
//        [[[[generation alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
//    }];
//}

//获取发电模块概览数据  30
+ (void)getGenerateEleOverview:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_GenerateEleOverview Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[generation alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//根据时间获取光伏系统发电信息和能源产耗   31
+ (void)getOutputAndInputOfEle:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_OutputAndInputOfEle Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[generation alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//根据时间获取储能系统能源信息、能源产耗、充放电信息 32
+ (void)getStorageSystemData:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_StorageSystemData Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[generation alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//添加采集器 33
+ (void)getAddCollector:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_AddCollector Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[generation alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

#pragma mark - 其他方法

- (UIViewController *)getCurrentVC  {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)  {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)  {
            if (tmpWin.windowLevel == UIWindowLevelNormal)  {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

//json转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
