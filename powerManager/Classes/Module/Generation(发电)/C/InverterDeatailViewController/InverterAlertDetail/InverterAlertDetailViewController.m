//
//  InverterAlertDetailViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/17.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "InverterAlertDetailViewController.h"
#import "common.h"

@interface InverterAlertDetailViewController ()

@end

@implementation InverterAlertDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self setNavigationBar];
    [self setInverterAlertDetailView];
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
    self.title = @"告警详情";
}

- (void)setInverterAlertDetailView{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 30*ProportionX * 0, self.view.frame.size.width - 60*ProportionX, 30*ProportionX)];
    lbl.font = FontS;
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    lbl.text = @"机器编号:AD5678";
    [self.view addSubview:lbl];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 30*ProportionX * 1, self.view.frame.size.width - 60*ProportionX, 30*ProportionX)];
    lbl1.font = FontS;
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    lbl1.text = @"机器名称:逆变器";
    [self.view addSubview:lbl1];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 30*ProportionX * 2, self.view.frame.size.width - 60*ProportionX, 30*ProportionX)];
    lbl2.font = FontS;
    lbl2.textAlignment = NSTextAlignmentLeft;
    lbl2.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    lbl2.text = @"区域:123";
    [self.view addSubview:lbl2];
    
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 30*ProportionX * 3, self.view.frame.size.width - 60*ProportionX, 30*ProportionX)];
    lbl3.font = FontS;
    lbl3.textAlignment = NSTextAlignmentLeft;
    lbl3.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    lbl3.text = @"故障码:123";
    [self.view addSubview:lbl3];
    
    UILabel *lbl4 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 30*ProportionX * 4, self.view.frame.size.width - 60*ProportionX, 30*ProportionX)];
    lbl4.font = FontS;
    lbl4.textAlignment = NSTextAlignmentLeft;
    lbl4.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    lbl4.text = @"故障时间:2018-09-09";
    [self.view addSubview:lbl4];
    
    UILabel *lbl5 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 30*ProportionX * 5, self.view.frame.size.width - 60*ProportionX, 30*ProportionX)];
    lbl5.font = FontS;
    lbl5.textAlignment = NSTextAlignmentLeft;
    lbl5.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    lbl5.text = @"故障描述:坏了";
    [self.view addSubview:lbl5];
    
    UILabel *lbl6 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 30*ProportionX * 7, self.view.frame.size.width - 60*ProportionX, 30*ProportionX)];
    lbl6.font = FontS;
    lbl6.textAlignment = NSTextAlignmentLeft;
    lbl6.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1];
    lbl6.text = @"建议解决方案:建议解决方案建议解决方案建议解决方案";
    [self.view addSubview:lbl6];
    
    
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
