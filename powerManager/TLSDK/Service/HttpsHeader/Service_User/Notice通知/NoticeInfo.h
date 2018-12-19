//
//  NoticeInfo.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/18.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "https.h"

@interface NoticeInfo : NSObject

//分页获取通知信息 16
+ (void)getNotice:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//根据通知id获取详情数据 17
+ (void)getNoticeInfo:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//根据通知id获取详情数据 18
+ (void)getDevWarningNum:(NSDictionary*)param Success:(void(^)(id data))dataBLock;
//按通知类型删除通知列表数据 19
+ (void)getDelNotice:(NSDictionary*)param Success:(void(^)(id data))dataBLock;

@end
