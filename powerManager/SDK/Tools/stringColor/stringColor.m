//
//  stringColor.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/13.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "stringColor.h"
#import "common.h"

@implementation stringColor

+ (NSMutableAttributedString *)String:(NSString *)string
                          StringColor:(UIColor *)StringColor
                           StringFont:(UIFont *)StringFont
                                  str:(NSString *)str
                                color:(UIColor *)color
                                 font:(UIFont *)font
                          aligentment:(NSTextAlignment)aligentment{
    
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:string];
    
    
    
    return attri_str;
}

@end
