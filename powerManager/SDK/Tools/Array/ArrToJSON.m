//
//  ArrToJSON.m
//  XiaoMei
//
//  Created by ios on 15/10/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ArrToJSON.h"

@implementation ArrToJSON

+ (NSString *)arrToJSONWithArray:(NSMutableArray *)array andKey:(NSString *)key
{
    //1. 初始化可变字符串，存放最终生成json字串
    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:@"["];
    
    for(NSString *str in array){
        
        //2. 遍历数组，取出键值对并按json格式存放
        
        NSString *string  = [NSString stringWithFormat:
                             @"{\"%@\":\"%@\"},", key, str];
        
        [jsonString appendString:string];
        
    }
    // 3. 获取末尾逗号所在位置
    NSUInteger location = [jsonString length]-1;
    
    NSRange range       = NSMakeRange(location, 1);
    
    // 4. 将末尾逗号换成结束的]}
    [jsonString replaceCharactersInRange:range withString:@"]"];
    
    return jsonString;
}


+ (NSString *)arrToJSONWithArray:(NSMutableArray *)array
{
    //1. 初始化可变字符串，存放最终生成json字串
    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:@"["];
    
    for(NSString *str in array){
        
        //2. 遍历数组，取出键值对并按json格式存放
        
        NSString *string  = [NSString stringWithFormat:
                             @"[\"%@\",", str];
        
        [jsonString appendString:string];
        
    }
    // 3. 获取末尾逗号所在位置
    NSUInteger location = [jsonString length]-1;
    
    NSRange range       = NSMakeRange(location, 1);
    
    // 4. 将末尾逗号换成结束的]}
    [jsonString replaceCharactersInRange:range withString:@"]"];
    
    return jsonString;
}

+(NSString *)dictionaryToJSONWithDictionary:(NSDictionary *)dic Name:(NSString *)name isLast:(BOOL)islast{
//    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"\"%@\":\"{", name]];
    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"{"]];
    NSArray *keys = [dic allKeys];
    for (int i=0;i<keys.count; i++) {
        NSString *value = [dic objectForKey:keys[i]];
        NSString *string  = [NSString stringWithFormat:
                             @"\"%@\":\"%@\",", keys[i], value];
        [jsonString appendString:string];
    }
    // 3. 获取末尾逗号所在位置
    NSUInteger location = [jsonString length]-1;
    
    NSRange range       = NSMakeRange(location, 1);
    
    // 4. 将末尾逗号换成结束的]}
    if (islast) {
    [jsonString replaceCharactersInRange:range withString:@"}"];
    }else{
    [jsonString replaceCharactersInRange:range withString:@"},"];
    }
    
    return jsonString;
}



@end
