//
//  networkingPublic.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/6.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "networkingPublic.h"
#import "https.h"

@implementation networkingPublic

//网络请求
//带token
//+ (void)WithTokenAFNetworkingPublicUrl:(NSDictionary*)param  IsPost:(BOOL)isPost ServiceUrl:(NSString*) ServiceUrl Success:(void(^)(id data))dataBLock Failure:(void(^)(id errmessage))failBLock{
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js",@"application/x-javascript", nil];
//    NSMutableDictionary *dic  = [NSMutableDictionary dictionaryWithDictionary:RequestDicWithToken];
//    if (isPost) {
//        [dic setObject:param forKey:@"post"];
//    }else{
//
//        [dic addEntriesFromDictionary:param];
//
//    }
//    NSLog(@"AFNetworkingPublicUrl ServiceUrl = %@ dic = %@",ServiceUrl,dic);
//
//    [manager POST:ServiceUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if ([[NSString stringWithFormat:@"%@",responseObject[@"status"]]isEqualToString:@"20002"]){
//
//            NSLog(@"token过期");
//
//
//        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"status"]]isEqualToString:@"10001"]){
//
//            dataBLock(responseObject);
//
//        }else{
//
//
//
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"error = %@",error);
//        failBLock(@"failure");
//
//    }];
//}

//不带token


/**
 对AFN第一层封装

 @param param 传过来的字典
 @param isPost 是否带post（无用）
 @param ServiceUrl 接口网址
 @param dataBLock 成功后的返回值
 @param failBLock 失败后的返回值
 */
+ (void)NoTokenAFNetworkingPublicUrl:(NSDictionary*)param IsPost:(BOOL)isPost ServiceUrl:(NSString*) ServiceUrl Success:(void(^)(id data))dataBLock Failure:(void(^)(id errmessage))failBLock
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer =  [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js",@"application/x-javascript",@"application/x-www-form-urlencoded; charset=utf-8", nil];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//
//    manager.requestSerializer.timeoutInterval = 10;
    
    NSMutableDictionary *dic  = [NSMutableDictionary dictionaryWithDictionary:RequestDicWithoutToken];
    
    if (isPost) {
        [dic setObject:param forKey:@"post"];
    }else{

        [dic addEntriesFromDictionary:param];

    }
//    NSDictionary *dic = param;
    
    NSLog(@"NoTokenPublicUrl ServiceUrl = %@\n dic = %@",ServiceUrl,dic);
    
    [manager POST:ServiceUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"msg = %@  status = %@",responseObject[@"msg"],responseObject[@"status"]);
  //      NSLog(@"response = %@",responseObject);
//        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]]isEqualToString:@"20002"]){
//
//            NSLog(@"token过期");
//
//        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]]isEqualToString:@"0"]){
//
            dataBLock(responseObject);
//
//        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]]isEqualToString:@"1"]){
//
//            failBLock(responseObject[@"data"]);
//
//        } else {
//
//            failBLock(@"failure");
//
//        }
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
       
        failBLock(@"failure");
        
    }];
    
}


/**
 字典转json

 @param dict 传递的字典
 @return 返回jsonstring
 */
-(NSString *)convertToJsonData:(NSDictionary *)dict{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end
