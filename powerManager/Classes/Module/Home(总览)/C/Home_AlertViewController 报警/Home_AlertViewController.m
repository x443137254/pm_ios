
//
//  Home_AlertViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/27.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "Home_AlertViewController.h"
#import "common.h"
#import "AlertDetailViewController.h"

@interface Home_AlertViewController () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    NSArray *arrayList;
    AlertDetailViewController *ADVC;
}

@end

@implementation Home_AlertViewController

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
    arrayList = @[@"02:31",@"2018年7月28日02:31"];
    [self.view addSubview:tableView];
}

- (void)setNavigationBar{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"告警消息";
    
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
    return 50*ProportionX;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50*ProportionX)];
    UILabel *lblTop = [[UILabel alloc] initWithFrame:CGRectMake(0, 16*ProportionX, self.view.frame.size.width, 25*ProportionX)];
    lblTop.layer.masksToBounds = YES;
    lblTop.layer.cornerRadius = 12.5*ProportionX;
    lblTop.layer.borderWidth = 1;
    lblTop.layer.borderColor = [[UIColor colorWithRed:1/255.0 green:102/255.0 blue:133/255.0 alpha:1] CGColor];
    lblTop.textColor = [UIColor whiteColor];
    lblTop.font = FontM;
    lblTop.textAlignment = NSTextAlignmentCenter;
    for (int i = 0; i <arrayList.count; i++) {
        if (section == i) {
            lblTop.text = [arrayList objectAtIndex:i];
            CGSize size = [lblTop.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FontM,NSFontAttributeName,nil]];
            lblTop.frame = CGRectMake((self.view.frame.size.width - size.width - 30*ProportionX)/2.0, 16*ProportionX, size.width + 30*ProportionX, 25*ProportionX);
        }
    }
    [headView addSubview:lblTop];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000000001)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*ProportionX;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    UIImageView *cellBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 100*ProportionX)];
    cellBG.backgroundColor = [UIColor colorWithRed:0 green:31/255.0 blue:40/255.0 alpha:0.8];
    cellBG.layer.masksToBounds = YES;
    cellBG.layer.cornerRadius = 10;
    [cell addSubview:cellBG];
    
    UIImageView *cellFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 10)];
    cellFrame.image = [UIImage imageNamed:@"高光"];
    [cell addSubview:cellFrame];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(32*ProportionX, 30*ProportionX, 40*ProportionX, 40*ProportionX)];
    img.image = [UIImage imageNamed:@"message_告警"];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(90*ProportionX, 15*ProportionX, self.view.frame.size.width - 93*ProportionX, 20*ProportionX)];
    lblTitle.textColor = [UIColor whiteColor];
    
    UILabel *lblDetail = [[UILabel alloc] initWithFrame:CGRectMake(90*ProportionX, 40*ProportionX, self.view.frame.size.width - 93*ProportionX, 20*ProportionX)];
    lblDetail.textColor = [UIColor colorWithRed:88/255.0 green:191/255.0 blue:237/255.0 alpha:1];
    lblDetail.font = FontS;
    
    UILabel *lblCode = [[UILabel alloc] initWithFrame:CGRectMake(90*ProportionX, 65*ProportionX, self.view.frame.size.width - 90*ProportionX, 20*ProportionX)];
    lblCode.textColor = [UIColor colorWithRed:88/255.0 green:191/255.0 blue:237/255.0 alpha:1];
    lblCode.font = FontS;
    
    if (indexPath.section == 0) {
        lblTitle.text = @"逆变器";
        lblDetail.text = @"机器编码:AD5679";
        lblCode.text = @"故障码:123";
    } else if (indexPath.section == 1) {
        lblTitle.text = @"逆变器";
        lblDetail.text = @"机器编码:AD5679";
        lblCode.text = @"故障码:123";
    }
    
    [cell addSubview:img];
    [cell addSubview:lblTitle];
    [cell addSubview:lblDetail];
    [cell addSubview:lblCode];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!ADVC) {
        ADVC = [[AlertDetailViewController alloc] init];
    }
    [self.navigationController pushViewController:ADVC animated:YES];
}



@end
