//
//  RegistterViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/22.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "RegistterViewController.h"
#import "common.h"
#import "https.h"
#import "RegisterView.h"
#import "UserLogin.h"
#import "InstallerCodeView.h"
#import "RegisterViewPad.h"

@interface RegistterViewController () <UITextFieldDelegate,RegisterViewControllerDelegate> {
    RegisterView *RV;
    InstallerCodeView *ICV;
    RegisterViewPad *RVP;
    UIButton *btnM;
}

@end

@implementation RegistterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{

    if ([common isPhone]) {
        [self setNavigation];
        if (self.view.frame.size.width >= 375) {
            self.view.backgroundColor = RGB_HEX(0x042a38, 1);
            if (!RVP) {
                RVP = [[NSBundle mainBundle] loadNibNamed:@"RegisterViewPad" owner:self options:nil].lastObject;
            }
            RVP.customDelegate = self;
            RVP.frame = CGRectMake(0, 0, self.view.frame.size.width, RVP.frame.size.height);
//            RVP.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);

            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
            scrollView.contentSize = RVP.frame.size;
            [scrollView addSubview:RVP];
            scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
            [self.view addSubview:scrollView];
        } else {
            [self setMainView];
        }
    } else if ([common isPad]) {

        if (!btnM) {
            btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        [btnM addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnM];


        self.view.backgroundColor = RGB_HEX(0x042a38, 1);
        [self setNavigationPad];
        if (!RVP) {
            RVP = [[NSBundle mainBundle] loadNibNamed:@"RegisterViewPad" owner:self options:nil].lastObject;
        }
        RVP.customDelegate = self;
        RVP.frame = CGRectMake(0, 0, 960/2.0, 1200/2.0);
        RVP.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
        [self.view addSubview:RVP];

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

- (void)setNavigationPad{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = [UIFont systemFontOfSize:20];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"注册";

    UIButton *btnRegistered = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 22)];
    [btnRegistered setTitle:@"登录" forState:UIControlStateNormal];
    btnRegistered.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnRegistered setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRegistered.layer.masksToBounds = YES;
    btnRegistered.layer.cornerRadius = 10;
    btnRegistered.layer.borderWidth = 1;
    btnRegistered.layer.borderColor = [[UIColor whiteColor] CGColor];
    [btnRegistered addTarget:self action:@selector(btnLoginClickAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnRegistered];
    self.navigationItem.rightBarButtonItem = btnR;
}

- (void)setMainView{
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imgBG.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imgBG];
    
//    if (!RV) {
////        RV = [[RegisterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        RV.customDelegate = self;
//    }
//    [self.view addSubview:RV];
    NSLog(@"width = %f height = %f",SCREEN_WIDTH,SCREEN_HEIGHT);

    if (SCREEN_WIDTH == 320.0) {
        if (!RV) {
            RV = [[RegisterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            RV.customDelegate = self;
        }
        [self.view addSubview:RV];
    } else {

        if (!RVP) {
            RVP = [[NSBundle mainBundle] loadNibNamed:@"RegisterViewPad" owner:self options:nil].lastObject;
        }
        RVP.customDelegate = self;
        RVP.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //    RVP.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
        [self.view addSubview:RVP];
    }

}

#pragma mark - 代理方法

/**
 注册中心控制器代理方法

 @param tag 标签 传递方式
 @param model 传递数据
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
        [UserLogin getRegister:@{@"account":model.account,
                                 @"password":model.password,
                                 @"nick":model.nick,
                                 @"phone":model.phone,
                                 @"email":model.email,
                                 @"country":model.country,
                                 @"language":model.language,
                                 @"userType":model.userType,
                                 @"company":model.company,
                                 @"addr":model.addr
                                } Success:^(id data) {
            if ([data isEqualToString:@"Success"]) {
//                                    NSLog(@"%@",data);
                [self.view makeToast:@"账号注册成功！"];
                
                if (!self->btnM) {
                    self->btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                    [self->btnM setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]];
                    [self->btnM addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
                    self->btnM.alpha = 0;
                }
                [self.view addSubview:self->btnM];
                
                
                if (!self->ICV) {
                    self->ICV = [[InstallerCodeView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 400*ProportionX)];
                    self->ICV.customDelegate = self;
                }
                [self.view addSubview:self->ICV];
                [UIView animateWithDuration:0.3 animations:^{
                    self->btnM.alpha = 0.7;
                    self->ICV.frame = CGRectMake(0, 300*ProportionX, self.view.frame.size.width, self.view.frame.size.height - 300*ProportionX);
                }];
            }
        }];
        
    
    }
    
    if ([tag isEqualToString:@"CollectorCheacKCancel"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self->btnM.alpha = 0.1;
            self->ICV.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 300*ProportionX);
        } completion:^(BOOL finished) {
            [self->btnM removeFromSuperview];
            [self->ICV removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    if ([tag isEqualToString:@"CollectorCheacK"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self->btnM.alpha = 0.1;
            self->ICV.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 300*ProportionX);
        } completion:^(BOOL finished) {
            [self->btnM removeFromSuperview];
            [self->ICV removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    
}

- (void)btnLoginClickAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnMClickAction{
    if ([common isPhone]) {
        [UIView animateWithDuration:0.3 animations:^{
            self->ICV.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 300*ProportionX);
            self->btnM.alpha = 0;
        } completion:^(BOOL finished) {
            [self->ICV removeFromSuperview];
            [self->btnM removeFromSuperview];
        }];
    } else if ([common isPad]) {
        UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self.view addSubview:text];
        [text becomeFirstResponder];
        [text resignFirstResponder];
        [text removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Tabbar 屏幕翻转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{

//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    RVP.center = CGPointMake(self.view.frame.size.height/2.0, self.view.frame.size.width/2.0);
    btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
    
}

#pragma Tabbar 键盘监听
- (void)keyboardAction:(NSNotification*)sender{

    // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSString *keyboardHeight = [NSString stringWithFormat:@"%f",[value CGRectValue].size.height];

    [[NSUserDefaults standardUserDefaults] setObject:keyboardHeight forKey:@"KeyboardHeight"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"KeyboardHeight"]);

}


@end
