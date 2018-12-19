//
//  UserLogin.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/6.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "UserLogin.h"
#import "https.h"


@implementation UserLogin
#pragma mark用户注册
+ (void)getRegister:(NSDictionary *)param Success:(void (^)(id))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param
                                            IsPost:NO
                                        ServiceUrl:CMD_Register
                                           Success:^(id data)
    {
        NSLog(@"data = %@",data);
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSString *strdata = [NSString stringWithFormat:@"%@",data[@"data"]];
        if ([strcode isEqualToString:@"0"]) {
            if([strdata isEqualToString:@"1"]) {
                dataBLock(@"Success");
            }
        } else {
            NSLog(@"%@",@"something wrong happend");
        }
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[UserLogin alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}
#pragma mark判断用户名是否存在
+ (void)getAccountExit:(NSDictionary *)param Success:(void (^)(id))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param
                                            IsPost:NO
                                        ServiceUrl:CMD_AccountExist
                                           Success:^(id data) {
        NSLog(@"data = %@",data);
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSString *strdata = [NSString stringWithFormat:@"%@",data[@"data"]];
        if ([strcode isEqualToString:@"0"]) {
            if ([strdata isEqualToString:@"0"]) {
                dataBLock(@"账号可用");
            } else {
                dataBLock(@"账号已存在");
            }
        }
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[UserLogin alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}
#pragma mark第三方登录
+ (void)getLoginSDK:(NSDictionary *)param Success:(void (^)(id))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param
                                            IsPost:NO
                                        ServiceUrl:CMD_LoginSDK
                                           Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSString *strdata = [NSString stringWithFormat:@"%@",data[@"data"]];
        
            dataBLock(@"Success");
        
    } Failure:^(id errmessage) {
//        NSLog(@"error = %@",errmessage);
        dataBLock(errmessage);
    }];
}
#pragma mark通过手机号发送验证码
+ (void)getCodePhone:(NSDictionary *)param Success:(void (^)(id))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param
                                            IsPost:NO
                                        ServiceUrl:CMD_sendCode
                                           Success:^(id data)
    {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        NSString *strdata = [NSString stringWithFormat:@"%@",data[@"data"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
    }];
}
//#pragma mark获取所有省市区字段
//+ (void)getStrCountry:(NSDictionary *)param Success:(void (^)(id))dataBLock{
//    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:YES ServiceUrl:CMD_strCountry Success:^(id data) {
//        NSLog(@"data = %@",data);
//
//        UserLogin *userlogin = [[UserLogin alloc] init];
//        NSDictionary *dic = [userlogin dictionaryWithJsonString:data];
//        if ([[dic objectForKey:@"data"] isEqualToString:@"0"]) {
//            dataBLock(@"Success");
//        }
//
//    } Failure:^(id errmessage) {
//        NSLog(@"error = %@",errmessage);
//    }];
//}

#pragma mark三方注册绑定
+ (void)getRegisterSDK:(NSDictionary *)param Success:(void (^)(id))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_thirdRegist Success:^(id data) {

        NSLog(@"data = %@",data);

        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
//        NSString *strdata = [NSString stringWithFormat:@"%@",data[@"data"]];

        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }

    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
         [[[[UserLogin alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//#pragma mark获取国家列表接口
//+ (void)getCountryList:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
//    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:YES ServiceUrl:CMD_CountryList Success:^(id data) {
//        NSLog(@"data = %@",data);
//        UserLogin *userlogin = [[UserLogin alloc] init];
//        NSDictionary *dic = [userlogin dictionaryWithJsonString:data];
//        if ([[dic objectForKey:@"data"] isEqualToString:@"0"]) {
//            dataBLock(@"Success");
//        }
//    } Failure:^(id errmessage) {
//        NSLog(@"error = %@",errmessage);
//    }];
//}

#pragma mark用户登录

+ (void)getLogin:(NSDictionary*)param Success:(void(^)(id data))dataBLock
{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param
                                            IsPost:NO
                                        ServiceUrl:CMD_Login
                                           Success:^(id data)
    {
                                                
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
    
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[UserLogin alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

#pragma mark - 其他方法
//Toast方式展示错误信息
- (void)showErrorMessageWith:(NSString *)error
{
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
