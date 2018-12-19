//
//  Home.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/19.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "Home.h"

@implementation Home

//获取能源概览数据 20
+ (void)getHome:(NSDictionary*)param Success:(void(^)(id data))dataBLock
{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_Home Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Home alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//根据时间获取能源趋势数据 21
+ (void)getEnergyTendency:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_EnergyTendency Success:^(id data) {
        //NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Home alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//获取当月环保效益 22
+ (void)getGreenBenifit:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_GreenBenifit Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Home alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//获得省市区数据
+ (void)getAllArea:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:[NSDictionary new] IsPost:NO ServiceUrl:CMD_strCountry Success:^(id data) {
        //NSLog(@"data = %@",data);
        
//        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
//
//        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
//        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Home alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//获取天气数据 23
+ (void)getWeather:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_Weather Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];

        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Home alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//获取电池系统概览信息 24
+ (void)getStorge:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_Storge Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Home alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

/**
 获取当前屏幕显示的viewcontroller
 @return 当前控制器
 */
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
