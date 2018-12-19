//
//  GenerationViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "GenerationViewController.h"
#import "common.h"
#import "GenerationView.h"
#import "AddCollectorViewController.h"
#import "InterverDetailViewController.h"
#import "GenerationViewPad.h"

@interface GenerationViewController () <GenerationViewControllerDelegate> {
    GenerationView *generationView;
    AddCollectorViewController *ACVC;
    InterverDetailViewController *IDVC;
    
    GenerationViewPad *GVP;
    
    UIImageView *BGImageViewPad;
    UIView *leftView;
    UIButton *btnWeather;
    UILabel *lblWind;
    UILabel *lblWeather;
    
     UIButton *btnPlus;
}

@end

@implementation GenerationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    if ([common isPhone]) {
        [self setNavigationBarPhone];
        self.tabBarController.tabBar.hidden = YES;
        [self setGenerationViewPhone];
        [self loadFootViewPhone];
    } else if ([common isPad]) {
        self.view.backgroundColor = [UIColor colorWithRed:4/255.0 green:43/255.0 blue:57/255.0 alpha:1];
        self.navigationController.navigationBar.hidden = YES;
        self.tabBarController.tabBar.hidden = YES;
        [self loadLeftViewPad];
        [self setGenerationViewPad];
    }
}

#pragma mark - 手机界面

/**
 设置导航条-手机
 */
- (void)setNavigationBarPhone{
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
    self.title = @"发电";
    
    if (!btnPlus) {
        btnPlus = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [btnPlus setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [btnPlus addTarget:self action:@selector(btnPlusClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnPlus];
    self.navigationItem.rightBarButtonItem = btnR;
    
}


/**
 导航条加号功能
 */
- (void)btnPlusClickAction{
    
}


/**
 设置发电页面 - 手机
 */
- (void)setGenerationViewPhone{
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [backImageView setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:backImageView];
    if (!generationView) {
        generationView = [[GenerationView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-44*ProportionX)];
        generationView.backgroundColor = [UIColor clearColor];
    }
    generationView.customDelegate = self;
    [self.view addSubview:generationView];
}


/**
 设置底部tabbar-手机
 */
- (void)loadFootViewPhone{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44*ProportionX, self.view.frame.size.width, 44*ProportionX)];
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44*ProportionX)];
    [footView addSubview:imgBG];
    
    float gap = (self.view.frame.size.width - 44*4 )/5.0;
    float width = 44;
    
    footView.backgroundColor = [UIColor colorWithRed:0/255.0 green:30/255.0 blue:43/255.0 alpha:1];
    
    UIButton *btnHome = [[UIButton alloc] initWithFrame:CGRectMake(gap + (gap+width)*0, 0, 44, 44)];
    [btnHome setTitleColor:[UIColor colorWithRed:0/255.0 green:111/255.0 blue:162/255.0 alpha:1] forState:UIControlStateNormal];
    [btnHome setTitle:@"总览" forState:UIControlStateNormal];
    btnHome.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnHome setImage:[UIImage imageNamed:@"总览"] forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(btnHomeClickAction) forControlEvents:UIControlEventTouchUpInside];
    btnHome.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btnHome setTitleEdgeInsets:UIEdgeInsetsMake(btnHome.imageView.frame.size.height+6 ,-btnHome.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnHome setImageEdgeInsets:UIEdgeInsetsMake(0.0, 6.5,4,0)];//图片距离右边框距离减少图片的宽度，其它不边
    [footView addSubview:btnHome];
    
    
    
    UIButton *btnGeneration = [[UIButton alloc] initWithFrame:CGRectMake(gap + (gap+width)*1, 0, 44, 44)];
    [btnGeneration setUserInteractionEnabled:NO];
    [btnGeneration setAdjustsImageWhenHighlighted:NO];
    [btnGeneration setTitleColor:[UIColor colorWithRed:0 green:255/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
    [btnGeneration setTitle:@"发电" forState:UIControlStateNormal];
    btnGeneration.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnGeneration setImage:[UIImage imageNamed:@"发电_click"] forState:UIControlStateNormal];
    [btnGeneration addTarget:self action:@selector(btnGenerationClickAction) forControlEvents:UIControlEventTouchUpInside];
    btnGeneration.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btnGeneration setTitleEdgeInsets:UIEdgeInsetsMake(btnGeneration.imageView.frame.size.height+6 ,-btnGeneration.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnGeneration setImageEdgeInsets:UIEdgeInsetsMake(0.0, 6.5,4,0)];//图片距离右边框距离减少图片的宽度，其它不边
//    [footView addSubview:btnGeneration];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(btnGeneration.frame.origin.x, btnGeneration.frame.origin.y + btnGeneration.frame.size.height/2.0, btnGeneration.frame.size.width, btnGeneration.frame.size.height/2.0)];
    img.image = [UIImage imageNamed:@"底部-选中-背景"];
    [footView addSubview:img];
    
    [footView addSubview:btnGeneration];
    
    UIButton *btnConsumption = [[UIButton alloc] initWithFrame:CGRectMake(gap + (gap+width)*2, 0, 44, 44)];
    [btnConsumption setTitleColor:[UIColor colorWithRed:0/255.0 green:111/255.0 blue:162/255.0 alpha:1] forState:UIControlStateNormal];
    [btnConsumption setTitle:@"能耗" forState:UIControlStateNormal];
    btnConsumption.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnConsumption setImage:[UIImage imageNamed:@"能耗"] forState:UIControlStateNormal];
    [btnConsumption addTarget:self action:@selector(btnConsumptionClickAction) forControlEvents:UIControlEventTouchUpInside];
    btnConsumption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btnConsumption setTitleEdgeInsets:UIEdgeInsetsMake(btnConsumption.imageView.frame.size.height+6 ,-btnConsumption.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnConsumption setImageEdgeInsets:UIEdgeInsetsMake(0.0, 6.5,4,0)];//图片距离右边框距离减少图片的宽度，其它不边
    [footView addSubview:btnConsumption];
    
    UIButton *btnAnalysis = [[UIButton alloc] initWithFrame:CGRectMake(gap + (gap+width)*3, 0, 44, 44)];
    [btnAnalysis setTitleColor:[UIColor colorWithRed:0/255.0 green:111/255.0 blue:162/255.0 alpha:1] forState:UIControlStateNormal];
    [btnAnalysis setTitle:@"分析" forState:UIControlStateNormal];
    btnAnalysis.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnAnalysis setImage:[UIImage imageNamed:@"分析"] forState:UIControlStateNormal];
    [btnAnalysis addTarget:self action:@selector(btnAnalysisClickAction) forControlEvents:UIControlEventTouchUpInside];
    btnAnalysis.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btnAnalysis setTitleEdgeInsets:UIEdgeInsetsMake(btnAnalysis.imageView.frame.size.height+6 ,-btnAnalysis.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnAnalysis setImageEdgeInsets:UIEdgeInsetsMake(0.0, 6.5,4,0)];//图片距离右边框距离减少图片的宽度，其它不边
    [footView addSubview:btnAnalysis];
    [self.view addSubview:footView];
}

#pragma mark - 平板界面
- (void)setGenerationViewPad{
    
    if (!BGImageViewPad) {
        BGImageViewPad = [[UIImageView alloc]initWithFrame:CGRectMake(69, 0, SCREEN_WIDTH - 69, SCREEN_HEIGHT)];
    }
    [self.view addSubview:BGImageViewPad];
    
    [self setGVP];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"竖版背景"]];
    }else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"竖版背景"]];
    }else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"横版背景"]];
    }else if (orientation == UIInterfaceOrientationLandscapeRight){
        [BGImageViewPad setImage:[UIImage imageNamed:@"横版背景"]];
    }
}

- (void)setGVP{
    if (!GVP) {
        GVP = [[GenerationViewPad alloc] initWithFrame:CGRectMake(69 + 15, 30, SCREEN_WIDTH - 69 - 30, SCREEN_HEIGHT - 60)];
        GVP.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:GVP];
}


- (void)loadLeftViewPad{
    
    if (!leftView) {

        leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 69, SCREEN_HEIGHT)];
        NSLog(@"height = %lf",SCREEN_HEIGHT);
        
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
        [btnHome setTitleColor:[UIColor colorWithRed:0 green:111/255.0 blue:162/255.0 alpha:1] forState:UIControlStateNormal];
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
        [btnGeneration setTitleColor:[UIColor colorWithRed:0 green:255/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
        [btnGeneration setTitle:@"发电" forState:UIControlStateNormal];
        btnGeneration.titleLabel.font = [UIFont systemFontOfSize:16];
        [btnGeneration setImage:[UIImage imageNamed:@"发电_click"] forState:UIControlStateNormal];
        [btnGeneration addTarget:self action:@selector(btnGenerationClickAction) forControlEvents:UIControlEventTouchUpInside];
        //调整图片和文字上下显示
        btnGeneration.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btnGeneration setTitleEdgeInsets:UIEdgeInsetsMake(btnGeneration.imageView.frame.size.height ,-btnGeneration.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnGeneration setImageEdgeInsets:UIEdgeInsetsMake(-btnGeneration.imageView.frame.size.height, 0.0,0.0, -btnGeneration.titleLabel.bounds.size.width)];
        [leftView addSubview:btnGeneration];
        
        UIImageView *btnBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 154+69*1, width, width)];
        btnBG.image = [UIImage imageNamed:@"导航选中背景"];
        [leftView addSubview:btnBG];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)btnClickWithTag:(NSString *)tag{
    NSLog(@"tag = %@",tag);
   if ([tag isEqualToString:@"btnAdd"]) {
        if (!ACVC) {
            ACVC = [[AddCollectorViewController alloc] init];
        }
        [self.navigationController pushViewController:ACVC animated:YES];
    } else if ([tag isEqualToString:@"InterverDetail"]) {
        if (!IDVC) {
            IDVC = [[InterverDetailViewController alloc] init];
        }
        [self.navigationController pushViewController:IDVC animated:YES];
    }
}

#pragma Tabbar 屏幕翻转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    BGImageViewPad.frame = CGRectMake(69, 0, SCREEN_WIDTH - 69, SCREEN_HEIGHT);
    leftView.frame = CGRectMake(0, 0, 69, SCREEN_HEIGHT);
    btnWeather.frame =CGRectMake(0, SCREEN_HEIGHT - 100, 67, 20);
    lblWeather.frame = CGRectMake(0, SCREEN_HEIGHT - 70, 69, 30);
    lblWind.frame = CGRectMake(0, SCREEN_HEIGHT - 40, 69, 30);
    
    [GVP removeFromSuperview];
    
    GVP = [[GenerationViewPad alloc] initWithFrame:CGRectMake(69 + 15, 30, SCREEN_WIDTH - 69 - 30, SCREEN_HEIGHT - 60)];
    [self.view addSubview:GVP];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"横版背景"]];
    }else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"横版背景"]];
    }else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [BGImageViewPad setImage:[UIImage imageNamed:@"竖版背景"]];
    }else if (orientation == UIInterfaceOrientationLandscapeRight){
        [BGImageViewPad setImage:[UIImage imageNamed:@"竖版背景"]];
    }
}


@end
