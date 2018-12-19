//
//  AirConditionViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/30.
//  Copyright © 2018年 tuolve. All rights reserved.
//


#import "AirConditionViewController.h"
#import "common.h"
#import "OfficeAirConditionerViewController.h"

@interface AirConditionViewController () <UITableViewDelegate,UITableViewDataSource>{
     UITableView *tableView;
    OfficeAirConditionerViewController *OACVC;
    
    UILabel *lblLine;
    UIButton *btn3;
    UIButton *btn2;
    UIButton *btn1;
    UIButton *btn0;
}

@end

@implementation AirConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self setNavigationBar];
    [self getDta];
    [self setAirConditionView];
}


- (void)getDta{
    
}


- (void)setAirConditionView{
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
    self.title = @"空调";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50*ProportionX;
    } else if (indexPath.section == 1) {
        return 45*ProportionX;
    } else {
        return 110*ProportionX;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.section == 0) {
        UIImageView *imgA = [[UIImageView alloc] initWithFrame:CGRectMake(57*ProportionX, 10*ProportionX, 40*ProportionX, 40*ProportionX)];
        imgA.image = [UIImage imageNamed:@"列表_空调数"];
        [cell addSubview:imgA];
        
        UILabel *lblDA = [[UILabel alloc] initWithFrame:CGRectMake(103*ProportionX, 10*ProportionX, 100*ProportionX, 20*ProportionX)];
        lblDA.textColor = [UIColor whiteColor];
        lblDA.textAlignment = NSTextAlignmentLeft;
        lblDA.text = @"20台";
        [cell addSubview:lblDA];
        
        UILabel *lblA = [[UILabel alloc] initWithFrame:CGRectMake(103*ProportionX, 10*ProportionX + 20, 100*ProportionX, 20*ProportionX)];
        lblA.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:240/255.0 alpha:1];
        lblA.textAlignment = NSTextAlignmentLeft;
        lblA.text = @"空调数";
        [cell addSubview:lblA];
        
        UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake(205*ProportionX, 10*ProportionX, 40*ProportionX, 40*ProportionX)];
        imgC.image = [UIImage imageNamed:@"列表_耗电"];
        [cell addSubview:imgC];
        
        UILabel *lblDC = [[UILabel alloc] initWithFrame:CGRectMake(249*ProportionX, 10*ProportionX, 100*ProportionX, 20*ProportionX)];
        lblDC.textColor = [UIColor whiteColor];
        lblDC.textAlignment = NSTextAlignmentLeft;
        lblDC.text = @"300kwh";
        [cell addSubview:lblDC];
        
        UILabel *lblC = [[UILabel alloc] initWithFrame:CGRectMake(247*ProportionX, 10*ProportionX + 20, 100*ProportionX, 20*ProportionX)];
        lblC.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:240/255.0 alpha:1];
        lblC.textAlignment = NSTextAlignmentLeft;
        lblC.text = @"总消耗";
        [cell addSubview:lblC];
    } else if (indexPath.section == 1) {
        cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        
        btn0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/4.0, 45*ProportionX)];
        [btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn0 setTitle:@"全部20" forState:UIControlStateNormal];
        [btn0 addTarget:self action:@selector(btn0ClickAction) forControlEvents:UIControlEventTouchUpInside];
        btn0.titleLabel.font = Font16;
        [cell addSubview:btn0];
        
        btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4.0, 0, self.view.frame.size.width/4.0, 45*ProportionX)];
        [btn1 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn1 setTitle:@"运行中18" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btn1ClickAction) forControlEvents:UIControlEventTouchUpInside];
        btn1.titleLabel.font = Font16;
        [cell addSubview:btn1];
        
        btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4.0 *2, 0, self.view.frame.size.width/4.0, 45*ProportionX)];
        [btn2 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn2 setTitle:@"待机2" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btn2ClickAction) forControlEvents:UIControlEventTouchUpInside];
        btn2.titleLabel.font = Font16;
        [cell addSubview:btn2];

        btn3 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4.0 *3, 0, self.view.frame.size.width/4.0, 45*ProportionX)];
        [btn3 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn3 setTitle:@"故障0" forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(btn3ClickAction) forControlEvents:UIControlEventTouchUpInside];
        btn3.titleLabel.font = Font16;
        [cell addSubview:btn3];
       
        lblLine = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/16.0, 44*ProportionX, self.view.frame.size.width/8.0, 2)];
        lblLine.backgroundColor = [UIColor whiteColor];
        [cell addSubview:lblLine];
        
    } else {
        UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 110*ProportionX)];
        imgBG.layer.masksToBounds = YES;
        imgBG.layer.cornerRadius = 10;
        imgBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        [cell addSubview:imgBG];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 10)];
        img.image = [UIImage imageNamed:@"高光"];
        [cell addSubview:img];
        
        UIImageView *imgStatus = [[UIImageView alloc] initWithFrame:CGRectMake(24*ProportionX, 20*ProportionX, 70*ProportionX, 70*ProportionX)];
        imgStatus.layer.masksToBounds = YES;
        imgStatus.layer.cornerRadius = 35*ProportionX;
        imgStatus.layer.borderWidth = 1;
        imgStatus.layer.borderColor = [[UIColor colorWithRed:13/255.0 green:208/255.0 blue:135/255.0 alpha:1] CGColor];
        [cell addSubview:imgStatus];
        
        UIImageView *imgDevice = [[UIImageView alloc] initWithFrame:CGRectMake((24+35)*ProportionX - 10*ProportionX, 34*ProportionX, 20*ProportionX, 20*ProportionX)];
        imgDevice.image = [UIImage imageNamed:@"详情_aircondition"];
        [cell addSubview:imgDevice];
        
        UILabel *lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(24*ProportionX, 57*ProportionX, 70*ProportionX, 20*ProportionX)];
        lblStatus.textAlignment = NSTextAlignmentCenter;
        lblStatus.textColor = [UIColor colorWithRed:13/255.0 green:208/255.0 blue:135/255.0 alpha:1];
        lblStatus.text = @"运行中";
        [cell addSubview:lblStatus];
        
        UILabel *lblL = [[UILabel alloc] initWithFrame:CGRectMake(110*ProportionX, 10*ProportionX, self.view.frame.size.width - 130*ProportionX, 40*ProportionX)];
        lblL.textAlignment = NSTextAlignmentLeft;
        lblL.textColor = [UIColor whiteColor];
        lblL.text = @"会议室空调";
        lblL.font = FontL;
        [cell addSubview:lblL];
        
        UILabel *lblDIsOn = [[UILabel alloc] initWithFrame:CGRectMake(110*ProportionX, 55*ProportionX, 130*ProportionX, 20*ProportionX)];
        lblDIsOn.textAlignment = NSTextAlignmentLeft;
        lblDIsOn.textColor = [UIColor whiteColor];
        lblDIsOn.text = @"在线";
        [cell addSubview:lblDIsOn];
        
        UILabel *lblIsOn = [[UILabel alloc] initWithFrame:CGRectMake(110*ProportionX, 75*ProportionX, 130*ProportionX, 20*ProportionX)];
        lblIsOn.textAlignment = NSTextAlignmentLeft;
        lblIsOn.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:218/255.0 alpha:1];
        lblIsOn.text = @"采集状态";
        [cell addSubview:lblIsOn];
        
        UILabel *lblDT = [[UILabel alloc] initWithFrame:CGRectMake(220*ProportionX, 55*ProportionX, 130*ProportionX, 20*ProportionX)];
        lblDT.textAlignment = NSTextAlignmentLeft;
        lblDT.textColor = [UIColor whiteColor];
        lblDT.text = @"29º";
        [cell addSubview:lblDT];
        
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(220*ProportionX, 75*ProportionX, 130*ProportionX, 20*ProportionX)];
        lblT.textAlignment = NSTextAlignmentLeft;
        lblT.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:218/255.0 alpha:1];
        lblT.text = @"房间温度";
        [cell addSubview:lblT];
        
        if (indexPath.section == 3) {
            imgStatus.layer.borderColor = [[UIColor colorWithRed:0/255.0 green:174/255.0 blue:232/255.0 alpha:1] CGColor];
            lblStatus.text = @"待机";
        } else if (indexPath.section == 4) {
            imgStatus.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:54/255.0 blue:76/255.0 alpha:1] CGColor];
            lblStatus.text = @"故障";
        } else {

        }
        
    }
    return cell;
}

- (void)btn0ClickAction{
    [UIView animateWithDuration:0.5 animations:^{
        lblLine.frame = CGRectMake(self.view.frame.size.width/16 * 1, 44*ProportionX, self.view.frame.size.width/8.0, 2);
        [btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
    }];
}

- (void)btn1ClickAction{
    [UIView animateWithDuration:0.5 animations:^{
        lblLine.frame = CGRectMake(self.view.frame.size.width/16 * 5, 44*ProportionX, self.view.frame.size.width/8.0, 2);
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn0 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
    }];
}

- (void)btn2ClickAction{
    [UIView animateWithDuration:0.5 animations:^{
        lblLine.frame = CGRectMake(self.view.frame.size.width/16 * 9, 44*ProportionX, self.view.frame.size.width/8.0, 2);
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn0 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
    }];
}

- (void)btn3ClickAction{
    [UIView animateWithDuration:0.5 animations:^{
        lblLine.frame = CGRectMake(self.view.frame.size.width/16 * 13, 44*ProportionX, self.view.frame.size.width/8.0, 2);
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn0 setTitleColor:[UIColor colorWithRed:4/255.0 green:126/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*ProportionX;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10*ProportionX)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!OACVC) {
        OACVC = [[OfficeAirConditionerViewController alloc] init];
    }
    [self.navigationController pushViewController:OACVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
