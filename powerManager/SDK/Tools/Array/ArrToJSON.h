//
//  ArrToJSON.h
//  XiaoMei
//
//  Created by ios on 15/10/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrToJSON : NSObject


+ (NSString *)arrToJSONWithArray:(NSMutableArray *)array andKey:(NSString *)key;

+ (NSString *)arrToJSONWithArray:(NSMutableArray *)array;

+ (NSString *)dictionaryToJSONWithDictionary:(NSDictionary *)dic Name:(NSString *)name;

+ (NSString *)dictionaryToJSONWithDictionary:(NSDictionary *)dic Name:(NSString *)name isLast:(BOOL)islast;
@end
