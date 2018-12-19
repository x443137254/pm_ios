//
//  ThirdBindingView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "ThirdBindingView.h"
#import "common.h"
#import "BindingRegistViewController.h"

@interface ThirdBindingView () <UITextFieldDelegate> {
    UITextField *textAccount;
    UITextField *textPassword;
//    UserInfoModel *model;
    BindingRegistViewController *BRVC;
    UIView *imgFrame;
}

@end

@implementation ThirdBindingView

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self loadView];
//    }
//    return self;
//}

- (void)loadView{

    // 添加通知监听见键盘弹出/退出
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    
    NSLog(@"thirduid = %@",self.model.thirdUnique);
    
    UIColor *colorcontent = [UIColor colorWithRed:124/255.0 green:183/255.0 blue:224/255.0 alpha:1];
    
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imgBG.backgroundColor = RGB_HEX(0x000000, 0.6);
    [self addSubview:imgBG];
    
    UIButton *btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [btnM addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnM];
    
    imgFrame = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 400*ProportionX, self.frame.size.width, 400*ProportionX)];
    imgFrame.backgroundColor = RGB_HEX(0x11242D, 1);
    
//    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imgFrame.size.width, 1)];
//    lblLine.backgroundColor = colorcontent;
//    [imgFrame addSubview:lblLine];
    
    UIButton *btnM1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, imgFrame.frame.size.width, imgFrame.frame.size.height)];
    [btnM1 addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
    [imgFrame addSubview:btnM1];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 60, 30)];
    [LayerView Button:btnCancel BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:colorcontent Cor:15];
    [LayerView Button:btnCancel Title:@"取消" TitleColor:colorcontent];
    [btnCancel addTarget:self action:@selector(btnCanelClickAction) forControlEvents:UIControlEventTouchUpInside];
    [imgFrame addSubview:btnCancel];
    
    UIButton *btnSure = [[UIButton alloc] initWithFrame:CGRectMake(imgFrame.frame.size.width - 20 - 60, 20, 60, 30)];
    [LayerView Button:btnSure BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:RGB_HEX(0xffffff, 0) Cor:15];
    [LayerView Button:btnSure Title:@"注册" TitleColor:RGB_HEX(0xffffff, 1)];
    [btnSure setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [btnSure addTarget:self action:@selector(btnRegistClickAction) forControlEvents:UIControlEventTouchUpInside];
    [imgFrame addSubview:btnSure];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imgFrame.frame.size.width, 70)];
    lblTitle.textColor = RGB_HEX(0xffffff, 1);
    lblTitle.text = @"绑定账号";
    lblTitle.font = [UIFont systemFontOfSize:20];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [imgFrame addSubview:lblTitle];
    
    textAccount = [[UITextField alloc] initWithFrame:CGRectMake(30, lblTitle.frame.origin.y + lblTitle.frame.size.height + 20, self.frame.size.width - 60, 60)];
    [LayerView TextFiled:textAccount BackgroundColor:RGB_HEX(0x000000, 0) BorderWidth:1 BorderColor:colorcontent Cor:30];
    [LayerView TextFiled:textAccount Title:@"请输入账号" TitleColor:colorcontent];
    textAccount.delegate = self;
    textAccount.textAlignment = NSTextAlignmentCenter;
    [imgFrame addSubview:textAccount];
    
    textPassword = [[UITextField alloc] initWithFrame:CGRectMake(30, textAccount.frame.origin.y +textAccount.frame.size.height + 30, imgFrame.frame.size.width - 60 , 60)];
    [LayerView TextFiled:textPassword BackgroundColor:RGB_HEX(0x000000, 0) BorderWidth:1 BorderColor:colorcontent Cor:30];
    [LayerView TextFiled:textPassword Title:@"请输入密码" TitleColor:RGB_HEX(0x71A9D2, 1)];
    textPassword.delegate = self;
    textPassword.textAlignment = NSTextAlignmentCenter;
    [imgFrame addSubview:textPassword];
    
    UIButton *btnBinding = [[UIButton alloc] initWithFrame:CGRectMake(30, textPassword.frame.size.height + textPassword.frame.origin.y + 30, imgFrame.frame.size.width - 60, 60)];
    [LayerView Button:btnBinding BackgroundColor:RGB_HEX(0xffffff, 0) BorderWidth:1 BorderColor:colorcontent Cor:30];
    [LayerView Button:btnBinding Title:@"绑定" TitleColor:RGB_HEX(0xffffff, 1)];
    [btnBinding setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [btnBinding addTarget:self action:@selector(btnBindingClickAction) forControlEvents:UIControlEventTouchUpInside];
    [imgFrame addSubview:btnBinding];
    
    [self addSubview:imgFrame];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (![textField.text isEqualToString:@"请输入账号"] || ![textField.text isEqualToString:@"请输入密码"]) {
        textField.text = @"";
        textField.textColor = RGB_HEX(0xffffff, 1);
        if (textField == textPassword) {
            textPassword.secureTextEntry = YES;
        }
    }
//    [UIView animateWithDuration:0.3 animations:^{
//        imgFrame.frame = CGRectMake(0, imgFrame.origin.y-200, imgFrame.size.width, imgFrame.size.height);
//    }];

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    UIColor *colorcontent = [UIColor colorWithRed:124/255.0 green:183/255.0 blue:224/255.0 alpha:1];
    
    if (textAccount.text.length== 0 || [textAccount.text isEqualToString:@"请输入账号"]) {
        textAccount.text = @"请输入账号";
        textAccount.textColor = colorcontent;
    }
    
    if (textPassword.text.length== 0 || [textPassword.text isEqualToString:@"请输入密码"]) {
        textPassword.text = @"请输入密码";
        textPassword.textColor = colorcontent;
        textPassword.secureTextEntry = NO;
    }

//    [UIView animateWithDuration:0.3 animations:^{
//        imgFrame.frame = CGRectMake(0, self.frame.size.height - 400*ProportionX, imgFrame.size.width, imgFrame.size.height);
//    }];

    return YES;
}

- (void)btnMClickAction{
    [textAccount resignFirstResponder];
    [textPassword resignFirstResponder];
}

- (void)btnCanelClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"BindingCancel" info:self.model];
    }
}

- (void)btnBindingClickAction{
    self.model.account = textAccount.text;
    self.model.password = textPassword.text;
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"Binding" info:self.model];
    }
}

- (void)btnRegistClickAction{
    
    if (!BRVC) {
        BRVC = [[BindingRegistViewController alloc] init];
    }
    BRVC.model = [[UserInfoModel alloc] init];
    BRVC.model = self.model;
    [[self getCurrentVC].navigationController pushViewController:BRVC animated:YES];
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

// 点击非TextField区域取消第一响应者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [textAccount resignFirstResponder];
    [textPassword resignFirstResponder];
}

// 点击键盘Return键取消第一响应者
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textAccount resignFirstResponder];
    [textPassword resignFirstResponder];
    return  YES;
}

// 键盘监听事件
- (void)keyboardAction:(NSNotification*)sender{
    // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];

    // <注意>具有约束的控件通过改变约束值进行frame的改变处理
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
//        self.toBottom.constant = [value CGRectValue].size.height;
        [UIView animateWithDuration:0.3 animations:^{
//            imgFrame.frame = CGRectMake(0, self.frame.size.height - 400*ProportionX-[value CGRectValue].size.height, imgFrame.size.width, imgFrame.size.height);
        }];
    }else{
//        self.toBottom.constant = 0;
        [UIView animateWithDuration:0.3 animations:^{
//            imgFrame.frame = CGRectMake(0, self.frame.size.height - 400*ProportionX, imgFrame.size.width, imgFrame.size.height);
        }];
    }
}

@end
