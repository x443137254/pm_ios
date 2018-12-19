//
//  InterverDetailViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/17.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "InterverDetailViewController.h"
#import "common.h"

#import "AlertDetailViewController.h"
#import "TLHeader.h"

@interface InterverDetailViewController () <UITableViewDelegate,UITableViewDataSource> {
    AlertDetailViewController *IADVC;
    UIButton *btnDay;
    UIButton *btnMonth;
    UIButton *btnYear;
    UIButton *btnTotol;
    UITableView *tableView;
    
    UIButton *btnTime;

}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@end

@implementation InterverDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self setNavigationBar];
    [self getDta];
    [self setInverterDetailView];
}

- (void)getDta{
    
}


- (void)setNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"A栋大楼逆变器";
}

- (void)setInverterDetailView{
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
        [backImageView setImage:[UIImage imageNamed:@"bg"]];
        [self.view addSubview:backImageView];
    }
    [self.view addSubview:tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180*ProportionX;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 45*ProportionX;
        } else if (indexPath.row == 1) {
            return 45*ProportionX;
        } else {
            return 45*ProportionX;
        }
    } else {
        return 260*ProportionX;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor clearColor];
    } else if (indexPath.section == 1){
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
        } else {
             cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        }
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        lblT.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [cell addSubview:lblT];
        
        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*ProportionX, self.view.frame.size.width, 1)];
        lblB.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [cell addSubview:lblB];
    } else {
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        lblT.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [cell addSubview:lblT];
        cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    }
    
    if (indexPath.section == 0) {
        
        UILabel *lblStatus = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 90*ProportionX)/2.0, 25*ProportionX, 90*ProportionX, 20*ProportionX)];
        lblStatus.textColor = [UIColor redColor];
        lblStatus.textAlignment = NSTextAlignmentCenter;
        lblStatus.text = @"故障";
        [cell addSubview:lblStatus];
        
        UILabel *lblStatus0 = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 90*ProportionX)/2.0, 45*ProportionX, 90*ProportionX, 20*ProportionX)];
        lblStatus0.textColor = [UIColor colorWithRed:81/255.0 green:182/255.0 blue:230/255.0 alpha:1];
        lblStatus0.textAlignment = NSTextAlignmentCenter;
        lblStatus0.text = @"运行状态";
        lblStatus0.font = Font12;
        [cell addSubview:lblStatus0];
        
        UIButton *btnAlert = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 90*ProportionX)/2.0, 0, 90*ProportionX, 90*ProportionX)];
        [btnAlert setBackgroundImage:[UIImage imageNamed:@"运行状态_error"] forState:UIControlStateNormal];
        [btnAlert addTarget:self action:@selector(btnAlertClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnAlert];
        
        UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 3.0 - 40*ProportionX)/2.0 , 100*ProportionX, 40*ProportionX, 40*ProportionX)];
        img0.image = [UIImage imageNamed:@"统计_装机功率"];
        [cell addSubview:img0];
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 3.0 - 40*ProportionX)/2.0 + self.view.frame.size.width / 3.0, 100*ProportionX, 40*ProportionX, 40*ProportionX)];
        img1.image = [UIImage imageNamed:@"当日发电"];
        [cell addSubview:img1];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 3.0 - 40*ProportionX)/2.0 + self.view.frame.size.width / 3.0 *2, 100*ProportionX, 40*ProportionX, 40*ProportionX)];
        img2.image = [UIImage imageNamed:@"统计_总发电"];
        [cell addSubview:img2];
        
        UILabel *lblD0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 140*ProportionX, self.view.frame.size.width / 3.0, 20*ProportionX)];
        lblD0.textColor = [UIColor whiteColor];
        lblD0.textAlignment = NSTextAlignmentCenter;
        lblD0.text = @"50000w";
        [cell addSubview:lblD0];
        
        UILabel *lblD1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3.0 * 1, 140*ProportionX, self.view.frame.size.width / 3.0, 20*ProportionX)];
        lblD1.textColor = [UIColor whiteColor];
        lblD1.textAlignment = NSTextAlignmentCenter;
        lblD1.text = @"26kWh";
        [cell addSubview:lblD1];
        
        UILabel *lblD2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3.0 * 2, 140*ProportionX, self.view.frame.size.width / 3.0, 20*ProportionX)];
        lblD2.textColor = [UIColor whiteColor];
        lblD2.textAlignment = NSTextAlignmentCenter;
        lblD2.text = @"2600kWhw";
        [cell addSubview:lblD2];
        
        UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 160*ProportionX, self.view.frame.size.width / 3.0, 20*ProportionX)];
        lbl0.textColor = [UIColor colorWithRed:72/255.0 green:167/255.0 blue:211/255.0 alpha:1];
        lbl0.textAlignment = NSTextAlignmentCenter;
        lbl0.text = @"功率";
        [cell addSubview:lbl0];
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3.0, 160*ProportionX, self.view.frame.size.width / 3.0, 20*ProportionX)];
        lbl1.textColor = [UIColor colorWithRed:72/255.0 green:167/255.0 blue:211/255.0 alpha:1];
        lbl1.textAlignment = NSTextAlignmentCenter;
        lbl1.text = @"当日发电";
        [cell addSubview:lbl1];
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3.0 *2, 160*ProportionX, self.view.frame.size.width / 3.0, 20*ProportionX)];
        lbl2.textColor = [UIColor colorWithRed:72/255.0 green:167/255.0 blue:211/255.0 alpha:1];
        lbl2.textAlignment = NSTextAlignmentCenter;
        lbl2.text = @"总发电";
        [cell addSubview:lbl2];
        
        
    } else if (indexPath.section == 1) {
        cell.textLabel.textColor = [UIColor whiteColor];
        UILabel *lblC = [[UILabel alloc] initWithFrame:CGRectMake(100*ProportionX, 7.5*ProportionX, self.view.frame.size.width - 20*ProportionX - 100*ProportionX, 30*ProportionX)];
        lblC.textColor = [UIColor whiteColor];
        lblC.textAlignment = NSTextAlignmentRight;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"位置";
            lblC.text = @"石岩A栋大厦";
        } else if (indexPath.row == 0) {
            cell.textLabel.text = @"采集器";
            lblC.text = @"4565FAJOA791";
        } else {
            cell.textLabel.text = @"安装时间";
            lblC.text = @"2018-08-15";
        }
        [cell addSubview:lblC];
    } else {
        UIButton *btnPV = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100*ProportionX)/2.0, 0, 100*ProportionX, 50*ProportionX)];
        [btnPV setTitle:@"PV功率" forState:UIControlStateNormal];
        [btnPV setImage:[UIImage imageNamed:@"swicth"] forState:UIControlStateNormal];
        [btnPV setTitleEdgeInsets:UIEdgeInsetsMake(0, -btnPV.imageView.frame.size.width, 0, btnPV.imageView.frame.size.width)];
        [btnPV setImageEdgeInsets:UIEdgeInsetsMake(0, btnPV.titleLabel.bounds.size.width, 0, -btnPV.titleLabel.bounds.size.width)];
        [cell addSubview:btnPV];
        
        btnDay = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX, 50*ProportionX, 100*ProportionX, 22*ProportionX)];
        btnDay.layer.borderWidth = 1;
        btnDay.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnDay.layer.masksToBounds = YES;
        btnDay.layer.cornerRadius = 11*ProportionX;
        btnDay.titleLabel.font = Font12;
        [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [btnDay setTitle:@"日" forState:UIControlStateNormal];
        btnDay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnDay.titleEdgeInsets = UIEdgeInsetsMake(0, 20*ProportionX, 0, 0);
        [btnDay addTarget:self action:@selector(btnDayClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnDay];
        
        btnYear = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX + 50*ProportionX, 50*ProportionX, 100*ProportionX, 22*ProportionX)];
        btnYear.layer.borderWidth = 1;
        btnYear.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnYear.layer.masksToBounds = YES;
        btnYear.layer.cornerRadius = 11*ProportionX;
        btnYear.titleLabel.font = Font12;
        [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [btnYear setTitle:@"年" forState:UIControlStateNormal];
        btnYear.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btnYear.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20*ProportionX);
        [btnYear addTarget:self action:@selector(btnYearClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnYear];
        
        btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX +50*ProportionX, 50*ProportionX, 50*ProportionX, 22*ProportionX)];
        btnMonth.layer.borderWidth = 1;
        [btnMonth setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
        btnMonth.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnMonth.layer.masksToBounds = YES;
        btnMonth.titleLabel.font = Font12;
        [btnMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnMonth setTitle:@"月" forState:UIControlStateNormal];
        [btnMonth addTarget:self action:@selector(btnMonthClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnMonth];
        
        btnTime = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 20*ProportionX - 90*ProportionX, 50*ProportionX, 90*ProportionX, 22*ProportionX)];
        btnTime.layer.masksToBounds = YES;
        btnTime.layer.masksToBounds = YES;
        btnTime.layer.cornerRadius = 11*ProportionX;
        btnTime.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnTime.layer.borderWidth = 1;
        [btnTime setTitle:@"2018-08-02" forState:UIControlStateNormal];
        btnTime.titleLabel.font = Font12;
        [btnTime addTarget:self action:@selector(btnTimeClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnTime];
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10*ProportionX;
    } else if (section == 1) {
        return 10*ProportionX;
    } else {
        return 0.0000001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10*ProportionX)];
    } else if (section == 0) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10*ProportionX)];
    } else {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000001)];
    }
}

- (void)btnAlertClickAction{
    if (!IADVC) {
        IADVC = [[AlertDetailViewController alloc] init];
    }
    [self.navigationController pushViewController:IADVC animated:YES];
}

- (void)btnDayClickAction{
    [btnDay setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnMonth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnYear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnTotol setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)btnMonthClickAction{
    [btnDay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMonth setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnYear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnTotol setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)btnYearClickAction{
    [btnDay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMonth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnYear setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnTotol setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)btnTotolClickAction{
    [btnDay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMonth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnYear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnTotol setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

- (void)btnTimeClickAction{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        
        [btnTime setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
        CGSize size = [btnTime.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FontM,NSFontAttributeName,nil]];
        btnTime.frame = CGRectMake(self.view.frame.size.width - 10 - 6*ProportionX - size.width - 20*ProportionX, 44*ProportionX, size.width + 20*ProportionX, 22*ProportionX);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
