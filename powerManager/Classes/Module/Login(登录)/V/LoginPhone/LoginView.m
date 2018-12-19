//
//  LoginView.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/22.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "LoginView.h"
#import "common.h"
#import "UserLogin.h"
#import "UserInfoModel.h"

@interface LoginView () <UITextFieldDelegate> {
    UIImageView *img;
    UITextField *textAccount;
    UITextField *textPassword;
    UIImageView *accountLeft;
    UIImageView *passwordLeft;
    UIButton *btnSrcurty;
    UIButton *btnClear;
    BOOL isSecurity;
    UserInfoModel *model;
}

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self pretreatment];
    }
    return self;
}


/**
 加载登录页面视图
 */
- (void)pretreatment{
    isSecurity = YES;
    UIButton *btnm = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [btnm addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnm];
    
    img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    img.image = [UIImage imageNamed:@"0登录bg"];
    [self addSubview:img];
    
    UIImageView *imgFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10*ProportionX, 680*ProportionX / 2.0, self.frame.size.width - 20*ProportionX, 248*ProportionX)];
    imgFrame.backgroundColor = [UIColor colorWithRed:2/255.0 green:35/255.0 blue:44/255.0 alpha:0.9];
    imgFrame.layer.masksToBounds = YES;
    imgFrame.layer.cornerRadius = 10*ProportionX;
    [self addSubview:imgFrame];
    
    UIImageView *imgH = [[UIImageView alloc] initWithFrame:CGRectMake(10*ProportionX, imgFrame.frame.origin.y, self.frame.size.width - 20*ProportionX, 10*ProportionX)];
    imgH.image = [UIImage imageNamed:@"高光"];
    [self addSubview:imgH];
    
    textAccount = [[UITextField alloc] initWithFrame:CGRectMake(15*ProportionX, imgFrame.frame.origin.y + 25*ProportionX, self.frame.size.width - 30*ProportionX, 30*ProportionX)];
    textAccount.delegate = self;
    textAccount.textAlignment = NSTextAlignmentCenter;
    textAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15*ProportionX, 15*ProportionX)];
    accountLeft.image = [UIImage imageNamed:@"login_用户"];
    textAccount.leftView = accountLeft;
    btnClear = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20*ProportionX, 20*ProportionX)];
    [btnClear setImage:[UIImage imageNamed:@"login_清除"] forState:UIControlStateNormal];
    [btnClear setImage:[UIImage imageNamed:@"login_清除"] forState:UIControlStateHighlighted];
    [btnClear addTarget:self action:@selector(btnClearClickAction) forControlEvents:UIControlEventTouchUpInside];
    textAccount.rightView = btnClear;
    textAccount.rightViewMode = UITextFieldViewModeWhileEditing;
    textAccount.leftViewMode = UITextFieldViewModeAlways;
    textAccount.text = @"请输入用户名/邮箱/手机号";
    textAccount.textColor = [UIColor colorWithRed:83/255.0 green:181/255.0 blue:225/255.0 alpha:1];
    [self addSubview:textAccount];
    
    
    UILabel *lblAccount = [[UILabel alloc] initWithFrame:CGRectMake(15*ProportionX, textAccount.frame.size.height + textAccount.frame.origin.y, self.frame.size.width - 30*ProportionX, 1*ProportionX)];
    lblAccount.backgroundColor = [UIColor colorWithRed:5/255.0 green:78/255.0 blue:102/255.0 alpha:1];
    [self addSubview:lblAccount];
    
    textPassword = [[UITextField alloc] initWithFrame:CGRectMake(15*ProportionX, lblAccount.frame.origin.y + 25*ProportionX, self.frame.size.width - 30*ProportionX, 30*ProportionX)];
    textPassword.delegate = self;
    textPassword.textAlignment = NSTextAlignmentCenter;
    passwordLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15*ProportionX, 15*ProportionX)];
    passwordLeft.image = [UIImage imageNamed:@"login_密码"];
    textPassword.leftView = passwordLeft;
    textPassword.leftViewMode = UITextFieldViewModeAlways;
    btnSrcurty = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20*ProportionX, 20*ProportionX)];
    [btnSrcurty setImage:[UIImage imageNamed:@"login_密码不可见"] forState:UIControlStateNormal];
    [btnSrcurty addTarget:self action:@selector(btnSecurityClickAction) forControlEvents:UIControlEventTouchUpInside];
    textPassword.rightView = btnSrcurty;
    textPassword.rightViewMode = UITextFieldViewModeWhileEditing;
    textPassword.text = @"请输入密码";
    textPassword.textColor = [UIColor colorWithRed:83/255.0 green:181/255.0 blue:225/255.0 alpha:1];
    [self addSubview:textPassword];
    
    UILabel *lblPassword = [[UILabel alloc] initWithFrame:CGRectMake(15*ProportionX, textPassword.frame.size.height + textPassword.frame.origin.y, self.frame.size.width - 30*ProportionX, 1*ProportionX)];
    lblPassword.backgroundColor = [UIColor colorWithRed:5/255.0 green:78/255.0 blue:102/255.0 alpha:1];
    [self addSubview:lblPassword];
    
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(48*ProportionX, lblPassword.frame.origin.y + 24*ProportionX, self.frame.size.width - 96*ProportionX, 48*ProportionX)];
    btnLogin.layer.masksToBounds = YES;
    btnLogin.layer.cornerRadius = 24*ProportionX;
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogin setTitle:@"登 陆" forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(btnLoginClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnLogin];
    
    UIButton *btnForgetted = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 80*ProportionX)/2.0, btnLogin.frame.origin.y + btnLogin.frame.size.height + 20*ProportionX, 80*ProportionX, 24*ProportionX)];
    [btnForgetted setTitleColor:[UIColor whiteColor] forState:normal];
    [btnForgetted setTitle:@"忘记密码" forState:UIControlStateNormal];
    [btnForgetted addTarget:self action:@selector(btnForgettedClickAction) forControlEvents:UIControlEventTouchUpInside];
    btnForgetted.titleLabel.font = FontM;
    [self addSubview:btnForgetted];
    
    UILabel *lblLoginSDK = [[UILabel alloc] initWithFrame:CGRectMake(0, imgFrame.frame.origin.y + imgFrame.frame.size.height + 13*ProportionX, self.frame.size.width, 20)];
    lblLoginSDK.textAlignment = NSTextAlignmentCenter;
    lblLoginSDK.textColor = [UIColor whiteColor];
    lblLoginSDK.font = [UIFont systemFontOfSize:16];
    lblLoginSDK.text = @"快捷登录";
    [self addSubview:lblLoginSDK];
    
    UIButton *btnWechat = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0 - 40, lblLoginSDK.frame.origin.y + lblLoginSDK.frame.size.height + 10, 30, 30)];
    [btnWechat setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [btnWechat setBackgroundImage:[UIImage imageNamed:@"微信_click"] forState:UIControlStateHighlighted];
    [btnWechat addTarget:self action:@selector(btnWeChatClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnWechat];
    
    UIButton *btnQQ = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0 + 10, lblLoginSDK.frame.origin.y + lblLoginSDK.frame.size.height + 10, 30, 30)];
    [btnQQ setBackgroundImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    [btnQQ setBackgroundImage:[UIImage imageNamed:@"QQ_click"] forState:UIControlStateHighlighted];
    [btnQQ addTarget:self action:@selector(btnQQClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnQQ];
    
}


#pragma mark - 按钮功能

- (void)btnMClickAction{
    img.image = [UIImage imageNamed:@"0登录bg"];
    [textAccount resignFirstResponder];
    [textPassword resignFirstResponder];
    if ([textAccount.text isEqualToString:@""]) {
        textAccount.text = @"请输入用户名/邮箱/手机号";
    }
    
    if ([textPassword.text isEqualToString:@""]) {
        textPassword.text = @"请输入密码";
    }
}

- (void)btnLoginClickAction{
    [textAccount resignFirstResponder];
    [textPassword resignFirstResponder];
    
    if ([textAccount.text isEqualToString:@"请输入用户名/邮箱/手机号"] || [textPassword.text isEqualToString:@"请输入用户名/邮箱/手机号"]) {
        [self makeToast:@"请输入正确的账号或密码"];
    } else {
        if (!model) {
            model = [[UserInfoModel alloc] init];
        }
        model.account = textAccount.text;
        model.password = textPassword.text;
        
        if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
            [self.customDelegate btnClickWithTag:@"Login" info:model];
        }
    }
}

- (void)btnForgettedClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"Forgetted" info:model];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
    textField.textColor = [UIColor whiteColor];
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
//        [self.customDelegate btnClickWithTag:@"editing" info:model];
//    }
    if ([textPassword.text isEqualToString:@""]) {
        textPassword.secureTextEntry = YES;
    }
    img.image = [UIImage imageNamed:@"0登录_输入状态bg"];
    isSecurity = YES;
    [btnSrcurty setImage:[UIImage imageNamed:@"login_密码不可见"] forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    textField.textColor = [UIColor colorWithRed:83/255.0 green:181/255.0 blue:225/255.0 alpha:1];
    img.image = [UIImage imageNamed:@"0登录bg"];
    if ([textAccount.text isEqualToString:@""]) {
        textAccount.text = @"请输入用户名/邮箱/手机号";
    }
    
    if ([textPassword.text isEqualToString:@""] || [textPassword.text isEqualToString:@"请输入密码"]) {
        textPassword.text = @"请输入密码";
        textPassword.secureTextEntry = NO;
        isSecurity = YES;
        [btnSrcurty setImage:[UIImage imageNamed:@"login_密码不可见"] forState:UIControlStateNormal];
    } else {
        textPassword.secureTextEntry = YES;
        isSecurity = YES;
        [btnSrcurty setImage:[UIImage imageNamed:@"login_密码不可见"] forState:UIControlStateNormal];
    }
    
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
//        [self.customDelegate btnClickWithTag:@"endediting" info:model];
//    }
    return YES;
}

- (void)btnSecurityClickAction{
    if (isSecurity) {
        isSecurity = NO;
        textPassword.secureTextEntry = NO;
        [btnSrcurty setImage:[UIImage imageNamed:@"login_密码可见"] forState:UIControlStateNormal];
    } else {
        isSecurity = YES;
        textPassword.secureTextEntry = YES;
        [btnSrcurty setImage:[UIImage imageNamed:@"login_密码不可见"] forState:UIControlStateNormal];
    }
}

- (void)btnClearClickAction{
    textAccount.text = @"";
}


- (void)btnQQClickAction{
    if (!model) {
        model = [[UserInfoModel alloc] init];
    }
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"QQ" info:model];
    }
}

- (void)btnWeChatClickAction{
    if (!model) {
        model = [[UserInfoModel alloc] init];
    }
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"WeChat" info:model];
    }
}


@end
