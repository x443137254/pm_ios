//
//  NoticeInfo.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/18.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "NoticeInfo.h"

@implementation NoticeInfo

//分页获取通知信息 16
+ (void)getNotice:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_Notice Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[NoticeInfo alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//根据通知id获取详情数据 17
+ (void)getNoticeInfo:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_NoticeInfo Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[NoticeInfo alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//根据通知id获取详情数据 18
+ (void)getDevWarningNum:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_GetDevWarningNum Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[NoticeInfo alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
    }];
}

//按通知类型删除通知列表数据 19
+ (void)getDelNotice:(NSDictionary*)param Success:(void(^)(id data))dataBLock{
    [networkingPublic NoTokenAFNetworkingPublicUrl:param IsPost:NO ServiceUrl:CMD_DelNotice Success:^(id data) {
        NSLog(@"data = %@",data);
        
        NSString *strcode = [NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([strcode isEqualToString:@"0"]) {
            dataBLock(data);
        }
        
    } Failure:^(id errmessage) {
        NSLog(@"error = %@",errmessage);
        [[[[NoticeInfo alloc] init] getCurrentVC].view makeToast:errmessage duration:1.7];
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
