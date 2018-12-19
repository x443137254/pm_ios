//
//  String.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/18.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface String : NSObject



/**
 json转字符串

 @param jsonString 需要转换的json字符串
 @return 转化好的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
