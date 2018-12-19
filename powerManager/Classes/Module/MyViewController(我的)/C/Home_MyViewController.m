		//
//  Home_MyViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "Home_MyViewController.h"
#import "common.h"
#import "https.h"
#import "ElectricityPriceAllocationViewController.h"
#import "PowerStationInformationMaintenanceViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "CKLeftSlideViewController.h"
#import "PersonalSettingViewController.h"
#import "PersonalCenterViewController.h"
#import "PersonalCenterView.h"

#import "HomeMyView.h"
#import "PersonalSettingView.h"
#import "ElectricityPriceAllocationView.h"
#import "PowerStationInformationMaintenanceView.h"
#import "UserLoginInfo.h"

@interface Home_MyViewController () <UITableViewDelegate,UITableViewDataSource,Home_MyViewControllerDelegate> {
    
    ElectricityPriceAllocationViewController *EPAVC;
    PowerStationInformationMaintenanceViewController *PSIMVC;
    
    PersonalCenterViewController *PCVC;
    PersonalCenterView *PCV;
    CKLeftSlideViewController *leftSlide;
    PersonalSettingViewController *PSVC;
    LoginViewController *LVC;
    HomeMyView *HMV;
    PersonalSettingView *PSV;
    ElectricityPriceAllocationView *EPAV;
    PowerStationInformationMaintenanceView *PSIMV;
    
    UserLoginInfo *model;
    

    
    UIImageView *BGImageViewPad;
    UIView *leftView;
    UIButton *btnWeather;
    UILabel *lblWind;
    UILabel *lblWeather;
}

@end

@implementation Home_MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginSuccess) name:@"LoginSuccess" object:nil];

}

- (void)viewWillAppear:(BOOL)animated{
    [self getData];
    if ([common isPhone]) {
        [self setNavigationBar];
        if (!self.tableView) {
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT+20)];
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            self.tableView.backgroundColor = [UIColor colorWithRed:3/255.0 green:45/255.0 blue:59/255.0 alpha:1];
            self.tableView.bounces = NO;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        [self.view addSubview:self.tableView];
        self.navigationController.navigationBar.hidden = YES;
    } else if ([common isPad]) {
        self.navigationController.navigationBar.hidden = YES;
        [self loadLeftViewPad];
        if (!BGImageViewPad) {
            BGImageViewPad = [[UIImageView alloc]initWithFrame:CGRectMake(69, 0, SCREEN_WIDTH - 69, SCREEN_HEIGHT)];
            [BGImageViewPad setImage:[UIImage imageNamed:@"横版背景"]];
        }
        [self.view addSubview:BGImageViewPad];

        if (HMV) {
            [HMV removeFromSuperview];
        }
        
        if (!HMV) {
            UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
            if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
                HMV = [[HomeMyView alloc] initWithFrame:CGRectMake(69+15, 30, SCREEN_WIDTH - 375 - 69 - 30, SCREEN_HEIGHT-60)];
            }else {
                HMV = [[HomeMyView alloc] initWithFrame:CGRectMake(69+15, 30, 375, SCREEN_HEIGHT-60)];
            }
            HMV.layer.masksToBounds = YES;
            HMV.layer.cornerRadius = 10;
            HMV.layer.borderWidth = 1;
            HMV.layer.borderColor = [[UIColor colorWithRed:7/255.0 green:61/255.0 blue:80/255.0 alpha:1]CGColor];
            HMV.customDelegate = self;

        }
        [self.view addSubview:HMV];
        [self setPersonalView];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.tableView removeFromSuperview];
}

- (void)LoginSuccess{
    dispatch_async(dispatch_get_main_queue(), ^{
        [HMV removeFromSuperview];
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            HMV = [[HomeMyView alloc] initWithFrame:CGRectMake(69+15, 30, SCREEN_WIDTH - 375 - 69 - 30, SCREEN_HEIGHT-60)];
        }else {
            HMV = [[HomeMyView alloc] initWithFrame:CGRectMake(69+15, 30, 375, SCREEN_HEIGHT-60)];
        }
        HMV.layer.masksToBounds = YES;
        HMV.layer.cornerRadius = 10;
        HMV.layer.borderWidth = 1;
        HMV.layer.borderColor = [[UIColor colorWithRed:7/255.0 green:61/255.0 blue:80/255.0 alpha:1]CGColor];
        HMV.customDelegate = self;
        [self.view addSubview:HMV];
    });
}

- (void)getData{
    if (!model) {
        model = [[UserLoginInfo alloc] init];
    }
    NSLog(@"123");
    if (![[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT]) {
        model.account = @"未登录";
        model.companyName = @"";
    } else if ([[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT].length == 0) {
        model.account = @"未登录";
        model.companyName = @"";
    } else if ([[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT].length > 0) {
        model.account = [[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT];
        model.companyName = [[NSUserDefaults standardUserDefaults] stringForKey:COMPANYNAME];
    } else {
        model.account = @"未登录";
        model.companyName = @"";
    }
    [HMV.tableView reloadData];
}



#pragma mark - 手机界面
- (void)setNavigationBar{
    self.title = @"我的";
    UIColor *color = [UIColor blackColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.tintColor  = [UIColor blackColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([common isPhone]) {
        return SCREEN_HEIGHT - 124*ProportionX - 54*ProportionX;
    } else {
        return tableView.frame.size.height - 90 - 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([common isPhone]) {
        return 124*ProportionX;
    } else {
        return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([common isPhone]) {
        return 54*ProportionX;
    } else {
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    [self getData];
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 124*ProportionX)];
        headView.backgroundColor = [UIColor colorWithRed:2/255.0 green:38/255.0 blue:50/255.0 alpha:1];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10*ProportionX, 44*ProportionX, 60*ProportionX, 60*ProportionX)];
        img.backgroundColor = [UIColor colorWithRed:2/255.0 green:91/255.0 blue:130/255.0 alpha:1];
        img.layer.masksToBounds = YES;
        img.layer.cornerRadius = 30*ProportionX;
        img.layer.borderWidth = 2;
        img.image = [UIImage imageNamed:@"默认头像"];
        img.layer.borderColor = [[UIColor colorWithRed:2/255.0 green:38/255.0 blue:90/255.0 alpha:0.8]CGColor];
        [headView addSubview:img];
        //    70 44 - 40  /  70 84 - 20
        UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(80*ProportionX, 44*ProportionX, self.view.frame.size.width - 70*ProportionX, 40*ProportionX)];
        lblName.text = model.account;
        lblName.font = [UIFont systemFontOfSize:22*ProportionX];
        lblName.textColor = [UIColor whiteColor];
        lblName.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:lblName];
        
        UILabel *lblCompany = [[UILabel alloc] initWithFrame:CGRectMake(80*ProportionX, 84*ProportionX, self.view.frame.size.width - 70*ProportionX, 20*ProportionX)];
        lblCompany.text = model.companyName;
        lblCompany.font = FontS;
        lblCompany.textColor = [UIColor colorWithRed:94/255.0 green:181/255.0 blue:224/255.0 alpha:1];
        lblCompany.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:lblCompany];
        
        UIButton *btnMy = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, headView.frame.size.width,  headView.frame.size.height)];
        [btnMy addTarget:self action:@selector(btnMyClickAction) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:btnMy];
        
        return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100*ProportionX)];
        footView.backgroundColor = [UIColor colorWithRed:2/255.0 green:38/255.0 blue:50/255.0 alpha:1];
        
        UIButton *btnSet = [[UIButton alloc] initWithFrame:CGRectMake(20*ProportionX, 19.5*ProportionX, 17*ProportionX, 15*ProportionX)];
        [btnSet setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [btnSet addTarget:self action:@selector(btnSetClickAction) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:btnSet];
        
        UIButton *btnSetL = [[UIButton alloc] initWithFrame:CGRectMake(46*ProportionX, 19.5*ProportionX, 40*ProportionX, 15*ProportionX)];
        [btnSetL setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnSetL setTitle:@"设置" forState:UIControlStateNormal];
        [btnSetL addTarget:self action:@selector(btnSetClickAction) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:btnSetL];
        
        
        return footView;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:3/255.0 green:45/255.0 blue:59/255.0 alpha:1];
        
        UIImageView *imgInfo = [[UIImageView alloc] initWithFrame:CGRectMake(19*ProportionX, 19*ProportionX, 25*ProportionX, 25*ProportionX)];
        imgInfo.image = [UIImage imageNamed:@"user_电站信息维护"];
        [cell addSubview:imgInfo];
        
        UILabel *lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(53*ProportionX, 19*ProportionX, self.view.frame.size.width - 38*ProportionX, 25*ProportionX)];
        lblInfo.textAlignment = NSTextAlignmentLeft;
        lblInfo.text = @"电站信息维护";
        lblInfo.textColor = [UIColor whiteColor];
        lblInfo.font = FontL;
        [cell addSubview:lblInfo];

        UIButton *btnInfo = [[UIButton alloc] initWithFrame:CGRectMake(0*ProportionX, 19*ProportionX, self.view.frame.size.width, 25*ProportionX)];
        [btnInfo addTarget:self action:@selector(btnBatteryInformationMaintenanceClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnInfo];
        
        UIImageView *imgSet = [[UIImageView alloc] initWithFrame:CGRectMake(19*ProportionX, 58*ProportionX, 25*ProportionX, 25*ProportionX)];
        imgSet.image = [UIImage imageNamed:@"user_电价配置"];
        [cell addSubview:imgSet];
        
        UILabel *lblElectricityPriceAllocation = [[UILabel alloc] initWithFrame:CGRectMake(53*ProportionX, 58*ProportionX, self.view.frame.size.width - 38*ProportionX, 25*ProportionX)];
        lblElectricityPriceAllocation.textAlignment = NSTextAlignmentLeft;
        lblElectricityPriceAllocation.text = @"电价配置";
        lblElectricityPriceAllocation.textColor = [UIColor whiteColor];
        lblElectricityPriceAllocation.font = FontL;
        [cell addSubview:lblElectricityPriceAllocation];
        
        UIButton *btnElectricityPriceAllocation = [[UIButton alloc] initWithFrame:CGRectMake(0*ProportionX, 58*ProportionX, self.view.frame.size.width, 25*ProportionX)];
        [btnElectricityPriceAllocation addTarget:self action:@selector(btnElectricityPriceAllocationClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnElectricityPriceAllocation];

        return cell;
   
}

- (void)btnMyClickAction{
    
//    NSLog(@"123");
    //这里判断跳登录还是个人页面
    NSString *token;
    if (![[NSUserDefaults standardUserDefaults] stringForKey:TOKEN]) {
        token = @"";
    } else {
        token = [[NSUserDefaults standardUserDefaults] stringForKey:TOKEN];
    }
    if (token.length > 0) {
        if (!PCVC) {
            PCVC = [[PersonalCenterViewController alloc] init];
        }
        if (!leftSlide) {
            leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
        }
        [leftSlide closeLeftView];
        [leftSlide.navigationController pushViewController:PCVC animated:NO];
    } else {
        if (!LVC) {
            LVC = [[LoginViewController alloc] init];
        }
        if (!leftSlide) {
            leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
        }
        [leftSlide closeLeftView];
        [leftSlide.navigationController pushViewController:LVC animated:NO];
    }
}

- (void)btnBatteryInformationMaintenanceClickAction{
    if ([common isPhone]) {
        
        NSString *token;
        if (![[NSUserDefaults standardUserDefaults] stringForKey:TOKEN]) {
            token = @"";
        } else {
            token = [[NSUserDefaults standardUserDefaults] stringForKey:TOKEN];
        }
        if (token.length > 0) {
            if (!PSIMVC) {
                PSIMVC = [[PowerStationInformationMaintenanceViewController alloc] init];
            }
            if (!leftSlide) {
                leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
            }
            [leftSlide closeLeftView];
            [leftSlide.navigationController pushViewController:PSIMVC animated:YES];
        } else {
            if (!LVC) {
                LVC = [[LoginViewController alloc] init];
            }
            if (!leftSlide) {
                leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
            }
            [leftSlide closeLeftView];
            [leftSlide.navigationController pushViewController:LVC animated:NO];
        }
    }
}

- (void)btnElectricityPriceAllocationClickAction{
    if ([common isPhone]) {
        
        
        NSString *token;
        if (![[NSUserDefaults standardUserDefaults] stringForKey:TOKEN]) {
            token = @"";
        } else {
            token = [[NSUserDefaults standardUserDefaults] stringForKey:TOKEN];
        }
        if (token.length > 0) {
            if (!EPAVC) {
                EPAVC = [[ElectricityPriceAllocationViewController alloc] init];
            }
            if (!leftSlide) {
                leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
            }
            [leftSlide closeLeftView];
            [leftSlide.navigationController pushViewController:EPAVC animated:YES];
        } else {
            if (!LVC) {
                LVC = [[LoginViewController alloc] init];
            }
            if (!leftSlide) {
                leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
            }
            [leftSlide closeLeftView];
            [leftSlide.navigationController pushViewController:LVC animated:NO];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnSetClickAction{
    if (!PSVC) {
        PSVC = [[PersonalSettingViewController alloc] init];
    }
    if (!leftSlide) {
        leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
    }
    [leftSlide closeLeftView];
    [leftSlide.navigationController pushViewController:PSVC animated:YES];
}

#pragma mark - 平板界面

- (void)loadLeftViewPad{
    if (!leftView) {
        leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 69, SCREEN_HEIGHT)];
        
        float width = 69;
        float gap = (69 - width)/2.0;
        
        leftView.backgroundColor = [UIColor colorWithRed:2/255.0 green:33/255.0 blue:43/255.0 alpha:1];
        
        UIButton *btnHead = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [btnHead setBackgroundColor:[UIColor colorWithRed:2/255.0 green:28/255.0 blue:37/255.0 alpha:0]];
        [btnHead setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
        [btnHead setImage:[UIImage imageNamed:@"默认头像_click"] forState:UIControlStateHighlighted];
        [btnHead addTarget:self action:@selector(btnHeadClickActioN) forControlEvents:UIControlEventTouchUpInside];
        btnHead.center = CGPointMake(69/2.0, 70);
        [leftView addSubview:btnHead];
        
        UIButton *btnHome = [[UIButton alloc] initWithFrame:CGRectMake(gap, 154 + 69 *0, width, width)];
        [btnHome setAdjustsImageWhenHighlighted:NO];
        [btnHome setTitleColor:[UIColor colorWithRed:0/255.0 green:111/255.0 blue:162/255.0 alpha:1] forState:UIControlStateNormal];
        [btnHome setTitle:@"总览" forState:UIControlStateNormal];
        btnHome.titleLabel.font = [UIFont systemFontOfSize:16];
        [btnHome setImage:[UIImage imageNamed:@"总览"] forState:UIControlStateNormal];
        [btnHome addTarget:self action:@selector(btnHomeClickAction) forControlEvents:UIControlEventTouchUpInside];
        //调整图片和文字上下显示
        btnHome.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btnHome setTitleEdgeInsets:UIEdgeInsetsMake(btnHome.imageView.frame.size.height ,-btnHome.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnHome setImageEdgeInsets:UIEdgeInsetsMake(-btnHome.imageView.frame.size.height, 0.0,0.0, -btnHome.titleLabel.bounds.size.width)];
        [leftView addSubview:btnHome];

        
        UIButton *btnGeneration = [[UIButton alloc] initWithFrame:CGRectMake(gap, 154 + 69 *1, width, width)];
        [btnGeneration setTitleColor:[UIColor colorWithRed:0/255.0 green:111/255.0 blue:162/255.0 alpha:1] forState:UIControlStateNormal];
        [btnGeneration setTitle:@"发电" forState:UIControlStateNormal];
        btnGeneration.titleLabel.font = [UIFont systemFontOfSize:16];
        [btnGeneration setImage:[UIImage imageNamed:@"发电"] forState:UIControlStateNormal];
        [btnGeneration addTarget:self action:@selector(btnGenerationClickAction) forControlEvents:UIControlEventTouchUpInside];
        //调整图片和文字上下显示
        btnGeneration.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btnGeneration setTitleEdgeInsets:UIEdgeInsetsMake(btnGeneration.imageView.frame.size.height ,-btnGeneration.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnGeneration setImageEdgeInsets:UIEdgeInsetsMake(-btnGeneration.imageView.frame.size.height, 0.0,0.0, -btnGeneration.titleLabel.bounds.size.width)];
        [leftView addSubview:btnGeneration];
        
        UIButton *btnConsumption = [[UIButton alloc] initWithFrame:CGRectMake(gap, 154 + 69 *2, width, width)];
        [btnConsumption setTitleColor:[UIColor colorWithRed:0/255.0 green:111/255.0 blue:162/255.0 alpha:1] forState:UIControlStateNormal];
        [btnConsumption setTitle:@"能耗" forState:UIControlStateNormal];
        btnConsumption.titleLabel.font = [UIFont systemFontOfSize:16];
        [btnConsumption setImage:[UIImage imageNamed:@"能耗"] forState:UIControlStateNormal];
        [btnConsumption addTarget:self action:@selector(btnConsumptionClickAction) forControlEvents:UIControlEventTouchUpInside];
        //调整图片和文字上下显示
        btnConsumption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btnConsumption setTitleEdgeInsets:UIEdgeInsetsMake(btnConsumption.imageView.frame.size.height ,-btnConsumption.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnConsumption setImageEdgeInsets:UIEdgeInsetsMake(-btnConsumption.imageView.frame.size.height, 0.0,0.0, -btnConsumption.titleLabel.bounds.size.width)];
        [leftView addSubview:btnConsumption];
        
        UIButton *btnAnalysis = [[UIButton alloc] initWithFrame:CGRectMake(gap, 154 + 69 *3, width, width)];
        [btnAnalysis setTitleColor:[UIColor colorWithRed:0/255.0 green:111/255.0 blue:162/255.0 alpha:1] forState:UIControlStateNormal];
        [btnAnalysis setTitle:@"分析" forState:UIControlStateNormal];
        btnAnalysis.titleLabel.font = [UIFont systemFontOfSize:16];
        [btnAnalysis setImage:[UIImage imageNamed:@"分析"] forState:UIControlStateNormal];
        [btnAnalysis addTarget:self action:@selector(btnAnalysisClickAction) forControlEvents:UIControlEventTouchUpInside];
        //调整图片和文字上下显示
        btnAnalysis.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btnAnalysis setTitleEdgeInsets:UIEdgeInsetsMake(btnAnalysis.imageView.frame.size.height ,-btnAnalysis.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnAnalysis setImageEdgeInsets:UIEdgeInsetsMake(-btnAnalysis.imageView.frame.size.height, 0.0,0.0, -btnAnalysis.titleLabel.bounds.size.width)];
        [leftView addSubview:btnAnalysis];
        
        btnWeather = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, 67, 20)];
        [btnWeather setImage:[UIImage imageNamed:@"weather_sun"]forState:UIControlStateNormal];
        [btnWeather setTitle:@"晴" forState:UIControlStateNormal];
        [leftView addSubview:btnWeather];
        
        lblWeather = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 70, 69, 30)];
        lblWeather.text = @"28～30°";
        lblWeather.textColor = [UIColor colorWithRed:77/255.0 green:170/255.0 blue:212/255.0 alpha:1];;
        [leftView addSubview:lblWeather];
        
        lblWind = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, 69, 30)];
        lblWind.text = @"东风6级";
        lblWind.textColor = [UIColor colorWithRed:77/255.0 green:170/255.0 blue:212/255.0 alpha:1];
        [leftView addSubview:lblWind];
    }
    [self.view addSubview:leftView];
}

- (void)btnHomeClickAction{
    self.tabBarController.selectedIndex = 0;
}

- (void)btnGenerationClickAction{
    self.tabBarController.selectedIndex = 1;
}

- (void)btnConsumptionClickAction{
    self.tabBarController.selectedIndex = 2;
}

- (void)btnAnalysisClickAction{
    self.tabBarController.selectedIndex = 3;
}

- (void)btnHeadClickActioN{
    self.tabBarController.selectedIndex = 4;
}

#pragma mark - 屏幕翻转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
//    NSLog(@"height = %f",size.height);
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BGImageViewPad.frame = CGRectMake(69, 0, size.width - 69, size.height);
    leftView.frame = CGRectMake(0, 0, 69, size.height);
    btnWeather.frame =CGRectMake(0, size.height - 100, 67, 20);
    lblWeather.frame = CGRectMake(0, size.height - 70, 69, 30);
    lblWind.frame = CGRectMake(0, size.height - 40, 69, 30);
    

    if (orientation == UIInterfaceOrientationPortrait) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"竖版背景"]];
        HMV.frame = CGRectMake(69+15, 30, 375, size.height-60);
        PCV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 552, size.height-60);
        PSV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 552, size.height-60);
        EPAV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 552, size.height-60);
        PSIMV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 552, size.height-60);
    }else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"竖版背景"]];
        HMV.frame = CGRectMake(69+15, 30, 375, size.height-60);
        PCV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 552, size.height-60);
        PSV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 552, size.height-60);
        EPAV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 552, size.height-60);
        PSIMV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 552, size.height-60);
    }else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"横版背景"]];
        HMV.frame = CGRectMake(69+15, 30, size.width - 69 - 30 - 375, size.height-60);
        PCV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 375, size.height-60);
        PSV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 375, size.height-60);
        EPAV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 375, size.height-60);
        PSIMV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 375, size.height-60);
    }else if (orientation == UIInterfaceOrientationLandscapeRight){
        [BGImageViewPad setImage:[UIImage imageNamed:@"横版背景"]];
        HMV.frame = CGRectMake(69+15, 30, size.width - 69 - 30 - 375, size.height-60);
        PCV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 375, size.height-60);
        PSV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 375, size.height-60);
        EPAV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 375, size.height-60);
        PSIMV.frame = CGRectMake(69+15 + HMV.frame.size.width -1, 30, 375, size.height-60);
    }else {
        //        [backImageViewPad setImage:[UIImage imageNamed:@"登录竖版背景"]];
    }
    
    HMV.tableView.frame = CGRectMake(0, 0, HMV.frame.size.width, HMV.frame.size.height);
    [HMV.tableView reloadData];
    PCV.tableView.frame = CGRectMake(0, 0, PCV.frame.size.width, PCV.frame.size.height);
    [PCV.tableView reloadData];
    PSV.tableView.frame = CGRectMake(0, 0, PSV.frame.size.width, PSV.frame.size.height);
    [PSV.tableView reloadData];
    EPAV.tableView.frame = CGRectMake(0, 0, EPAV.frame.size.width, EPAV.frame.size.height-0);
    [EPAV.tableView reloadData];
    PSIMV.tableView.frame = CGRectMake(0, 0, PSIMV.frame.size.width, PSIMV.frame.size.height-0);
    [PSIMV.tableView reloadData];
}

#pragma mark - 按钮方法
- (void)btnClickWithTag:(NSString *)tag{
    NSLog(@"tag = %@",tag);
    if ([tag isEqualToString:@"Personal"]) {
        [PSV removeFromSuperview];
        [EPAV removeFromSuperview];
        [PSIMV removeFromSuperview];
        [self setPersonalView];
    }  else if ([tag isEqualToString:@"Info"]) {
        [PCV removeFromSuperview];
        [PSV removeFromSuperview];
        [EPAV removeFromSuperview];
        [self setInfoView];
    } else if ([tag isEqualToString:@"Price"]) {
        [PCV removeFromSuperview];
        [PSV removeFromSuperview];
        [PSIMV removeFromSuperview];
        [self setPriceView];
        
    } else if ([tag isEqualToString:@"Set"]) {
        [PCV removeFromSuperview];
        [EPAV removeFromSuperview];
        [PSIMV removeFromSuperview];
        [self setSettingView];
    } else if ([tag isEqualToString:@"Exit"]) {
        if (!LVC) {
            LVC = [[LoginViewController alloc] init];
        }
//        [self.navigationController presentViewController:LVC animated:YES completion:nil];
        [self.navigationController pushViewController:LVC animated:YES];
    }
    
}

- (void)setPersonalView{
    if (!PCV) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            PCV = [[PersonalCenterView alloc] initWithFrame:CGRectMake(69+15+HMV.frame.size.width-1, 30, 375, SCREEN_HEIGHT-60)];
        }else {
            PCV = [[PersonalCenterView alloc] initWithFrame:CGRectMake(69+15+HMV.frame.size.width-1, 30, SCREEN_WIDTH - (69+30+HMV.frame.size.width), SCREEN_HEIGHT-60)];
        }
        PCV.customDelegate = self;
        PCV.backgroundColor = [UIColor clearColor];
        PCV.layer.masksToBounds = YES;
        PCV.layer.cornerRadius = 10;
        PCV.layer.borderWidth = 1;
        PCV.layer.borderColor = [[UIColor colorWithRed:7/255.0 green:61/255.0 blue:88/255.0 alpha:1] CGColor];
    }
    [self.view addSubview:PCV];
}

- (void)setSettingView{
    if (!PSV) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            PSV = [[PersonalSettingView alloc] initWithFrame:CGRectMake(69+15+HMV.frame.size.width-1, 30, 375, SCREEN_HEIGHT-60)];
        }else {
            PSV = [[PersonalSettingView alloc] initWithFrame:CGRectMake(69+15+HMV.frame.size.width-1, 30, SCREEN_WIDTH - (69+30+HMV.frame.size.width), SCREEN_HEIGHT-60)];
        }
        PSV.customDelegate = self;
        PSV.backgroundColor = [UIColor clearColor];
        PSV.layer.masksToBounds = YES;
        PSV.layer.cornerRadius = 10;
        PSV.layer.borderWidth = 1;
        PSV.layer.borderColor = [[UIColor colorWithRed:7/255.0 green:61/255.0 blue:88/255.0 alpha:1] CGColor];
    }
    [self.view addSubview:PSV];
}

- (void)setPriceView{
    if (!EPAV) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            EPAV = [[ElectricityPriceAllocationView alloc] initWithFrame:CGRectMake(69+15+HMV.frame.size.width-1, 30, 375, SCREEN_HEIGHT-60)];
        }else {
            EPAV = [[ElectricityPriceAllocationView alloc] initWithFrame:CGRectMake(69+15+HMV.frame.size.width-1, 30, SCREEN_WIDTH - (69+30+HMV.frame.size.width), SCREEN_HEIGHT-60)];
        }
        EPAV.customDelegate = self;
        EPAV.backgroundColor = [UIColor clearColor];
        EPAV.layer.masksToBounds = YES;
        EPAV.layer.cornerRadius = 10;
        EPAV.layer.borderWidth = 1;
        EPAV.layer.borderColor = [[UIColor colorWithRed:7/255.0 green:61/255.0 blue:88/255.0 alpha:1] CGColor];
    }
    [self.view addSubview:EPAV];
}

- (void)setInfoView{
    if (!PSIMV) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            PSIMV = [[PowerStationInformationMaintenanceView alloc] initWithFrame:CGRectMake(69+15+HMV.frame.size.width-1, 30, 375, SCREEN_HEIGHT-60)];
        }else {
            PSIMV = [[PowerStationInformationMaintenanceView alloc] initWithFrame:CGRectMake(69+15+HMV.frame.size.width-1, 30, SCREEN_WIDTH - (69+30+HMV.frame.size.width), SCREEN_HEIGHT-60)];
        }
        PSIMV.customDelegate = self;
        PSIMV.backgroundColor = [UIColor clearColor];
        PSIMV.layer.masksToBounds = YES;
        PSIMV.layer.cornerRadius = 10;
        PSIMV.layer.borderWidth = 1;
        PSIMV.layer.borderColor = [[UIColor colorWithRed:7/255.0 green:61/255.0 blue:88/255.0 alpha:1] CGColor];
    }
    [self.view addSubview:PSIMV];
}

@end
