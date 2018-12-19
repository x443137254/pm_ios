//
//  RegisterViewPad.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/26.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "RegisterViewPad.h"
#import "common.h"
#import "UserLogin.h"
#import "TLHeader.h"

@interface RegisterViewPad () <UITextFieldDelegate> {
    NSString *code;
}

@property (weak, nonatomic) IBOutlet UITextField *textAccount;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UITextField *textPasswordSure;
@property (weak, nonatomic) IBOutlet UITextField *textCompany;
@property (weak, nonatomic) IBOutlet UITextField *textCountry;
@property (weak, nonatomic) IBOutlet UITextField *textCity;
@property (weak, nonatomic) IBOutlet UITextField *textDetailDress;
@property (weak, nonatomic) IBOutlet UITextField *textLanguage;
@property (weak, nonatomic) IBOutlet UITextField *textNum;
@property (weak, nonatomic) IBOutlet UITextField *textCode;

@property (weak, nonatomic) IBOutlet UIButton *btnCode;

@property (nonatomic, strong) UserInfoModel *model;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic) int firstTime;
@property (nonatomic) int time;
@property (nonatomic) BOOL isSure;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;

@property (nonatomic, strong) NSTimer *timer;

/** 地区 */
@property (nonatomic, strong) BRTextField *addressTF;
@property (nonatomic, strong) BRStringPickerView *countryTF;
@property (nonatomic, strong) BRStringPickerView *languageTF;

@end

@implementation RegisterViewPad

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.firstTime == 0){
        self.textColor = textField.textColor;
        self.firstTime = 1;
    }
//    77 168 210
    if ([self color:textField.textColor isEqualto:self.textColor]) {
        textField.text = @"";
        textField.textColor = RGB_HEX(0xffffff, 1);
    }

    if (textField == self.textPassword || textField == self.textPasswordSure) {
        textField.secureTextEntry = YES;
    }

    if (textField == self.textCity) {
        [self textResign];
        [self.textCity resignFirstResponder];
        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3]
                                                     isAutoSelect:NO
                                                      resultBlock:^(NSArray *selectAddressArr) {

                                                          //                                                          __weak typeof(self) weakSelf = self;
                                                          //                                                          weakSelf.addressTF.text = [NSString stringWithFormat:@"%@  %@  %@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
                                                          self.textCity.text = [NSString stringWithFormat:@"%@  %@  %@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
                                                          self.textCity.textColor = RGB_HEX(0xffffff, 1);
                                                          [textField resignFirstResponder];
                                                      }];

    }

    if (textField == self.textCountry) {
        [self textResign];
        [self.textCountry resignFirstResponder];
        [BRStringPickerView showStringPickerWithTitle:@"选择国家"
                                           dataSource:[NSArray arrayWithObjects:@"中国",@"American", nil]
                                      defaultSelValue:0
                                         isAutoSelect:NO
                                          resultBlock:^(id selectValue) {
                                              self.textCountry.text = selectValue;
                                              self.textCountry.textColor = RGB_HEX(0xffffff, 1);
                                          }];
    }

    if (textField == self.textLanguage) {
        [self textResign];
        [self.textLanguage resignFirstResponder];
        [BRStringPickerView showStringPickerWithTitle:@"选择语言"
                                           dataSource:[NSArray arrayWithObjects:@"简体中文",@"English", nil]
                                      defaultSelValue:0
                                         isAutoSelect:NO
                                          resultBlock:^(id selectValue) {
                                              self.textLanguage.text = selectValue;
                                              self.textLanguage.textColor = RGB_HEX(0xffffff, 1);
                                          }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        textField.textColor = self.textColor;
        if (textField == self.textAccount) {
            textField.text = @"请输入手机号";
        } else if (textField == self.textCode) {
            textField.text = @"请输入验证码";
        } else if (textField == self.textPassword) {
            textField.text = @"请输入密码";
            textField.secureTextEntry = NO;
        } else if (textField == self.textPasswordSure) {
            textField.text = @"请再次输入密码";
            textField.secureTextEntry = NO;
        } else if (textField == self.textCompany) {
            textField.text = @"请输入公司名称";
        } else if (textField == self.textCountry) {
            textField.text = @"请选择国家";
        } else if (textField == self.textCity) {
            textField.text = @"请选择城市";
        } else if (textField == self.textDetailDress) {
            textField.text = @"详细地址";
        } else if (textField == self.textLanguage) {
            textField.text = @"请选择语言";
        } else if (textField == self.textNum) {
            textField.text = @"请输入安装商编码";
        }
    } else {
        if (textField == self.textAccount) {
            if (self.textAccount.text.length != 11) {
                [self makeToast:@"手机号格式有误"];
            } else {
                [UserLogin getAccountExit:@{@"account":self.textAccount.text}
                                  Success:^(id data)
                {
                    [self makeToast:[NSString stringWithFormat:@"%@",data]];
                }];
            }
        }
    }
}


- (IBAction)btnCodeClickAction:(id)sender {
    [self textResign];

    if (self.textAccount.text.length != 11) {
        [self makeToast:@"请输入正确的手机号"];
    } else {
        [self makeToast:@"发送成功"];
        self.time = 60;
        self.btnCode.userInteractionEnabled = NO;
        [self.btnCode setTitle:[NSString stringWithFormat:@"%d 秒",self.time] forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(btnCodeChange) userInfo:nil repeats:YES];

        [UserLogin getCodePhone:@{@"phone":self.textAccount.text} Success:^(id data) {
            self->code = data[@"data"];
            NSLog(@"code = %@",self->code);
        }];
    }
    
}

- (void)btnCodeChange{
    self.time --;
    [self.btnCode setTitle:[NSString stringWithFormat:@"%d 秒",self.time] forState:UIControlStateNormal];

    if (self.time == 0) {
        [self.btnCode setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        self.btnCode.userInteractionEnabled = YES;
        //取消定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (IBAction)btnSureClickAction:(id)sender {
    [self textResign];

    if (self.isSure) {
        self.isSure = NO;
        [self.btnSure setImage:[UIImage imageNamed:@"不同意"] forState:UIControlStateNormal];
    } else {
        self.isSure = YES;
        [self.btnSure setImage:[UIImage imageNamed:@"同意"] forState:UIControlStateNormal];
    }


}
- (IBAction)btnProtocolClickAction:(id)sender {
    [self textResign];
    [self makeToast:@"正在打开协议"];
}

- (IBAction)btnNextClickAction:(id)sender {

    NSLog(@"next");

    [self textResign];

    if (self.textAccount.text.length != 11) {
        [self makeToast:@"请输入正确的手机号"];
    } else if (![self.textCode.text isEqualToString:code]) {
        [self makeToast:@"验证码有误"];
    } else if(![self.textPassword.text isEqual:self.textPasswordSure.text]) {
        [self makeToast:@"密码与确认密码不匹配"];
    } else if ([self color:self.textCompany.textColor isEqualto:self.textColor]) {
        [self makeToast:@"请填入完整的信息"];
    } else if ([self color:self.textCountry.textColor isEqualto:self.textColor]) {
        [self makeToast:@"请填入完整的信息"];
    } else if ([self color:self.textCity.textColor isEqualto:self.textColor]) {
        [self makeToast:@"请填入完整的信息"];
    } else if ([self color:self.textDetailDress.textColor isEqualto:self.textColor]) {
        [self makeToast:@"请填入完整的信息"];
    } else if ([self color:self.textLanguage.textColor isEqualto:self.textColor]) {
        [self makeToast:@"请填入完整的信息"];
    } else if (!self.isSure) {
        [self makeToast:@"请阅读并同意协议"];
    } else {
        NSString *userType = self.textNum.text;
        if ([self color:self.textNum.textColor isEqualto:self.textColor]) {
            userType = @"";
        }
        NSString *city = [self removeSpaceAndNewline:self.textCity.text];
        [UserLogin getRegister:@{@"account":self.textAccount.text,
                                 @"password":self.textPassword.text,
                                 @"nick":self.textAccount.text,
                                 @"phone":self.textAccount.text,
                                 @"company":self.textCompany.text,
                                 @"country":self.textCountry.text,
                                 @"language":self.textLanguage.text,
                                 @"addr":[NSString stringWithFormat:@"%@%@",city,self.textDetailDress.text],
                                 @"userType":userType,
                                 @"email":self.textAccount.text
                                 } Success:^(id data) {
                                     NSLog(@"regist = %@",data);
                                     [self makeToast:@"注册成功"];
                                 }];
        
        
        if (@available(iOS 10.0, *)) {
            [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
                [[self getCurrentVC].navigationController popViewControllerAnimated:YES];
            }];
        } else {
            // Fallback on earlier versions
        }
    }

}

- (IBAction)btnCancelClickAction:(id)sender {

    [self textResign];
    if (self.model) {
        self.model = [[UserInfoModel alloc] init];
    }
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"Cancel" info:self.model];
    }


}

- (void)textResign{
    [self.textAccount resignFirstResponder];
    [self.textCode resignFirstResponder];
    [self.textPassword resignFirstResponder];
    [self.textPasswordSure resignFirstResponder];
    [self.textCompany resignFirstResponder];
    [self.textDetailDress resignFirstResponder];
    [self.textLanguage resignFirstResponder];
    [self.textNum resignFirstResponder];
    [self endEditing:YES];
    //    [textM removeFromSuperview];
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

-(BOOL)color:(UIColor*)firstColor
      isEqualto:(UIColor*)secondColor{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor)) {
        return YES;
    } else{
        return NO;
    }
}

- (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
