//
//  LayerView.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/8.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LayerView : UIView

#pragma mark - view
+ (UIView *)View:(UIView *)view BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor;


#pragma mark - button
+ (UIButton *)Button:(UIButton *)btn BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor;

+ (UIButton *)Button:(UIButton *)btn Title:(NSString *)title TitleColor:(UIColor *)titleColor;


#pragma mark - text
+ (UITextField *)TextFiled:(UITextField *)text BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor;

+ (UITextField *)TextFiled:(UITextField *)text Title:(NSString *)title TitleColor:(UIColor *)titleColor;

@end
