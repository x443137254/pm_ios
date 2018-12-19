//
//  UserLogin.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/6.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLogin : NSObject

//注册
+ (void)getRegister:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//用户是否存在
+ (void)getAccountExit:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//第三方账号登录
+ (void)getLoginSDK:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//通过手机号发送验证码
+ (void)getCodePhone:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//获取所有省市区字段
+ (void)getStrCountry:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//第三方注册或绑定
+ (void)getRegisterSDK:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//获取国家列表接口
+ (void)getCountryList:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//用户登录
+ (void)getLogin:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

@end
