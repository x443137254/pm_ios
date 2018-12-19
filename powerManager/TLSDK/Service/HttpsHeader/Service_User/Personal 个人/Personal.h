//
//  Personal.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/18.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "https.h"
#import "networkingPublic.h"

@interface Personal : NSObject

//修改用户个人信息9
+ (void)getUpdateUser:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取电站信息维护10
//+ (void)getUpdateUser:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取电站信息维护11
+ (void)getElePrice:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//编辑电站信息 12
+ (void)getEditStation:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取电价配置信息 13
+ (void)getElePriceInfo:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//编辑电价配置信息 14
+ (void)getUpdateElePrice:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

//获取电站信息维护 15
+ (void)getAddElePrice:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

@end
