//
//  PersonalSettingView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/5.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "PersonalSettingView.h"
#import "common.h"

@interface PersonalSettingView () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation PersonalSettingView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        self.tableView.bounces = NO;
    }
    [self addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    UILabel *lblContent = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, self.frame.size.width - 100 - 40, 45)];
    lblContent.textAlignment = NSTextAlignmentRight;
    lblContent.textColor = [UIColor colorWithRed:89/255.0 green:180/255.0 blue:221/255.0 alpha:1];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine];
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 1)];
    lblLine0.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine0];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"当前版本";
        lblContent.text  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"清除缓存";
        lblContent.text = @"20M";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = @"客服电话";
        lblContent.text = @"4009313122";
    }
    [cell addSubview:lblContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 65)];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 65)];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.text = @"设置";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont systemFontOfSize:24];
    [headView addSubview:lblTitle];
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"点击确定清除缓存" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[self getCurrentVC].view makeToast:@"Success"];
        }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:actionSure];
        [alert addAction:actionCancel];
        [[self getCurrentVC] presentViewController:alert animated:YES completion:nil];
    }
}

//获取当前屏幕显示的viewcontroller
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
