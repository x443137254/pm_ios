//
//  LoginViewPad.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/26.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "LoginViewPad.h"
#import "common.h"
#import "UserInfoModel.h"

@interface LoginViewPad () <UITextFieldDelegate> {
    UserInfoModel *model;
}

@property (weak, nonatomic) IBOutlet UITextField *textAccount;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;

@end

@implementation LoginViewPad

- (IBAction)btnLoginClickAction:(id)sender {
    [self.textAccount resignFirstResponder];
    [self.textPassword resignFirstResponder];

    [self.textAccount resignFirstResponder];
    [self.textPassword resignFirstResponder];

    if ([self.textAccount.text isEqualToString:@"请输入用户名/邮箱/手机号"] || [self.textPassword.text isEqualToString:@"请输入用户名/邮箱/手机号"]) {
        [self makeToast:@"请输入正确的账号或密码"];
    } else {
        if (!model) {
            model = [[UserInfoModel alloc] init];
        }
        model.account = self.textAccount.text;
        model.password = self.textPassword.text;

        if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
            [self.customDelegate btnClickWithTag:@"Login" info:model];
        }
    }
}

- (IBAction)btnForgetClickAction:(id)sender {
    [self.textAccount resignFirstResponder];
    [self.textPassword resignFirstResponder];

    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"Forgetted" info:model];
    }
}

- (IBAction)btnWeChatClickAction:(id)sender {
    [self.textAccount resignFirstResponder];
    [self.textPassword resignFirstResponder];

    if (!model) {
        model = [[UserInfoModel alloc] init];
    }
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"WeChat" info:model];
    }

}

- (IBAction)btnQQClickAction:(id)sender {
    [self.textAccount resignFirstResponder];
    [self.textPassword resignFirstResponder];

    if (!model) {
        model = [[UserInfoModel alloc] init];
    }
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"QQ" info:model];
    }

}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@"请输入用户名/邮箱/手机号"]) {
        textField.text = @"";
        textField.textColor = RGB_HEX(0xffffff, 1);
    }
    if ([textField.text isEqualToString:@"请输入密码"]) {
        textField.text = @"";
        textField.textColor = RGB_HEX(0xffffff, 1);
    }

    if (textField == self.textPassword) {
        textField.secureTextEntry = YES;
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.textPassword) {
        if (textField.text.length == 0) {
            textField.secureTextEntry = NO;
            textField.text = @"请输入密码";
            textField.textColor = ColorCustom;
        }
    }

    if (textField == self.textAccount) {
        if (textField.text.length == 0) {
            textField.text = @"请输入用户名/邮箱/手机号";
            textField.textColor = ColorCustom;
        }
    }
}

@end
