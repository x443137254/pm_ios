//
//  CFGradientLabel.m
//  text
//
//  Created by Dong Neil on 2018/9/14.
//  Copyright © 2018 neal. All rights reserved.
//

#import "CFGradientLabel.h"

@implementation CFGradientLabel

+ (CFGradientLabel *)addGradientLabelWithFrame:(CGPoint)point
                                  gradientText:(NSString *)text
                                      infoText:(NSString *)infoText
                                        colors:(NSArray *)colors
                                          font:(UIFont *)font{
    return [[[CFGradientLabel alloc] init] addGradientLabelWithFrame:point gradientText:text infoText:infoText colors:colors font:font];
}

- (CFGradientLabel *)addGradientLabelWithFrame:(CGPoint)point
                     gradientText:(NSString *)text
                         infoText:(NSString *)infoText
                           colors:(NSArray *)colors
                             font:(UIFont *)font {
    
    static NSInteger labelTag = 200;
    CFGradientLabel *lable = [[CFGradientLabel alloc] init];
    lable.text = text;
    lable.font = font;
    lable.tag = labelTag;
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    //之前项目的时候设置了为0，忘了注释，所以有的小伙伴用的时候就不显示了……(^-^)
    // lable.alpha = 0;
    lable.center = point;
    lable.colors = colors;
    return lable;
}

- (void)drawRect:(CGRect)rect {
    
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}];
    CGRect textRect = (CGRect){0, 0, textSize};
    
    // 画文字(不做显示用, 主要作用是设置 layer 的 mask)
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.textColor set];
    [self.text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:NULL];
    
    // 坐标(只对设置后的画到 context 起作用, 之前画的文字不起作用)
    CGContextTranslateCTM(context, 0.0f, rect.size.height - (rect.size.height - textSize.height) * 0.5);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGImageRef alphaMask = CGBitmapContextCreateImage(context);
    CGContextClearRect(context, rect); // 清除之前画的文字
    
    // 设置mask
    CGContextClipToMask(context, rect, alphaMask);
    
    // 画渐变色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)self.colors, NULL);
    
    //起点
    CGPoint startPoint = CGPointMake(textRect.origin.x,
                                     textRect.origin.y);
    
    //终点
    CGPoint endPoint = CGPointMake(textRect.origin.x /*+ textRect.size.width*/,
                                   textRect.origin.y + textRect.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    // 释放内存
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    CFRelease(alphaMask);
}

@end
