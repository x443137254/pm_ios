//
//  ElectricityPriceAllocationView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/5.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "ElectricityPriceAllocationView.h"
#import "ElectricityPriceAllocationCell.h"

@interface ElectricityPriceAllocationView () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation ElectricityPriceAllocationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 0)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.bounces = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    }
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.section == 0) {
        ElectricityPriceAllocationCell *EPACell = [[ElectricityPriceAllocationCell alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 180)];
        EPACell.title.text = @"平时电价";
        EPACell.price.text = @"￥0.91/kWh";
        EPACell.timeStart.text = @"18:00-23:59";
        EPACell.timeStop.text = @"永久有效";
        EPACell.IsEffect.text = @"是";
        [cell addSubview:EPACell];
    } else if (indexPath.section == 1) {
        ElectricityPriceAllocationCell *EPACell = [[ElectricityPriceAllocationCell alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 180)];
        EPACell.title.text = @"谷时电价";
        EPACell.price.text =@"￥0.91/kWh";
        EPACell.timeStart.text = @"18:00-23:59";
        EPACell.timeStop.text = @"永久有效";
        EPACell.IsEffect.text = @"是";
        [cell addSubview:EPACell];
    } else if (indexPath.section == 2) {
        ElectricityPriceAllocationCell *EPACell = [[ElectricityPriceAllocationCell alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 180)];
        EPACell.title.text = @"尖时电价";
        EPACell.price.text =@"￥0.91/kWh";
        EPACell.timeStart.text = @"18:00-23:59";
        EPACell.timeStop.text = @"永久有效";
        EPACell.IsEffect.text = @"是";
        [cell addSubview:EPACell];
    } else {
        ElectricityPriceAllocationCell *EPACell = [[ElectricityPriceAllocationCell alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 180)];
        EPACell.title.text = @"峰时电价";
        EPACell.price.text =@"￥0.91/kWh";
        EPACell.timeStart.text = @"18:00-23:59";
        EPACell.timeStop.text = @"永久有效";
        EPACell.IsEffect.text = @"是";
        [cell addSubview:EPACell];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 65;
    } else {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 65)];
        headView.backgroundColor = [UIColor colorWithRed:2/255.0 green:37/255.0 blue:47/255.0 alpha:1];
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 65)];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = @"设置";
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.font = [UIFont systemFontOfSize:24];
        [headView addSubview:lblTitle];
        
        UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 38, 25, 20, 20)];
        [btnAdd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [headView addSubview:btnAdd];
        
        return headView;
    }
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 10;
    } else {
        return 0.000001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
    } else {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.000001)];
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (!EEPAVC) {
//        EEPAVC = [[EditElectricityPriceViewController alloc] init];
//    }
//    if (indexPath.row == 0) {
//        EEPAVC = [[EditElectricityPriceViewController alloc] init];
//        self.model.name = @"平时电价";
//        self.model.price = @"￥0.91/kWh";
//        self.model.timeStart = @"18:00-23:59";
//        self.model.timeStop = @"永久有效";
//        self.model.IsEffect = @"是";
//    } else if (indexPath.row == 1) {
//        EEPAVC = [[EditElectricityPriceViewController alloc] init];
//        self.model.name = @"谷时电价";
//        self.model.price = @"￥0.91/kWh";
//        self.model.timeStart = @"18:00-23:59";
//        self.model.timeStop = @"永久有效";
//        self.model.IsEffect = @"是";
//    } else if (indexPath.row == 2) {
//        EEPAVC = [[EditElectricityPriceViewController alloc] init];
//        self.model.name = @"尖时电价";
//        self.model.price = @"￥0.91/kWh";
//        self.model.timeStart = @"18:00-23:59";
//        self.model.timeStop = @"永久有效";
//        self.model.IsEffect = @"是";
//    } else if (indexPath.row == 3) {
//        EEPAVC = [[EditElectricityPriceViewController alloc] init];
//        self.model.name = @"峰时电价";
//        self.model.price = @"￥0.91/kWh";
//        self.model.timeStart = @"18:00-23:59";
//        self.model.timeStop = @"永久有效";
//        self.model.IsEffect = @"是";
//    }
//    [EEPAVC loadDataWithModel:self.model];
//    [self.navigationController pushViewController:EEPAVC animated:YES];
//    [EEPAVC loadDataWithModel:self.model];
//}


@end
