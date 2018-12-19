//
//  PersonalCenterViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/24.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "common.h"
#import "PersonalCenterModel.h"
#import "LoginViewController.h"
#import "EditSingelViewController.h"
#import "EditThreeDetailViewController.h"
#import "PersonalCenterView.h"
#import "UserLogin.h"
#import "UserLoginInfo.h"

@interface PersonalCenterViewController () <UITableViewDelegate,UITableViewDataSource> {
    UIButton *btnSave;
    PersonalCenterModel *model;
    LoginViewController *LVC;
    EditSingelViewController *ESVC;
    EditThreeDetailViewController *ETVC;
    PersonalCenterView *PCV;
}

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    if ([common isPhone]) {
        [self setNavigationBar];
        [self getData];
        if (!self.tableView) {
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            self.tableView.bounces = NO;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
            [backImageView setImage:[UIImage imageNamed:@"bg"]];
            self.tableView.backgroundView= backImageView;
        }
        [self.view addSubview:self.tableView];
    } else {
//        [self.view addSubview:[[PersonalCenterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]];
    }
    
    [self.tableView reloadData];
}

- (void)getData{
    if (!model) {
        model = [[PersonalCenterModel alloc] init];
    }
    
    if (![[NSUserDefaults standardUserDefaults] stringForKey:TOKEN]){
        model.username = @"(尚未登录账号)";
        model.nickname = @"";
        model.company = @"";
        model.accountType = @"";
        model.registeredDate = @"";
        model.changePassword = @"";
        model.telephone = @"";
        model.email = @"";
        NSLog(@"123");
    } else {
    
        if ([[NSUserDefaults standardUserDefaults] stringForKey:TOKEN].length > 0) {
            NSString *account = [[NSUserDefaults standardUserDefaults] stringForKey:TOKEN];
            NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
            NSLog(@"account = %@ password = %@",account,password);
            [UserLogin getLogin:@{@"account":account,@"password":password} Success:^(id data) {
//            NSLog(@"data = %@",data);
                NSString *strCode = [NSString stringWithFormat:@"%@",data[@"code"]];
                if ([strCode isEqualToString:@"0"]) {
//
                    UserLoginInfo *user = [UserLoginInfo yy_modelWithJSON:data[@"data"]];
                    
                    
    //                //// 将 Model 转换为 JSON 对象:
                    NSDictionary *dic = [user yy_modelToJSONObject];
    //                //                NSLog(@"dic = %@",dic);
                    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"account"] forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"cid"] forKey:@"cid"];
                    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"uniqueId"] forKey:@"uniqueId"];
                    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"password"] forKey:@"password"];
                    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"companyName"] forKey:@"companyName"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
    //
                    self -> model.username = user.account;
                    self -> model.nickname = user.account;
                    self -> model.company = user.companyName;
                    self -> model.accountType = @"";
                    self -> model.registeredDate = [Time getDateStringWithTimeStr:user.registTime];
                    self -> model.changePassword = @"";
                    self -> model.telephone = user.phone;
                    self -> model.email = user.email;
                    [self.tableView reloadData];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LEFTVIEWUPDATA" object:nil];
                }
            }];
        }
    }
}

- (void)setNavigationBar{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"个人资料";
    if (!btnSave) {
        btnSave = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnSave setTitle:@"退出" forState:UIControlStateNormal];
        [btnSave addTarget:self action:@selector(btnExitClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    self.navigationItem.rightBarButtonItem = btnR;
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
    return 45*ProportionX;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"cell";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = FontL;
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    UILabel *lblcontent = [[UILabel alloc] initWithFrame:CGRectMake(119*ProportionX, 0, self.view.frame.size.width - 119*ProportionX, 45*ProportionX)];
    lblcontent.font = FontM;
    lblcontent.textColor = [UIColor whiteColor];
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine];
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*ProportionX, self.view.frame.size.width, 1)];
    lblLine0.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine0];
    [cell addSubview:lblcontent];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"用户名";
            lblcontent.text = model.username;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"昵称";
            lblcontent.text = model.nickname;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"角色类别";
            lblcontent.text = model.accountType;
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"所属公司";
            lblcontent.text = model.company;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"注册日期";
            lblcontent.text = model.registeredDate;
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"修改密码";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"安全手机";
            lblcontent.text = model.telephone;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"安全邮箱";
            lblcontent.text = model.email;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 110*ProportionX;
    } else {
        return 40*ProportionX;
    } 
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(22*ProportionX, 20*ProportionX, self.view.frame.size.width - 25*ProportionX, 15*ProportionX)];
    lblTitle.font = FontS;
    lblTitle.textColor = [UIColor colorWithRed:105/255.0 green:210/255.0 blue:253/255.0 alpha:1];
    if (section == 0) {
        lblTitle.frame = CGRectMake(22*ProportionX, 90*ProportionX, self.view.frame.size.width - 25*ProportionX, 15*ProportionX);
        lblTitle.text = @"基本信息";
        
        UIButton *btnicon = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 50*ProportionX)/2.0, 4*ProportionX, 50*ProportionX, 50*ProportionX)];
        btnicon.layer.masksToBounds = YES;
        [btnicon setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
        [viewHead addSubview:btnicon];
        UIButton *lblIcon = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100*ProportionX)/2.0, 54*ProportionX, 100*ProportionX, 20*ProportionX)];
        [lblIcon setTitle:@"点击更换头像" forState:UIControlStateNormal];
        [lblIcon setTitleColor:[UIColor colorWithRed:88/255.0 green:180/255.0 blue:223/255.0 alpha:1] forState:UIControlStateNormal];
        lblIcon.titleLabel.font = [UIFont systemFontOfSize:12*ProportionX];
        [viewHead addSubview:lblIcon];
        
    } else {
        lblTitle.frame = CGRectMake(22*ProportionX, 20*ProportionX, self.view.frame.size.width - 25*ProportionX, 15*ProportionX);
        lblTitle.text = @"账号安全";
    }
    
    [viewHead addSubview:lblTitle];
    return viewHead;
}

- (void)btnExitClickAction{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"cid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"uniqueId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"companyName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LEFTVIEWUPDATA" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    if (!LVC) {
        LVC = [[LoginViewController alloc] init];
    }
    [self.navigationController pushViewController:LVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            ESVC = [[EditSingelViewController alloc] init];
            ESVC.lblTitle = @"昵称";
            [self.navigationController pushViewController:ESVC animated:YES];
        } else if (indexPath.row == 3) {
            ESVC = [[EditSingelViewController alloc] init];
            ESVC.lblTitle = @"所属公司";
            [self.navigationController pushViewController:ESVC animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ETVC = [[EditThreeDetailViewController alloc] init];
            ETVC.lblTitle = @"修改密码";
            [self.navigationController pushViewController:ETVC animated:YES];
        } else if (indexPath.row == 1) {
            ETVC = [[EditThreeDetailViewController alloc] init];
            ETVC.lblTitle = @"修改手机号";
            [self.navigationController pushViewController:ETVC animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
