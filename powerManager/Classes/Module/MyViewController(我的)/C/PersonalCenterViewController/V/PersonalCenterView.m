//
//  PersonalCenterView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/5.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "PersonalCenterView.h"
#import "PersonalCenterModel.h"
#import "EditSingelViewController.h"
#import "EditThreeDetailViewController.h"
#import "common.h"

@interface PersonalCenterView () <UITableViewDelegate,UITableViewDataSource> {
    PersonalCenterModel *model;
    EditSingelViewController *ESVC;
    EditThreeDetailViewController *ETVC;
    UIButton *btnIcon;
}
@end

@implementation PersonalCenterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
        [self getData];
    }
    return self;
}

- (void)loadView{
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.bounces = NO;
        self.tableView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self getData];
    }
    [self addSubview:self.tableView];
}

- (void)getData{
    if (!model) {
        model = [[PersonalCenterModel alloc] init];
    }
    model.username = @"Lancelot";
    model.nickname = @"Lancelot";
    model.company = @"吉瑞瓦特";
    model.accountType = @"系统管理员";
    model.registeredDate = @"2018-07-13 17:33:20";
    model.changePassword = @"深圳";
    model.telephone = @"15985148650";
    model.email = @"moonhoping@qq.com";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    } else {
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    UILabel *lblcontent = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, self.frame.size.width - 119, 45)];
    lblcontent.font = [UIFont systemFontOfSize:18];
    lblcontent.textColor = [UIColor whiteColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60/2.0, 0, self.frame.size.width - 119, 45)];
    lblTitle.font = [UIFont systemFontOfSize:18];
    lblTitle.textColor = [UIColor whiteColor];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine];
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 1)];
    lblLine0.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine0];
    [cell addSubview:lblTitle];
    [cell addSubview:lblcontent];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            lblTitle.text = @"用户名";
            lblcontent.text = model.username;
        } else if (indexPath.row == 1) {
            lblTitle.text = @"昵称";
            lblcontent.text = model.nickname;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 2) {
            lblTitle.text = @"角色类别";
            lblcontent.text = model.accountType;
        } else if (indexPath.row == 3) {
            lblTitle.text = @"所属公司";
            lblcontent.text = model.company;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 4) {
            lblTitle.text = @"注册日期";
            lblcontent.text = model.registeredDate;
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            lblTitle.text = @"修改密码";
        } else if (indexPath.row == 1) {
            lblTitle.text = @"安全手机";
            lblcontent.text = model.telephone;
        } else if (indexPath.row == 2) {
            lblTitle.text = @"安全邮箱";
            lblcontent.text = model.email;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 220;
    } else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(22, 20, self.frame.size.width - 25, 15)];
    lblTitle.font = [UIFont systemFontOfSize:18];
    lblTitle.textColor = [UIColor colorWithRed:105/255.0 green:210/255.0 blue:253/255.0 alpha:1];
    if (section == 0) {
        viewHead.frame = CGRectMake(0, 0, self.frame.size.width, 220);
        
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewHead.frame.size.width, 60)];
        lblT.textAlignment = NSTextAlignmentCenter;
        lblT.textColor = RGB_HEX(0xffffff, 1);
        lblT.text = @"个人资料";
        lblT.font = [UIFont systemFontOfSize:26];
        [viewHead addSubview:lblT];
        
        lblTitle.frame = CGRectMake(30, viewHead.frame.size.height - 20, viewHead.frame.size.height - 25, 15);
        lblTitle.text = @"基本信息";
        
        btnIcon = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 50)/2.0, 158/2.0, 50, 50)];
        [btnIcon setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
        btnIcon.center = CGPointMake(self.frame.size.width/2.0, 158/2.0+btnIcon.frame.size.height/2.0);
        
        [viewHead addSubview:btnIcon];
        
        UIButton *lblIcon = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 100)/2.0, btnIcon.frame.origin.y + btnIcon.frame.size.height, 100, 20)];
        [lblIcon setTitle:@"点击更换头像" forState:UIControlStateNormal];
        [lblIcon setTitleColor:[UIColor colorWithRed:88/255.0 green:180/255.0 blue:223/255.0 alpha:1] forState:UIControlStateNormal];
        lblIcon.titleLabel.font = [UIFont systemFontOfSize:12];
        [viewHead addSubview:lblIcon];
        
    } else {
        lblTitle.frame = CGRectMake(30, 20, self.frame.size.width - 25, 15);
        lblTitle.text = @"账号安全";
    }
    
    [viewHead addSubview:lblTitle];
    return viewHead;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
                [self.customDelegate btnClickWithTag:@"nickname"];
            }
        } else if (indexPath.row == 3) {
            if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
                [self.customDelegate btnClickWithTag:@"company"];
            }
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
                [self.customDelegate btnClickWithTag:@"password"];
            }
        } else if (indexPath.row == 1) {
            if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
                [self.customDelegate btnClickWithTag:@"phone"];
            }
        } else if (indexPath.row == 2) {
            if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
                [self.customDelegate btnClickWithTag:@"email"];
            }
        }
    }
}



@end
