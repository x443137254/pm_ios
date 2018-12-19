//
//  HomeMyView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/4.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "HomeMyView.h"
#import "common.h"
#import "UserLoginInfo.h"
#import "https.h"

@interface HomeMyView () <UITableViewDelegate,UITableViewDataSource> {
    UserLoginInfo *model;
}

@end

@implementation HomeMyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
        [self getData];
    }
    return self;
}

- (void)getData{
    if (!model) {
        model = [[UserLoginInfo alloc] init];
    }
    
    if (![[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT]) {
        model.account = @"未登录";
        model.companyName = @"";
    } else if ([[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT].length == 0) {
        model.account = @"未登录";
        model.companyName = @"";
    } else if ([[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT].length > 0) {
        model.account = [[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT];
        model.companyName = [[NSUserDefaults standardUserDefaults] stringForKey:COMPANYNAME];
    }
    [self.tableView reloadData];
}

- (void)loadView{
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.bounces = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self addSubview:self.tableView];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 180/2.0;
        } else if (indexPath.row == 1) {
            return 130/2.0;
        } else if (indexPath.row == 2) {
            return 130/2.0;
        } else {
            return tableView.frame.size.height - 180/2.0 - 130/2.0 - 130/2.0 - 50;
        }
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.00000001)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    footView.backgroundColor = [UIColor colorWithRed:2/255.0 green:38/255.0 blue:50/255.0 alpha:1];
        
    UIButton *btnSet = [[UIButton alloc] initWithFrame:CGRectMake(20, 17.5, 17, 15)];
    [btnSet setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [btnSet addTarget:self action:@selector(btnSetClickAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnSet];
    
    UIButton *btnSetL = [[UIButton alloc] initWithFrame:CGRectMake(46, 17.5, 40, 15)];
    [btnSetL setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSetL setTitle:@"设置" forState:UIControlStateNormal];
    [btnSetL addTarget:self action:@selector(btnSetClickAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnSetL];
    
    UIButton *btnExit = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 60, 50)];
    [btnExit setTitle:@"退出" forState:UIControlStateNormal];
    [btnExit addTarget:self action:@selector(btnExitClickAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnExit];

    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:7/255.0 green:67/255.0 blue:87/255.0 alpha:1];
    [footView addSubview:lblLine];
    
    return footView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = RGB_HEX(0x07455a, 1);
            
            
            UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 300, 50)];
            lblName.text = model.account;
            lblName.font = [UIFont systemFontOfSize:24];
            lblName.textColor = [UIColor whiteColor];
            lblName.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:lblName];
            
            UILabel *lblCompany = [[UILabel alloc] initWithFrame:CGRectMake(22, 50, 300, 40)];
            lblCompany.text = model.companyName;
            lblCompany.font = [UIFont systemFontOfSize:18];
            lblCompany.textColor = [UIColor colorWithRed:94/255.0 green:181/255.0 blue:224/255.0 alpha:1];
            lblCompany.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:lblCompany];
            
            UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, self.frame.size.width, 1)];
            lblLine.backgroundColor = [UIColor colorWithRed:7/255.0 green:67/255.0 blue:87/255.0 alpha:1];
            [cell addSubview:lblLine];
            
        } else if (indexPath.row == 1) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = RGB_HEX(0x07455a, 1);
            
            UIImageView *imgInfo = [[UIImageView alloc] initWithFrame:CGRectMake(22, 20, 25, 25)];
            imgInfo.image = [UIImage imageNamed:@"user_电站信息维护"];
            [cell addSubview:imgInfo];
            
            UILabel *lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.frame.size.width - 60, 65)];
            lblInfo.textAlignment = NSTextAlignmentLeft;
            lblInfo.text = @"电站信息维护";
            lblInfo.textColor = [UIColor whiteColor];
            lblInfo.font = [UIFont systemFontOfSize:20];
            [cell addSubview:lblInfo];
            
            UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, self.frame.size.width, 1)];
            lblLine.backgroundColor = [UIColor colorWithRed:7/255.0 green:67/255.0 blue:87/255.0 alpha:1];
            [cell addSubview:lblLine];
            
        } else if (indexPath.row == 2) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = RGB_HEX(0x07455a, 1);
            
            UIImageView *imgSet = [[UIImageView alloc] initWithFrame:CGRectMake(22, 20, 25, 25)];
            imgSet.image = [UIImage imageNamed:@"user_电价配置"];
            [cell addSubview:imgSet];
            
            UILabel *lblElectricityPriceAllocation = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.frame.size.width - 60, 65)];
            lblElectricityPriceAllocation.textAlignment = NSTextAlignmentLeft;
            lblElectricityPriceAllocation.text = @"电价配置";
            lblElectricityPriceAllocation.textColor = [UIColor whiteColor];
            lblElectricityPriceAllocation.font = [UIFont systemFontOfSize:20];
            [cell addSubview:lblElectricityPriceAllocation];
            
            UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, self.frame.size.width, 1)];
            lblLine.backgroundColor = [UIColor colorWithRed:7/255.0 green:67/255.0 blue:87/255.0 alpha:1];
            [cell addSubview:lblLine];
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT].length == 0 || ![[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT]) {
        if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
            [self.customDelegate btnClickWithTag:@"Exit"];
        }
    } else {
        if (indexPath.row == 0) {
            [self btnPersonalClickAction];
        } else if (indexPath.row == 1){
            [self btnInfoClickAction];
        } else if (indexPath.row == 2) {
            [self btnPriceClickAction];
        }
    }
}



- (void)btnPersonalClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"Personal"];
    }
}

- (void)btnSetClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"Set"];
    }
}

- (void)btnInfoClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"Info"];
    }
}

- (void)btnPriceClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"Price"];
    }
}

- (void)btnExitClickAction{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出" message:@"退出当前账号" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        if (![[NSUserDefaults standardUserDefaults] stringForKey:ACCOUNT]) {
            [self makeToast:@"未登录账号"];
        } else {

            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:ACCOUNT];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:ACCOUNT];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:CID];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:CID];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UNIQUEID];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UNIQUEID];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:PASSWORD];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:PASSWORD];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:COMPANYNAME];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:COMPANYNAME];
            [[NSUserDefaults standardUserDefaults] synchronize];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];

            [self getData];

            [self.tableView reloadData];

            [self makeToast:@"退出成功"];
        }
    }];

    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:actionCancel];
    [alert addAction:actionSure];

    [[self getCurrentVC] presentViewController:alert animated:YES completion:nil];

//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:ACCOUNT];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ACCOUNT];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:CID];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CID];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UNIQUEID];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UNIQUEID];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:PASSWORD];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PASSWORD];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:COMPANYNAME];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:COMPANYNAME];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
//
//    [self getData];
//
//    [self.tableView reloadData];


//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"Exit"];
//    }
}


- (UIViewController *)getCurrentVC  {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)  {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)  {
            if (tmpWin.windowLevel == UIWindowLevelNormal)  {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}


@end
