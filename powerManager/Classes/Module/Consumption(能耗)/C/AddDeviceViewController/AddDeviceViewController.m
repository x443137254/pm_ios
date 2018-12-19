//
//  AddDeviceViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/30.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "common.h"

@interface AddDeviceViewController () <UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView;
}

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self setNavigationBar];
    [self getDta];
    [self setGetDeviceView];
}

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
    self.title = @"添加设备";
}


- (void)getDta{
    
}


- (void)setGetDeviceView{
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
        [backImageView setImage:[UIImage imageNamed:@"bg"]];
        [self.view addSubview:backImageView];
    }
    [self.view addSubview:tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130*ProportionX;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 130*ProportionX)];
    imgBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    imgBG.layer.masksToBounds = YES;
    imgBG.layer.cornerRadius = 10;
    [cell addSubview:imgBG];
    
    UIImageView *imgF = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 10)];
    imgF.image = [UIImage imageNamed:@"高光"];
    [cell addSubview:imgF];
    
    if (indexPath.section == 0) {
        UIButton *btnA = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 50*ProportionX)/2.0, 20*ProportionX, 50*ProportionX, 50*ProportionX)];
        [btnA setBackgroundImage:[UIImage imageNamed:@"add_aircondition"] forState:UIControlStateNormal];
        [cell addSubview:btnA];
        
        UILabel *lblC = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*ProportionX, self.view.frame.size.width, 40*ProportionX)];
        lblC.textAlignment = NSTextAlignmentCenter;
        lblC.textColor = [UIColor whiteColor];
        lblC.text = @"空调";
        lblC.font = Font18;
        [cell addSubview:lblC];
    } else if (indexPath.section == 1) {
        UIButton *btnL = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 50*ProportionX)/2.0, 20*ProportionX, 50*ProportionX, 50*ProportionX)];
        [btnL setBackgroundImage:[UIImage imageNamed:@"add_light"] forState:UIControlStateNormal];
        [cell addSubview:btnL];
        
        UILabel *lblC = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*ProportionX, self.view.frame.size.width, 40*ProportionX)];
        lblC.textAlignment = NSTextAlignmentCenter;
        lblC.textColor = [UIColor whiteColor];
        lblC.text = @"照明";
        lblC.font = Font18;
        [cell addSubview:lblC];
    } else {
        UIButton *btnC = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 50*ProportionX)/2.0, 20*ProportionX, 50*ProportionX, 50*ProportionX)];
        [btnC setBackgroundImage:[UIImage imageNamed:@"add_charger"] forState:UIControlStateNormal];
        [cell addSubview:btnC];
        
        UILabel *lblC = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*ProportionX, self.view.frame.size.width, 40*ProportionX)];
        lblC.textAlignment = NSTextAlignmentCenter;
        lblC.textColor = [UIColor whiteColor];
        lblC.text = @"充电桩";
        lblC.font = Font18;
        [cell addSubview:lblC];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40*ProportionX;
    } else {
        return 22*ProportionX;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40*ProportionX)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = Font14;
        label.text = @"请选择设备类型";
        return label;
    }
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22*ProportionX)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
