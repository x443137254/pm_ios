//
//  EditThreeDetailViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/29.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "EditThreeDetailViewController.h"
#import "common.h"
#import "Personal.h"
#import "TLMD5.h"

@interface EditThreeDetailViewController () <UITextFieldDelegate> {
    UIImageView *imgBG;
    UITextField *textC0;
    UITextField *textC1;
    UITextField *textC2;
    
    UIButton *btnSure0;
    UIButton *btnM0;
    
    UIButton *btnCode;
    NSTimer *timer;
    
    int t;
}

@end

@implementation EditThreeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    self.title = self.lblTitle;
    if (!imgBG) {
        imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imgBG.image = [UIImage imageNamed:@"bg"];
    }
    [self.view addSubview:imgBG];
    [self pretreatment];
}


- (void)pretreatment{
    if (!btnM0) {
        btnM0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [btnM0 setBackgroundColor:[UIColor clearColor]];
        [btnM0 addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:btnM0];
        
    if (!textC0) {

        UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX, 5 + 64, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
        lbl0.textColor = [UIColor whiteColor];
        lbl0.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:lbl0];

        UILabel *lblL0 = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y, self.view.frame.size.width, 45*ProportionX)];
        lblL0.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        lblL0.textColor = [UIColor redColor];
        lblL0.textAlignment = NSTextAlignmentLeft;
        lblL0.text = @"   *";
        [self.view addSubview:lblL0];

        textC0 = [[UITextField alloc] initWithFrame:CGRectMake(120*ProportionX, lbl0.frame.origin.y, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
        textC0.delegate = self;
        textC0.textAlignment = NSTextAlignmentLeft;
        textC0.textColor = [UIColor colorWithRed:94/255.0 green:201/255.0 blue:247/255.0 alpha:1];
        [self.view addSubview:textC0];
        
        if ([self.lblTitle isEqualToString:@"修改密码"]) {
            lbl0.text = @"原密码";
            textC0.text = @"请输入密码";
        } else if ([self.lblTitle isEqualToString:@"修改手机号"]) {
            lbl0.text = @"原手机";
            textC0.text = @"请输入手机号";
            textC1.keyboardType = UIKeyboardTypePhonePad;
        } else {
            lbl0.text = @"请输入编辑内容";
            textC0.text = @"请输入编辑内容";
        }
        
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y, self.view.frame.size.width, 1)];
        lblT.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [self.view addSubview:lblT];
        
        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y + lbl0.frame.size.height, self.view.frame.size.width, 1)];
        lblB.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [self.view addSubview:lblB];
    }
    
    if (!textC1) {
        UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX, 5 + 45*ProportionX + 10*ProportionX + 64, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
        lbl0.textColor = [UIColor whiteColor];
        lbl0.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:lbl0];

        UILabel *lblL0 = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y, self.view.frame.size.width, 45*ProportionX)];
        lblL0.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        lblL0.textColor = [UIColor redColor];
        lblL0.textAlignment = NSTextAlignmentLeft;
        lblL0.text = @"   *";
        [self.view addSubview:lblL0];

        textC1 = [[UITextField alloc] initWithFrame:CGRectMake(120*ProportionX, lbl0.frame.origin.y, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
        textC1.delegate = self;
        textC1.textAlignment = NSTextAlignmentLeft;
        textC1.textColor = [UIColor colorWithRed:94/255.0 green:201/255.0 blue:247/255.0 alpha:1];
        [self.view addSubview:textC1];
        
        if ([self.lblTitle isEqualToString:@"修改密码"]) {
            lbl0.text = @"新密码";
            textC1.text = @"请输入新密码";
        } else if ([self.lblTitle isEqualToString:@"修改手机号"]) {
            lbl0.text = @"新手机号码";
            textC1.text = @"请输入新手机号";
            textC1.keyboardType = UIKeyboardTypePhonePad;
        } else {
            lbl0.text = @"请输入编辑内容";
            textC1.text = @"请输入编辑内容";
        }
        
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y, self.view.frame.size.width, 1)];
        lblT.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [self.view addSubview:lblT];
        
        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y + lbl0.frame.size.height, self.view.frame.size.width, 1)];
        lblB.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [self.view addSubview:lblB];

    }
    
    if (!textC2) {

        UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX, 5+45*2*ProportionX +10*ProportionX + 64, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
        lbl0.textColor = [UIColor whiteColor];
        lbl0.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:lbl0];

        
        UILabel *lblL0 = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y, self.view.frame.size.width, 45*ProportionX)];
        lblL0.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        lblL0.textColor = [UIColor redColor];
        lblL0.textAlignment = NSTextAlignmentLeft;
        lblL0.text = @"   *";
        [self.view addSubview:lblL0];
        
        textC2 = [[UITextField alloc] initWithFrame:CGRectMake(120*ProportionX, lbl0.frame.origin.y, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
        textC2.delegate = self;
        textC2.textAlignment = NSTextAlignmentLeft;
        textC2.textColor = [UIColor colorWithRed:94/255.0 green:201/255.0 blue:247/255.0 alpha:1];
        [self.view addSubview:textC2];
        
        if ([self.lblTitle isEqualToString:@"修改密码"]) {
            lbl0.text = @"确认新密码";
            textC2.text = @"请再次输入新密码";
        } else if ([self.lblTitle isEqualToString:@"修改手机号"]) {
            lbl0.text = @"验证码";
            textC2.keyboardType = UIKeyboardTypePhonePad;
            textC2.text = @"请输入验证码";
        } else {
            lbl0.text = @"请输入编辑内容";
            textC2.text = @"请输入编辑内容";
        }
        
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y, self.view.frame.size.width, 1)];
        lblT.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [self.view addSubview:lblT];
        
        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl0.frame.origin.y + lbl0.frame.size.height, self.view.frame.size.width, 1)];
        lblB.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [self.view addSubview:lblB];
        
        if ([self.lblTitle isEqualToString:@"修改手机号"]) {
            if (!btnCode) {
                btnCode = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 110*ProportionX, 7.5*ProportionX + lbl0.frame.origin.y, 100*ProportionX, 30*ProportionX)];
                btnCode.layer.masksToBounds = YES;
                btnCode.layer.cornerRadius = 15*ProportionX;
                btnCode.layer.borderWidth = 1;
                btnCode.layer.borderColor = [[UIColor colorWithRed:29/255.0 green:124/255.0 blue:191/255.0 alpha:1] CGColor];
                [btnCode setTitleColor:[UIColor colorWithRed:29/255.0 green:124/255.0 blue:191/255.0 alpha:1] forState:UIControlStateNormal];
                [btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
                [btnCode addTarget:self action:@selector(btnCodeClickAction) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:btnCode];
            }
        }
        
    }
    
    if (!btnSure0) {
        btnSure0 = [[UIButton alloc] initWithFrame:CGRectMake(20*ProportionX, textC2.frame.origin.y + textC2.frame.size.height + 30*ProportionX, self.view.frame.size.width - 40*ProportionX, 50*ProportionX)];
        btnSure0.layer.masksToBounds =YES;
        btnSure0.layer.cornerRadius = 25*ProportionX;
        [btnSure0 setBackgroundImage:[UIImage imageNamed:@"btnSure"] forState:UIControlStateNormal];
        [btnSure0 setTitle:@"确定" forState:UIControlStateNormal];
        [btnSure0 addTarget:self action:@selector(btnSureClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:btnSure0];
}

- (void)btnMClickAction{
    [textC0 resignFirstResponder];
    [textC1 resignFirstResponder];
    [textC2 resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    UIColor *colorCustom = [UIColor colorWithRed:94/255.0 green:201/255.0 blue:247/255.0 alpha:1];
    if ([self.lblTitle isEqualToString:@"修改密码"]) {
        if ([textField isEqual:textC0]) {
            textC0.secureTextEntry = YES;
        } else if ([textField isEqual:textC1]){
            textC1.secureTextEntry = YES;
        } else if ([textField isEqual:textC2]){
            textC2.secureTextEntry = YES;
        }
    }
    if (CGColorEqualToColor(textField.textColor.CGColor, colorCustom.CGColor)) {
        textField.text = @"";
        textField.textColor = [UIColor whiteColor];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textC0.text.length == 0) {
        textC0.textColor = [UIColor colorWithRed:94/255.0 green:201/255.0 blue:247/255.0 alpha:1];
        if ([self.lblTitle isEqualToString:@"修改密码"]) {
            textC0.text = @"请输入密码";
            textC0.secureTextEntry = NO;
        } else if ([self.lblTitle isEqualToString:@"修改手机号"]) {
            textC0.text = @"请输入手机号";
        } else {
            textC0.text = @"请输入编辑内容";
        }
    }
    
    if (textC1.text.length == 0) {
        textC1.textColor = [UIColor colorWithRed:94/255.0 green:201/255.0 blue:247/255.0 alpha:1];
        if ([self.lblTitle isEqualToString:@"修改密码"]) {
            textC1.text = @"请输入新密码";
            textC1.secureTextEntry = NO;
        } else if ([self.lblTitle isEqualToString:@"修改手机号"]) {
            textC1.text = @"请输入新手机号";
        } else {
            textC1.text = @"请输入编辑内容";
        }
    }
    
    if (textC2.text.length == 0) {
        textC2.textColor = [UIColor colorWithRed:94/255.0 green:201/255.0 blue:247/255.0 alpha:1];
        if ([self.lblTitle isEqualToString:@"修改密码"]) {
            textC2.text = @"请再次输入新密码";
            textC2.secureTextEntry = NO;
        } else if ([self.lblTitle isEqualToString:@"修改手机号"]) {
            textC2.text = @"请输入验证码";
        } else {
            textC2.text = @"请输入编辑内容";
        }
    }
    return YES;
}

- (void)btnSureClickAction{
    
    [textC0 resignFirstResponder];
    [textC1 resignFirstResponder];
    [textC2 resignFirstResponder];
    
    UIColor *colorCustom =  [UIColor colorWithRed:94/255.0 green:201/255.0 blue:247/255.0 alpha:1];
    if (CGColorEqualToColor(textC0.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(textC1.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(textC2.textColor.CGColor, colorCustom.CGColor)) {
        
        [self.view makeToast:@"请输入完整信息"];
        
    } else {
    
//        NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:TOKEN];
        NSString *cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"cid"];
        NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
        
        NSLog(@"cid = %@",cid);
        if ([self.lblTitle isEqualToString:@"修改密码"]) {
            NSString *oldpassword = [TLMD5 getMD5HashWithMessage:textC0.text AndType:Uppercase16bit];
            if (![password isEqualToString:oldpassword]) {
                [self.view makeToast:@"原密码输入错误"];
            } else {
                if (![textC1.text isEqualToString:textC2.text]) {
                    [self.view makeToast:@"密码与确认密码输入不一致"];
                } else {
                    [Personal getUpdateUser:@{@"cid":cid,@"password":textC1.text} Success:^(id data) {
                        NSLog(@"data = %@",data);
                        [self.view makeToast:@"修改成功"];
                    }];
                }
            }
        }

        if ([self.lblTitle isEqualToString:@"安全手机"]) {
            
            [Personal getUpdateUser:@{@"cid":cid,@"companyName":textC1.text,@"password":password} Success:^(id data) {
                NSLog(@"data = %@",data);
                [self.view makeToast:@"修改成功"];
            }];
        }
    }
    
}

- (void)btnCodeClickAction{
    if (textC1.text.length == 11) {
        btnCode.userInteractionEnabled = NO;
        t = 60;
        [btnCode setTitle:[NSString stringWithFormat:@"%d",t] forState:normal];
        timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(TimerAction) userInfo:nil repeats:YES];
        [self.view makeToast:@"发送成功"];
    } else {
        [self.view makeToast:@"请输入正确的手机号"];
    }
}

- (void)TimerAction{
    t = t - 1;
    [btnCode setTitle:[NSString stringWithFormat:@"%d",t] forState:normal];
    if (t == 1) {
        [timer invalidate];
        btnCode.userInteractionEnabled = YES;
        [btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
