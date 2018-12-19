//
//  AlertDetailViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/27.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "AlertDetailViewController.h"
#import "common.h"

@interface AlertDetailViewController () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    UIButton *btnSave;
}


@end

@implementation AlertDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
    [self getData];
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

- (void)getData{
    
}

- (void)setNavigationBar{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"报警详情";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    } else if (section == 1) {
        return 1;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*ProportionX;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15*ProportionX, 0, self.view.frame.size.width/2.0 - 15*ProportionX, 45*ProportionX)];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = FontL;
    
    UILabel *lblContent = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0, 0, self.view.frame.size.width/2.0 -5, 45*ProportionX)];
    lblContent.textAlignment = NSTextAlignmentRight;
    lblContent.textColor = [UIColor whiteColor];
    lblContent.font = FontL;
    
    if (indexPath.row %2 == 1) {
        cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            lblTitle.text = @"机器编码";
            lblContent.text = @"AD5679";
        } else if (indexPath.row == 1) {
            lblTitle.text = @"机器名称";
            lblContent.text = @"逆变器";
        } else if (indexPath.row == 2) {
            lblTitle.text = @"故障码";
            lblContent.text = @"123";
        } else if (indexPath.row == 3) {
            lblTitle.text = @"故障值";
            lblContent.text = @"123";
        } else if (indexPath.row == 4) {
            lblTitle.text = @"故障时间";
            lblContent.text = @"2018-07-12 19:02:45";
        }
    } else if (indexPath.section == 1) {
        lblTitle.font = FontM;
        lblTitle.text = @"故障故障";
    } else {
        lblTitle.font = FontM;
        lblTitle.text = @"解决方案";
    }
    [cell addSubview:lblTitle];
    [cell addSubview:lblContent];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 5*ProportionX;
    } else {
        return 40*ProportionX;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40*ProportionX)];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(22*ProportionX, 20*ProportionX, self.view.frame.size.width - 25*ProportionX, 15*ProportionX)];
    lblTitle.font = FontS;
    lblTitle.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 39*ProportionX, self.view.frame.size.width, 1*ProportionX)];
    lblLine.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];

    if (section == 0) {
        lblLine.frame = CGRectMake(0, 4*ProportionX, self.view.frame.size.width, 1*ProportionX);
        lblLine.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        
    } else if (section == 1) {
        lblTitle.text = @"详细描述";
        lblLine.frame = CGRectMake(0, 39*ProportionX, self.view.frame.size.width, 1*ProportionX);
    } else {
        lblTitle.text = @"建议解决方案";
        lblLine.frame = CGRectMake(0, 39*ProportionX, self.view.frame.size.width, 1*ProportionX);
    }
    [viewHead addSubview:lblLine];
    [viewHead addSubview:lblTitle];
    return viewHead;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1*ProportionX;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1*ProportionX)];
    footView.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
    return footView;
}

- (void)btnSaveClickAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnDateClickAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
