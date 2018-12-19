//
//  Home_NoticeViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "Home_NoticeViewController.h"
#import "common.h"
#import "AlertDetailViewController.h"
#import "ReportDetailsViewController.h"

@interface Home_NoticeViewController () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    AlertDetailViewController *ADVC;
    ReportDetailsViewController *RDVC;
}

@end

@implementation Home_NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
    
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
        [backImageView setImage:[UIImage imageNamed:@"bg"]];
        tableView.backgroundView= backImageView;
        
    }
    [self.view addSubview:tableView];
}

- (void)setNavigationBar{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"通知";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20*ProportionX;
    } else {
        return 0.0000000001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20*ProportionX)];
    } else {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000000001)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5*ProportionX;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10*ProportionX)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73*ProportionX;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:1/255.0 green:31/255.0 blue:40/255.0 alpha:0.8];
    
    UILabel *lblTop = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    lblTop.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
    [cell addSubview:lblTop];
    
    UILabel *lblButtom = [[UILabel alloc] initWithFrame:CGRectMake(0, 73*ProportionX - 1, self.view.frame.size.width, 1)];
    lblButtom.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
    [cell addSubview:lblButtom];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20*ProportionX, 24*ProportionX, 25*ProportionX, 25*ProportionX)];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(63*ProportionX, 15*ProportionX, self.view.frame.size.width - 63*ProportionX, 20*ProportionX)];
    lblTitle.textColor = [UIColor whiteColor];
    
    UILabel *lblDetail = [[UILabel alloc] initWithFrame:CGRectMake(63*ProportionX, 40*ProportionX, self.view.frame.size.width - 63*ProportionX, 20*ProportionX)];
    lblDetail.textColor = [UIColor colorWithRed:88/255.0 green:191/255.0 blue:237/255.0 alpha:1];
    lblDetail.font = FontS;
    
    UILabel *lblTime = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0, 15*ProportionX, self.view.frame.size.width/2.0 - 20, 20*ProportionX)];
    lblTime.textAlignment = NSTextAlignmentRight;
    lblTime.textColor = [UIColor whiteColor];
    
    if (indexPath.section == 0) {
        img.image = [UIImage imageNamed:@"message_月耗电"];
        lblTitle.text = @"7月耗电报表";
        lblDetail.text = @"上月累计用电:876543kWh";
        lblTime.text = @"09:30";
    } else if (indexPath.section == 1) {
        img.image = [UIImage imageNamed:@"message_告警"];
        lblTitle.text = @"告警消息";
        lblDetail.text = @"逆变器告警";
        lblTime.text = @"8月30号";
    }
    
    [cell addSubview:img];
    [cell addSubview:lblTitle];
    [cell addSubview:lblDetail];
    [cell addSubview:lblTime];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (!RDVC) {
            RDVC = [[ReportDetailsViewController alloc] init];
        }
        [self.navigationController pushViewController:RDVC animated:YES];
    }
    if (indexPath.section == 1) {
        if (!ADVC) {
            ADVC = [[AlertDetailViewController alloc] init];
        }
        [self.navigationController pushViewController:ADVC animated:YES];
    }
}



@end
