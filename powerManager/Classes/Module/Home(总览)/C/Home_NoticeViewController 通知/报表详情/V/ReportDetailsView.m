//
//  ReportDetailsView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/21.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "ReportDetailsView.h"
#import "common.h"
#import "EnergyReportView.h"
#import "CostReportView.h"
#import "TotolReportView.h"


#pragma clang diagnostic push
#pragma ide diagnostic ignored "CannotResolve"
@interface ReportDetailsView () <UITableViewDataSource,UITableViewDelegate>
{
    EnergyReportView *ERV;
    TotolReportView *TRV;
}


@end

@implementation ReportDetailsView

/**
 * 重写initwithframe方法
 * @param frame 传入frame
 * @return 返回重写好的view
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self loadView];
    }
    return self;
}

/**
 * 主方法
 */
- (void)loadView
{
    NSLog(@"123");
    self.backgroundColor = RGB_HEX(0xffffff, 0);
    if ([common isPhone])
    {
        if (!self.tableView) {
            self.tableView = [[UITableView alloc] init];
        }
        self.tableView.backgroundColor = RGB_HEX(0xffffff, 0);
        self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        [self addSubview:self.tableView];
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 1;
    }
    else
    {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 163;
    }
    else if (indexPath.section == 1)
    {
        return 215;
    }
    else
    {

        if (indexPath.row == 0)
        {
            return (CGFloat) (182/2.0);
        }
        else
        {
            return (CGFloat) ((CGFloat) (200+60)/2.0);
        }

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nil"];
    cell.backgroundColor = RGB_HEX(0xffffff, 0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = RGB_HEX(0xffffff, 1);
    lblTitle.font = [UIFont systemFontOfSize:20];

    if (indexPath.section == 0)
    {
        lblTitle.textAlignment = NSTextAlignmentLeft;
        lblTitle.text = @"月综合报表";

        UILabel *lblTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
        lblTime.textAlignment = NSTextAlignmentRight;
        lblTime.text = @"2017-07";
        lblTime.textColor = RGB_HEX(0xffffff, 1);
        lblTime.font = [UIFont systemFontOfSize:18];
        [cell addSubview:lblTime];

        [self loadReportView];
        [cell addSubview:TRV];
    }
    else if (indexPath.section == 1)
    {
        [self loadEnergyView];
        lblTitle.text = @"发电明细";
        [cell addSubview:ERV];
    }
    else
    {

        if (indexPath.row == 0)
        {
            UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 182/2.0 + 130*4)];
            imgBG.backgroundColor = RGB_HEX(0x000000, 0.4);
            imgBG.layer.masksToBounds = YES;
            imgBG.layer.cornerRadius = 10;
            [cell addSubview:imgBG];

            UIImageView *imgFrame = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
            imgFrame.image = [UIImage imageNamed:@"高光"];
            [cell addSubview:imgFrame];

            lblTitle.text = @"耗电明细";
            [self loadCostView];
        } else {
            CostReportView *CRV = [[CostReportView alloc] initWithFrame:CGRectMake(0, 15, tableView.frame.size.width, 100)];
            [cell addSubview:CRV];
        }
    }


    [cell addSubview:lblTitle];


    return cell;
}


/**
 月综合报表
 */
- (void)loadReportView
{
    if (!TRV) {
        TRV = [[NSBundle mainBundle] loadNibNamed:@"TotolReportView"
                                            owner:self
                                          options:nil].lastObject;
    }
    TRV.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 163);
    [TRV updateView];
}


/**
 发电明细
 */
- (void)loadEnergyView
{
    if (!ERV)
    {
        ERV = [[NSBundle mainBundle] loadNibNamed:@"EnergyReportView"
                                            owner:self
                                          options:nil].lastObject;
    }
    ERV.frame = CGRectMake(0, 0, self.frame.size.width, 215);
    ERV.layer.masksToBounds = YES;
    ERV.layer.cornerRadius = 10;
    [ERV updateView];

}


/**
 耗电明细
 */
- (void)loadCostView
{

}


@end


#pragma clang diagnostic pop
