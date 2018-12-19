//
//  LoginViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/22.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "common.h"
#import "ForgettedViewController.h"
#import "RegistterViewController.h"
#import "UserInfoModel.h"
#import "https.h"
#import "UserLogin.h"
#import "TLMD5.h"
#import "ThirdBindingView.h"
#import "UserLoginInfo.h"
#import "LoginViewPad.h"

@interface LoginViewController () <LoginViewControllerDelegate>{
    LoginView *LV;
    LoginViewPad *LVP;
    ForgettedViewController *FVC;
    RegistterViewController *RVC;
    ThirdBindingView *TBV;

    UIButton *BGImageViewPad;
}

@property (nonatomic, strong) UserInfoModel *model;

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([common isPad]){
        [self loadViewPad];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    if ([common isPhone]) {
        [self setNavigationBar];
    //    self.navigationController.navigationBar.hidden = YES;
        if (!LV) {
            LV = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            LV.customDelegate = self;
        }
        [self.view addSubview:LV];
    } else if ([common isPad]) {
        [self setNavigationBarPad];
    }
}

#pragma mark - 手机页面
- (void)setNavigationBar{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];


    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"登陆";
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:0.001],
                                 NSForegroundColorAttributeName:[UIColor clearColor]};
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    UIButton *btnRegistered = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 22)];
    [btnRegistered setTitle:@"注册" forState:UIControlStateNormal];
    btnRegistered.titleLabel.font = FontS;
    [btnRegistered setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRegistered.layer.masksToBounds = YES;
    btnRegistered.layer.cornerRadius = 10;
    btnRegistered.layer.borderWidth = 1;
    btnRegistered.layer.borderColor = [[UIColor whiteColor] CGColor];
    [btnRegistered addTarget:self action:@selector(btnRegistteredClickAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnRegistered];
    self.navigationItem.rightBarButtonItem = btnR;
    
}

#pragma mark - 平板页面
- (void)loadViewPad{

    if (!BGImageViewPad) {
        BGImageViewPad = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [BGImageViewPad addTarget:self action:@selector(btnBGClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:BGImageViewPad];
    }
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    BGImageViewPad.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    if (orientation == UIInterfaceOrientationPortrait) {
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录竖版背景"] forState:UIControlStateNormal];
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录竖版背景"] forState:UIControlStateHighlighted];
    }else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录竖版背景"] forState:UIControlStateNormal];
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录竖版背景"] forState:UIControlStateHighlighted];
    }else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录横版背景"] forState:UIControlStateNormal];
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录横版背景"] forState:UIControlStateHighlighted];
    }else if (orientation == UIInterfaceOrientationLandscapeRight){
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录横版背景"] forState:UIControlStateNormal];
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录横版背景"] forState:UIControlStateHighlighted];
    }

    if (!LVP) {
        LVP = [[NSBundle mainBundle] loadNibNamed:@"LoginViewPad" owner:self options:nil].lastObject;
        LVP.customDelegate = self;
    }
    LVP.frame = CGRectMake(0, 0, 375, 325);
    LVP.center = CGPointMake(self.view.frame.size.width/2.0, (140-44)+325/2.0);
    [self.view addSubview:LVP];
}

- (void)setNavigationBarPad{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:0.001],
                                 NSForegroundColorAttributeName:[UIColor clearColor]};
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];

    UIButton *btnRegistered = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 22)];
    [btnRegistered setTitle:@"注册" forState:UIControlStateNormal];
    btnRegistered.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnRegistered setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRegistered.layer.masksToBounds = YES;
    btnRegistered.layer.cornerRadius = 10;
    btnRegistered.layer.borderWidth = 1;
    btnRegistered.layer.borderColor = [[UIColor whiteColor] CGColor];
    [btnRegistered addTarget:self action:@selector(btnRegistteredClickAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnRegistered];
    self.navigationItem.rightBarButtonItem = btnR;

    self.navigationController.navigationBar.hidden = NO;

}

- (void)btnClickWithTag:(NSString *)tag info:(UserInfoModel *)model{
    if ([tag isEqualToString:@"Login"]) {
//        正式
//        NSString *account = [TLMD5 getMD5HashWithMessage:model.account AndType:Lowercase16bit];
        
        //NSString *password = [TLMD5 getMD5HashWithMessage:model.password AndType:Lowercase16bit];
        [UserLogin getLogin:@{@"account":model.account,@"password":model.password} Success:^(id data) {
            NSLog(@"data = %@",data);
            NSString *strCode = [NSString stringWithFormat:@"%@",data[@"code"]];
            if ([strCode isEqualToString:@"0"]) {
//                model.account = [NSString stringWithFormat:@"%@",data[@"account"]];
//                model.addr = [NSString stringWithFormat:@"%@",data[@"addr"]];
//                model.cid = [NSString stringWithFormat:@"%@",data[@"cid"]];
//                model.companyId = [NSString stringWithFormat:@"%@",data[@"companyID"]];
//                model.companyName = [NSString stringWithFormat:@"%@",data[@"companyName"]];
//                model.phone = [NSString stringWithFormat:@"%@",data[@"phone"]];
//                model.registTime = [NSString stringWithFormat:@"%@",data[@"registTime"]];
//                model.uniqueId = [NSString stringWithFormat:@"%@",data[@"uniqueId"]];
                
//                NSLog(@"dic = %@",data[@"data"]);
                UserLoginInfo *user = [UserLoginInfo yy_modelWithJSON:data[@"data"]];
                //// 将 Model 转换为 JSON 对象:
                NSDictionary *dic = [user yy_modelToJSONObject];
//                NSLog(@"dic = %@",dic);
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"account"] forKey:ACCOUNT];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"cid"] forKey:CID];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"uniqueId"] forKey:UNIQUEID];
                [[NSUserDefaults standardUserDefaults] setObject:model.password forKey:PASSWORD];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"companyName"] forKey:COMPANYNAME];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.navigationController popViewControllerAnimated:YES];
                self.tabBarController.selectedIndex = 0;
            
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LEFTVIEWUPDATA" object:nil];

            }
        }];
    }
    if ([tag isEqualToString:@"Forgetted"]) {
        if (!FVC) {
            FVC = [[ForgettedViewController alloc] init];
        }
        [self.navigationController pushViewController:FVC animated:YES];
    }
    if ([tag isEqualToString:@"editing"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, -140*ProportionX, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
    
    if ([tag isEqualToString:@"endediting"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
    
    if ([tag isEqualToString:@"QQ"]) {
        [self getAuthWithUserInfoFromQQ];
    }
    
    if ([tag isEqualToString:@"WeChat"]) {
        [self getAuthWithUserInfoFromWechat];
    }
    
    if ([tag isEqualToString:@"BindingCancel"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self->TBV.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) ;
        }completion:^(BOOL finished) {
            [self->TBV removeFromSuperview];
        }];
    }
    
    if ([tag isEqualToString:@"Binding"]) {
        NSLog(@"绑定现有账号");
    }
    
    
}

- (void)btnRegistteredClickAction{
    if (!RVC) {
        RVC = [[RegistterViewController alloc] init];
    }
    [self.navigationController pushViewController:RVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UM
- (void)getAuthWithUserInfoFromQQ{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
//            NSLog(@"QQ uid: %@", resp.uid);
//            NSLog(@"QQ openid: %@", resp.openid);
//            NSLog(@"QQ unionid: %@", resp.unionId);
//            NSLog(@"QQ accessToken: %@", resp.accessToken);
//            NSLog(@"QQ expiration: %@", resp.expiration);
//
//            // 用户信息
//            NSLog(@"QQ name: %@", resp.name);
//            NSLog(@"QQ iconurl: %@", resp.iconurl);
//            NSLog(@"QQ gender: %@", resp.unionGender);
//
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            [UserLogin getLoginSDK:@{@"appType":@"QQ",@"thirdUnique":resp.uid} Success:^(id data) {
                NSLog(@"data = %@",data);
                if ([data isEqualToString:@"账号不存在!"]) {
                    self.model.appType = @"QQ";
                    self.model.thirdUnique = resp.uid;
//                    NSLog(@" = %@  = %@",self.model.appType,self.model.thirdUnique);
                    [self loadTBVWithModel:self.model];
                }
            }];
        }
    }];
}


// 在需要进行获取用户信息的UIViewController中加入如下代码

- (void)getAuthWithUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
//            NSLog(@"Wechat uid: %@", resp.uid);
//            NSLog(@"Wechat openid: %@", resp.openid);
//            NSLog(@"Wechat unionid: %@", resp.unionId);
//            NSLog(@"Wechat accessToken: %@", resp.accessToken);
//            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
//            NSLog(@"Wechat expiration: %@", resp.expiration);
//
//            // 用户信息
//            NSLog(@"Wechat name: %@", resp.name);
//            NSLog(@"Wechat iconurl: %@", resp.iconurl);
//            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            [UserLogin getLoginSDK:@{@"appType":@"WeChat",@"thirdUnique":resp.uid} Success:^(id data) {
                NSLog(@"data = %@",data);
                if ([data isEqualToString:@"账号不存在!"]) {
                    [UserLogin getLoginSDK:@{@"appType":@"WeChat",@"thirdUnique":resp.uid} Success:^(id data) {
                        NSLog(@"data = %@",data);
                        if ([data isEqualToString:@"账号不存在!"]) {
                            self.model.appType = @"WeChat";
                            self.model.thirdUnique = resp.uid;
                            [self loadTBVWithModel:self.model];
                        }
                    }];
                }
            }];
        }
    }];
}

/**
 检测未绑定账号加载绑定视图
 
 @param model 返回的model
 */
- (void)loadTBVWithModel:(UserInfoModel *)model{
    if (!TBV) {
        TBV = [[ThirdBindingView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        TBV.customDelegate = self;
    }
    TBV.model = [[UserInfoModel alloc] init];
    TBV.model = model;
    [TBV loadView];
    [self.view addSubview:TBV];
    [UIView animateWithDuration:0.3 animations:^{
        self->TBV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


/**
 懒加载

 @return 返回初始化过的模型
 */
- (UserInfoModel *)model{
    if (!_model) {
        self.model = [[UserInfoModel alloc] init];
    }
    return _model;
}


#pragma Tabbar 屏幕翻转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    BGImageViewPad.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    if (orientation == UIInterfaceOrientationPortrait) {
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录横版背景"] forState:UIControlStateNormal];
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录横版背景"] forState:UIControlStateHighlighted];
    }else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录横版背景"] forState:UIControlStateNormal];
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录横版背景"] forState:UIControlStateHighlighted];
    }else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录竖版背景"] forState:UIControlStateNormal];
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录竖版背景"] forState:UIControlStateHighlighted];
    }else if (orientation == UIInterfaceOrientationLandscapeRight){
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录竖版背景"] forState:UIControlStateNormal];
        [BGImageViewPad setBackgroundImage:[UIImage imageNamed:@"登录竖版背景"] forState:UIControlStateHighlighted];
    }
}

- (void)btnBGClickAction{
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [self.view addSubview:text];
    [text becomeFirstResponder];
    [text resignFirstResponder];
    [text removeFromSuperview];
}

@end
