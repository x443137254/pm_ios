//
//  OfficeAirConditionerViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/30.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "OfficeAirConditionerViewController.h"
#import "common.h"

@interface OfficeAirConditionerViewController () <UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView;

    
}


@end

@implementation OfficeAirConditionerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
    [self setView];
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
    self.title = @"办公室空调";
}

- (void)setView{
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [backImageView setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:backImageView];
    
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
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 5;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200*ProportionX;
    } else if (indexPath.section == 1) {
        return 45*ProportionX;
    } else {
        return 210*ProportionX;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        UIButton *btnSwitch = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 85*ProportionX)/2.0, 0, 85*ProportionX, 85*ProportionX)];
        [btnSwitch setImage:[UIImage imageNamed:@"详情_on"] forState:UIControlStateNormal];
        [cell addSubview:btnSwitch];
        
        UILabel *lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 85*ProportionX, self.view.frame.size.width, 20*ProportionX)];
        lblStatus.textColor = [UIColor whiteColor];
        lblStatus.textAlignment = NSTextAlignmentCenter;
        lblStatus.text = @"运行中";
        [cell addSubview:lblStatus];
        
        float width = 40*ProportionX;
        float gap = (self.view.frame.size.width/3.0 -width)/2.0;
        
        UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(gap + self.view.frame.size.width/3.0*0, 105*ProportionX+10*ProportionX, width, width)];
        img0.image = [UIImage imageNamed:@"详情_p"];
        [cell addSubview:img0];
        
        UILabel *lblDP = [[UILabel alloc] initWithFrame:CGRectMake(0, img0.frame.origin.y + img0.frame.size.height , self.view.frame.size.width/3.0, 20*ProportionX)];
        lblDP.textAlignment = NSTextAlignmentCenter;
        lblDP.textColor = [UIColor whiteColor];
        lblDP.text = @"50000w";
        [cell addSubview:lblDP];
        
        UILabel *lblP = [[UILabel alloc] initWithFrame:CGRectMake(0, img0.frame.origin.y + img0.frame.size.height + 20*ProportionX, self.view.frame.size.width/3.0, 20*ProportionX)];
        lblP.textAlignment = NSTextAlignmentCenter;
        lblP.textColor = [UIColor colorWithRed:87/255.0 green:188/255.0 blue:235/255.0 alpha:1];
        lblP.text = @"功率";
        [cell addSubview:lblP];
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(gap + self.view.frame.size.width/3.0*1, 105*ProportionX+10*ProportionX, width, width)];
        img1.image = [UIImage imageNamed:@"详情_A"];
        [cell addSubview:img1];
        
        UILabel *lblDV = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3.0 , img1.frame.origin.y + img1.frame.size.height , self.view.frame.size.width/3.0, 20*ProportionX)];
        lblDV.textAlignment = NSTextAlignmentCenter;
        lblDV.textColor = [UIColor whiteColor];
        lblDV.text = @"16A";
        [cell addSubview:lblDV];
        
        UILabel *lblV = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3.0 , img1.frame.origin.y + img1.frame.size.height + 20*ProportionX, self.view.frame.size.width/3.0, 20*ProportionX)];
        lblV.textAlignment = NSTextAlignmentCenter;
        lblV.textColor = [UIColor colorWithRed:87/255.0 green:188/255.0 blue:235/255.0 alpha:1];
        lblV.text = @"电流";
        [cell addSubview:lblV];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(gap + self.view.frame.size.width/3.0*2, 105*ProportionX+10*ProportionX, width, width)];
        img2.image = [UIImage imageNamed:@"详情_V"];
        [cell addSubview:img2];
        
        UILabel *lblDA = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3.0 *2, img2.frame.origin.y + img2.frame.size.height , self.view.frame.size.width/3.0, 20*ProportionX)];
        lblDA.textAlignment = NSTextAlignmentCenter;
        lblDA.textColor = [UIColor whiteColor];
        lblDA.text = @"201V";
        [cell addSubview:lblDA];
        
        UILabel *lblA = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3.0 *2, img2.frame.origin.y + img2.frame.size.height + 20*ProportionX, self.view.frame.size.width/3.0, 20*ProportionX)];
        lblA.textAlignment = NSTextAlignmentCenter;
        lblA.textColor = [UIColor colorWithRed:87/255.0 green:188/255.0 blue:235/255.0 alpha:1];
        lblA.text = @"电压";
        [cell addSubview:lblA];
        
        
    } else {
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    }
    
    if (indexPath.section == 1)  {
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        }
        cell.textLabel.textColor = [UIColor whiteColor];
        UILabel *lblC = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0, 0, self.view.frame.size.width/2.0 - 20, 45*ProportionX)];
        lblC.textAlignment = NSTextAlignmentRight;
        lblC.text = @"在线";
        lblC.textColor = [UIColor whiteColor];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"采集状态";
            lblC.text = @"在线";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"房间温度";
            lblC.text = @"26º";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"设定温度";
            lblC.text = @"26º";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"序列号";
            lblC.text = @"484865F22";
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"区域";
            lblC.text = @"A栋";
        }
        [cell addSubview:lblC];
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        lblT.backgroundColor = [UIColor colorWithRed:7/255.0 green:70/255.0 blue:91/255.0 alpha:1];
        [cell addSubview:lblT];
        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*ProportionX, self.view.frame.size.width, 1)];
        lblB.backgroundColor = [UIColor colorWithRed:7/255.0 green:70/255.0 blue:91/255.0 alpha:1];
        [cell addSubview:lblB];
        
    }
    
    if (indexPath.section == 2) {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45*ProportionX)];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = @"累计耗电:9722kwh";
        lblTitle.font = FontTitle;
        [cell addSubview:lblTitle];
        
        UIButton *btn7 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 130*ProportionX)/2.0, 48*ProportionX, 30*ProportionX, 30*ProportionX)];
        [btn7 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:127/255.0 blue:213/255.0 alpha:1]];
        btn7.layer.masksToBounds = YES;
        btn7.layer.cornerRadius = 15*ProportionX;
        btn7.layer.borderWidth = 1;
        btn7.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:127/255.0 blue:213/255.0 alpha:1] CGColor];
        [btn7 setTitle:@"7" forState:UIControlStateNormal];
        [cell addSubview:btn7];
//
        UIButton *btn30 = [[UIButton alloc] initWithFrame:CGRectMake(btn7.frame.origin.x + btn7.frame.size.width + 20*ProportionX, 48*ProportionX, 30*ProportionX, 30*ProportionX)];
        btn30.layer.masksToBounds = YES;
        btn30.layer.cornerRadius = 15*ProportionX;
        btn30.layer.borderWidth = 1;
        btn30.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:127/255.0 blue:213/255.0 alpha:1] CGColor];
        [btn30 setTitle:@"30" forState:UIControlStateNormal];
        [cell addSubview:btn30];
        
        UIButton *btnZ = [[UIButton alloc] initWithFrame:CGRectMake(btn30.frame.origin.x + btn30.frame.size.width + 20*ProportionX, 48*ProportionX, 30*ProportionX, 30*ProportionX)];
        btnZ.layer.masksToBounds = YES;
        btnZ.layer.cornerRadius = 15*ProportionX;
        btnZ.layer.borderWidth = 1;
        btnZ.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:127/255.0 blue:213/255.0 alpha:1] CGColor];
        [btnZ setTitle:@"总" forState:UIControlStateNormal];
        [cell addSubview:btnZ];
        
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*ProportionX;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10*ProportionX)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
