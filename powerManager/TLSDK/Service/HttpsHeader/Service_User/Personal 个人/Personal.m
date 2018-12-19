//
//  Personal.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/18.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "Personal.h"

@implementation Personal

//用户信息更新 9
+ (void)getUpdateUser:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_UpdateUser Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Personal alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//获取电站信息维护 10

//获取定义的峰谷等电价信息 11
+ (void)getElePrice:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_ElePrice Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Personal alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//编辑电站信息 12

//获取电价配置信息 13
+ (void)getElePriceInfo:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_ElePriceInfo Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Personal alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//编辑电价配置信息 14
+ (void)getUpdateElePrice:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_UpdateElePrice Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Personal alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//新增电价信息 15
+ (void)getAddElePrice:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_AddElePrice Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
     
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[Personal alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}




#pragma mark - 其他方法
//Toast方式展示错误信息
- (void)showErrorMessageWith:(NSString *)error{
    [[self getCurrentVC].view makeToast:error duration:1.7];
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
