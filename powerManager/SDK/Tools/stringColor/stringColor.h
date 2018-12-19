//
//  stringColor.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/13.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stringColor : UIView

+ (NSMutableAttributedString *)String:(NSString *)string
                          StringColor:(UIColor *)StringColor
                           StringFont:(UIFont *)StringFont
                                  str:(NSString *)str
                                color:(UIColor *)color
                                 font:(UIFont *)font
                          aligentment:(NSTextAlignment)aligentment;

@end
