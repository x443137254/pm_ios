//
//  BindingRegistViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "BindingRegistViewController.h"
#import "common.h"
#import "https.h"
#import "BindingRegistView.h"
#import "UserLogin.h"

@interface BindingRegistViewController () <BindingViewControllerDelegate> {
    BindingRegistView *BRV;
    UIButton *btnM;
}

@end


@implementation BindingRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    if ([common isPhone]) {
        [self setNavigation];
        [self setMainView];
    } else if ([common isPad]) {

    }
}

- (void)setNavigation{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"注册";
}

- (void)setMainView{
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imgBG.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imgBG];
    
    if (!BRV) {
        BRV = [[BindingRegistView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        BRV.customDelegate = self;
    }
    BRV.model = [[UserInfoModel alloc] init];
    BRV.model = self.model;
    [self.view addSubview:BRV];
}

#pragma mark - 代理方法

/**
 控制器控制方法实现

 @param tag 标签 选择功能
 @param model 传递的数据模型
 */
- (void)btnClickWithTag:(NSString *)tag info:(UserInfoModel *)model{
    
    NSLog(@"tag = %@",tag);
    
    if ([tag isEqualToString:@"Cancel"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([tag isEqualToString:@"AccountExit"]) {
        [UserLogin getAccountExit:@{@"account":model.account} Success:^(id data) {
            [self.view makeToast:data];
        }];
    }
    
    if ([tag isEqualToString:@"Register"]) {
        NSLog(@" 81 -> %@  = %@",self.model.appType,self.model.thirdUnique);
        [UserLogin getRegisterSDK:@{@"appTyphe":self.model.appType,
                                 @"thirdUnique":self.model.thirdUnique,
                                 @"password":model.password,
                                 @"phone":model.phone,
                                 @"email":model.email,
                                 @"company":model.company,
                                 @"country":model.country,
                                 @"language":model.language,
                                 @"addr":model.addr,
                                 @"userType":model.userType
                                 }
         
                       Success:^(id data) {
                                     if ([data isEqualToString:@"Success"]) {
                                         [self.view makeToast:@"账号注册成功！"];
                                     }
                                 }];
        
//        if (!btnM) {
//            btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//            [btnM setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]];
//            [btnM addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
//            btnM.alpha = 0;
//        }
//        [self.view addSubview:btnM];
        
        
//
//        [UIView animateWithDuration:0.3 animations:^{
//            btnM.alpha = 0.7;
//            self->ICV.frame = CGRectMake(0, 300*ProportionX, self.view.frame.size.width, self.view.frame.size.height - 300*ProportionX);
//        }];
    }
}

//- (void)btnMClickAction{
//    [UIView animateWithDuration:0.3 animations:^{
//        btnM.alpha = 0;
//    } completion:^(BOOL finished) {
//        [btnM removeFromSuperview];
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
