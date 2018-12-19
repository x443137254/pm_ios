//
//  BatteryDetailsViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/17.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "BatteryDetailsViewController.h"
#import "common.h"

@interface BatteryDetailsViewController ()

@end

@implementation BatteryDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self setNavigationBar];
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
    self.title = @"电量详情";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
