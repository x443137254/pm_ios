//
//  PersonalSettingViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/23.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "PersonalSettingViewController.h"
#import "common.h"

@interface PersonalSettingViewController () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
}

@end

@implementation PersonalSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    if ([common isPad]) {
        
    } else if ([common isPhone]){
        [self setNavigation];
        [self setMainView];
    }
}

- (void)setNavigation{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"设置";
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setMainView{
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    img.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:img];
    
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.bounces = NO;
    }
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*ProportionX;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    UILabel *lblContent = [[UILabel alloc] initWithFrame:CGRectMake(100*ProportionX, 0, self.view.frame.size.width - 100*ProportionX - 40*ProportionX, 45*ProportionX)];
    lblContent.textAlignment = NSTextAlignmentRight;
    lblContent.textColor = [UIColor colorWithRed:89/255.0 green:180/255.0 blue:221/255.0 alpha:1];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine];
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*ProportionX, self.view.frame.size.width, 1)];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"点击确定清除缓存" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.view makeToast:@"Success"];
        }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:actionSure];
        [alert addAction:actionCancel];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
