
//
//  AddCollectorViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/17.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "AddCollectorViewController.h"
#import "common.h"

@interface AddCollectorViewController () {
    UITextField *textSerialNumber;
    UITextField *textCheckCode;
}

@end

@implementation AddCollectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self setNavigationBar];
    [self setCollectorView];
}


- (void)setNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"imgNavigationBar"] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIColor *color = [UIColor blackColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"添加采集器";
}

- (void)setCollectorView{
    UIButton *btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [btnM addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnM];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];

    textSerialNumber = [[UITextField alloc] initWithFrame:CGRectMake(30*ProportionX, 60*ProportionX, self.view.frame.size.width - 60*ProportionX, 50*ProportionX)];
    textSerialNumber.layer.masksToBounds = YES;
    textSerialNumber.layer.cornerRadius = 25*ProportionX;
    textSerialNumber.layer.borderColor = [[UIColor grayColor] CGColor];
    textSerialNumber.layer.borderWidth = 1;
    textSerialNumber.placeholder = @"请输入采集器序列号";
    textSerialNumber.backgroundColor = [UIColor whiteColor];
    textSerialNumber.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textSerialNumber];
    
    textCheckCode = [[UITextField alloc] initWithFrame:CGRectMake(30*ProportionX, 130*ProportionX, self.view.frame.size.width - 60*ProportionX, 50*ProportionX)];
    textCheckCode.layer.masksToBounds = YES;
    textCheckCode.layer.cornerRadius = 25*ProportionX;
    textCheckCode.layer.borderColor = [[UIColor grayColor] CGColor];
    textCheckCode.layer.borderWidth = 1;
    textCheckCode.placeholder = @"请输入采集器校验码";
    textCheckCode.backgroundColor = [UIColor whiteColor];
    textCheckCode.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textCheckCode];
    
    UIButton *btnSure = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 160*ProportionX)/2.0, 220*ProportionX, 160*ProportionX, 30*ProportionX)];
    btnSure.layer.masksToBounds = YES;
    btnSure.layer.cornerRadius = 15*ProportionX;
    btnSure.layer.borderWidth = 1;
    btnSure.layer.borderColor = [[UIColor blueColor]CGColor];
    [btnSure setBackgroundColor:[UIColor blueColor]];
    [btnSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSure setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:btnSure];

    UIButton *btnScan = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 280*ProportionX)/2.0, 340*ProportionX, 280*ProportionX, 60*ProportionX)];
    btnScan.layer.masksToBounds = YES;
    btnScan.layer.cornerRadius = 30*ProportionX;
    btnScan.layer.borderWidth = 1;
    btnScan.layer.borderColor = [[UIColor blueColor]CGColor];
    [btnScan setBackgroundColor:[UIColor blueColor]];
    [btnScan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnScan setTitle:@"扫描条形码" forState:UIControlStateNormal];
    [self.view addSubview:btnScan];
    
    
}

- (void)btnMClickAction{
    [textCheckCode resignFirstResponder];
    [textSerialNumber resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
