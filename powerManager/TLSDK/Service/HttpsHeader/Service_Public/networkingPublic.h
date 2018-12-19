//
//  networkingPublic.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/6.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface networkingPublic : NSObject

//网络请求

/**
 AFN底层传输方法第一层封装

 @param param NSDictionary * 传参
 @param isPost Bool 是否需要带post
 @param ServiceUrl NSString * 传参地址
 @param dataBLock 返回成功的信息
 @param failBLock 返回失败的信息
 */

+ (void)NoTokenAFNetworkingPublicUrl:(NSDictionary*)param IsPost:(BOOL)isPost ServiceUrl:(NSString*) ServiceUrl Success:(void(^)(id data))dataBLock Failure:(void(^)(id errmessage))failBLock;

@end
