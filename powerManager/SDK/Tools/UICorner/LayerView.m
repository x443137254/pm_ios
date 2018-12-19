//
//  LayerView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/8.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "LayerView.h"
#import "common.h"

@implementation LayerView

#pragma mark - view
+ (UIView *)View:(UIView *)view BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor{
    return  [[[LayerView alloc] init] View:view BackgroundColor:BGColor BorderWidth:width BorderColor:BDColor Cor:cor];
}

- (UIView *)View:(UIView *)view BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor{
    
    view.backgroundColor = BGColor;
    if (cor > 0) {
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = cor;
    }
    view.layer.borderWidth = width;
    view.layer.borderColor = BDColor.CGColor;
    
    return view;
}

#pragma mark - button
+ (UIButton *)Button:(UIButton *)btn BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor{
    return  [[[LayerView alloc] init] Button:btn BackgroundColor:BGColor BorderWidth:width BorderColor:BDColor Cor:cor];
}

- (UIButton *)Button:(UIButton *)btn BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor{
    
    [btn setBackgroundColor:BGColor];
    if (cor > 0) {
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = cor;
    }
    btn.layer.borderWidth = width;
    btn.layer.borderColor = BDColor.CGColor;
    
    return btn;
}

+ (UIButton *)Button:(UIButton *)btn Title:(NSString *)title TitleColor:(UIColor *)titleColor{
    return [[[LayerView alloc] init] Button:btn Title:title TitleColor:titleColor];
}

- (UIButton *)Button:(UIButton *)btn Title:(NSString *)title TitleColor:(UIColor *)titleColor{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    return btn;
}

#pragma mark - text

+ (UITextField *)TextFiled:(UITextField *)text BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor{
    
    
    return [[[LayerView alloc] init] TextFiled:text BackgroundColor:BGColor BorderWidth:width BorderColor:BDColor Cor:cor];
}

- (UITextField *)TextFiled:(UITextField *)text BackgroundColor:(UIColor *)BGColor BorderWidth:(float)width BorderColor:(UIColor *)BDColor Cor:(float)cor{
    text.backgroundColor = BGColor;
    if (cor == 0) {
        text.layer.masksToBounds = NO;
    } else {
        text.layer.masksToBounds = YES;
        text.layer.cornerRadius = cor;
    }
    text.layer.borderColor = BDColor.CGColor;
    text.layer.borderWidth = width;
    
    return text;
}

+ (UITextField *)TextFiled:(UITextField *)text Title:(NSString *)title TitleColor:(UIColor *)titleColor{
    return [[[LayerView alloc] init] TextFiled:text Title:title TitleColor:titleColor];
}

- (UITextField *)TextFiled:(UITextField *)text Title:(NSString *)title TitleColor:(UIColor *)titleColor{
    text.text = title;
    text.textColor = titleColor;
    return text;
}



@end
