//
//  PowerStationInformationMaintenanceViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/16.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "PowerStationInformationMaintenanceViewController.h"
#import "common.h"
#import "PowerStationInformationModel.h"
#import "EditSingelViewController.h"
#import "TLHeader.h"

@interface PowerStationInformationMaintenanceViewController ()  <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    UITableView *tableView;
    UIButton *btnSave;
    PowerStationInformationModel *model;
    EditSingelViewController *ESVC;
}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@end

@implementation PowerStationInformationMaintenanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
    [self getData];
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [backImageView setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:backImageView];
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:tableView];
}

- (void)getData{
    if (!model) {
        model = [[PowerStationInformationModel alloc] init];
    }
    model.name = @"石岩10KW";
    model.date = @"2018-08-15";
    model.company = @"吉瑞瓦特";
    model.power = @"10000W";
    model.country = @"中国";
    model.city = @"深圳";
    model.timeZone = @"GMT+8";
    model.LAL = @"北纬N00 ， 东京E00";
    model.subsidy = @"￥1.10";
}

- (void)setNavigationBar{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"电站维护信息";
    if (!btnSave) {
        btnSave = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnSave setTitle:@"保存" forState:UIControlStateNormal];
        [btnSave addTarget:self action:@selector(btnSaveClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    self.navigationItem.rightBarButtonItem = btnR;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 4;
    } else {
        return 1;
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
    [cell addSubview:lblcontent];
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine];
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*ProportionX, self.view.frame.size.width, 1)];
    lblLine0.backgroundColor = [UIColor colorWithRed:6/255.0 green:71/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine0];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"电站名称";
            lblcontent.text = model.name;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"安装日期";
            lblcontent.text = model.date;
            UIButton *btnDate = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40*ProportionX, 7.5*ProportionX, 30*ProportionX, 30*ProportionX)];
            [btnDate setImage:[UIImage imageNamed:@"选择日期"] forState:UIControlStateNormal];
            [btnDate setImage:[UIImage imageNamed:@"选择日期_click"] forState:UIControlStateHighlighted];
            btnDate.userInteractionEnabled = NO;
            [cell addSubview:btnDate];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"设计厂商";
            lblcontent.text = model.company;
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"设计功率";
            lblcontent.text = model.power;
        }
    } else if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"国家";
            lblcontent.text = model.country;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"城市";
            lblcontent.text = model.city;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"时区";
            lblcontent.text = model.timeZone;
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"经纬度";
            lblcontent.text = model.LAL;
        }
    } else {
        cell.textLabel.text = @"补贴单价";
        lblcontent.text = model.subsidy;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(22*ProportionX, 20, self.view.frame.size.width - 25*ProportionX, 15)];
    lblTitle.font = FontS;
    lblTitle.textColor = [UIColor colorWithRed:105/255.0 green:210/255.0 blue:253/255.0 alpha:1];
    
    if (section == 0) {
        lblTitle.text = @"安装信息";
    } else if (section == 1) {
        lblTitle.text = @"地理信息";
    } else {
        lblTitle.text = @"资金收益";
    }
    
    [viewHead addSubview:lblTitle];
    return viewHead;
}

- (void)btnSaveClickAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (!ESVC) {
                ESVC = [[EditSingelViewController alloc] init];
            }
            [self.navigationController pushViewController:ESVC animated:YES];
        } else if (indexPath.row == 1) {
            __weak typeof(self) weakSelf = self;
            [BRDatePickerView showDatePickerWithTitle:@"安装日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
                weakSelf.birthdayTF.text = selectValue;
                model.date = selectValue;
                [tableView reloadData];
            }];
        } if (indexPath.row == 2) {
            if (!ESVC) {
                ESVC = [[EditSingelViewController alloc] init];
            }
            [self.navigationController pushViewController:ESVC animated:YES];
        } if (indexPath.row == 3) {
            if (!ESVC) {
                ESVC = [[EditSingelViewController alloc] init];
            }
            [self.navigationController pushViewController:ESVC animated:YES];
        }
    }
}

- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 230, 0, 200, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = RGB_HEX(0x666666, 1.0);
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
