//
//  EditSingelViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/29.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "EditSingelViewController.h"
#import "common.h"
#import "Personal.h"

@interface EditSingelViewController () <UITextFieldDelegate> {
    UIImageView *imgBG;
    UITextField *textC;
    UILabel *lbl;
    UIButton *btnM;
    UIButton *btnSure;
}

@end

@implementation EditSingelViewController

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
    
    if (!btnSure) {
        btnSure = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        btnSure.layer.masksToBounds =YES;
        btnSure.layer.cornerRadius = 15;
        [btnSure setBackgroundImage:[UIImage imageNamed:@"btnSure"] forState:UIControlStateNormal];
        [btnSure setTitle:@"确定" forState:UIControlStateNormal];
        [btnSure addTarget:self action:@selector(btnSureClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnSure];
    self.navigationItem.rightBarButtonItem = btnR;
    
}

- (void)pretreatment{
//    if (btnM) {
        btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [btnM setBackgroundColor:[UIColor clearColor]];
        [btnM addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
//    }
    [self.view addSubview:btnM];
//    if (!lbl) {
//        lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5+64, self.view.frame.size.width, 45*ProportionX)];
//        lbl.textColor = [UIColor colorWithRed:45/255.0 green:205/255.0 blue:255/255.0 alpha:1];
//        lbl.textAlignment = NSTextAlignmentLeft;
//        lbl.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
//        lbl.text = @"    请输入编辑内容";
//        [self.view addSubview:lbl];
//    }
    
    
    if (!textC) {
        textC = [[UITextField alloc] initWithFrame:CGRectMake(20, 5 + 64, self.view.frame.size.width - 20, 45*ProportionX)];
        textC.delegate = self;
        textC.textAlignment = NSTextAlignmentLeft;
        UIColor *colorCustom = [UIColor colorWithRed:45/255.0 green:205/255.0 blue:255/255.0 alpha:1];
        textC.text = @"请输入编辑内容";
        textC.textColor = colorCustom;
    }
    [self.view addSubview:textC];
    UILabel *lblLin0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5+64, self.view.frame.size.width, 1)];
    lblLin0.backgroundColor = [UIColor colorWithRed:6/255.0 green:69/255.0 blue:91/255.0 alpha:1];
    [self.view addSubview:lblLin0];
    
    UILabel *lblLin1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5+64 + 45*ProportionX, self.view.frame.size.width, 1)];
    lblLin1.backgroundColor = [UIColor colorWithRed:6/255.0 green:69/255.0 blue:91/255.0 alpha:1];
    [self.view addSubview:lblLin1];
    
    
}

- (void)btnMClickAction{
    [textC resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    UIColor *colorCustom = [UIColor colorWithRed:45/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    if (CGColorEqualToColor(textField.textColor.CGColor, colorCustom.CGColor)) {
        textField.text = @"";
        textField.textColor = [UIColor whiteColor];
    }

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    UIColor *colorCustom = [UIColor colorWithRed:45/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    if ([textField.text isEqualToString:@""] || CGColorEqualToColor(textField.textColor.CGColor, colorCustom.CGColor)) {
//        lbl.text = @"    请输入编辑内容";
        textField.text = @"请输入编辑内容";
        textField.textColor = colorCustom;
    }
    return YES;
}


/**
 确认提交
 */
- (void)btnSureClickAction{
    [textC resignFirstResponder];
    UIColor *colorCustom = [UIColor colorWithRed:45/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    if (CGColorEqualToColor(textC.textColor.CGColor, colorCustom.CGColor)) {
        
        [self.view makeToast:@"请输入完整信息"];
        
    } else {
    
        NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:TOKEN];
        NSString *cid = [[NSUserDefaults standardUserDefaults] stringForKey:@"cid"];
        NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
        
        NSLog(@"cid = %@",cid);
        if ([self.lblTitle isEqualToString:@"昵称"]) {
            [Personal getUpdateUser:@{@"cid":cid,@"nick":textC.text,@"password":password} Success:^(id data) {
                NSLog(@"data = %@",data);
                [self.view makeToast:@"修改成功"];
            }];
        }
        
        if ([self.lblTitle isEqualToString:@"所属公司"]) {
            [Personal getUpdateUser:@{@"cid":cid,@"companyName":textC.text,@"password":password} Success:^(id data) {
                NSLog(@"data = %@",data);
                [self.view makeToast:@"修改成功"];
            }];
        }
    }
    
//    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
