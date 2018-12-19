//
//  ElectricityPriceAllocationViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/16.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "ElectricityPriceAllocationViewController.h"
#import "common.h"
#import "ElectricityPriceAllocationCell.h"
#import "AddElectricityPriceAllocationViewController.h"
#import "EditElectricityPriceViewController.h"
#import "Personal.h"
#import "ElectrictyModel.h"

@interface ElectricityPriceAllocationViewController ()  <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    UIButton *btnAdd;
    AddElectricityPriceAllocationViewController *AEPAVC;
    EditElectricityPriceViewController *EEPAVC;
    NSArray *arr;
}


@end

@implementation ElectricityPriceAllocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [backImageView setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:backImageView];
    [self setNavigationBar];
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:tableView];
    [self getData];
}

- (void)getData{
//    self.model = [[ElectrictyModel alloc] init];
    
//    NSString *uniqueId = [[NSUserDefaults standardUserDefaults] stringForKey:@"UNIQUEID"];
    
    [Personal getElePrice:@{@"uniqueId":@"DYSWMXJ"} Success:^(id data) {
        self->arr = data[@"data"];
        NSLog(@"count = %ld",arr.count);
        [tableView reloadData];
    }];
    
}

- (void)setNavigationBar{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"电价配置";
    
    if (!btnAdd) {
        btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnAdd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [btnAdd addTarget:self action:@selector(btnAddClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    self.navigationItem.rightBarButtonItem = btnR;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (![[NSUserDefaults standardUserDefaults] stringForKey:TOKEN]) {
        return 0;
    } else {
        return arr.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170*ProportionX;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (int i = 0; i<arr.count; i++) {
        if (i == indexPath.section) {
            NSDictionary *dic = [arr objectAtIndex:i];
            ElectricityPriceAllocationCell *EPACell = [[ElectricityPriceAllocationCell alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20*ProportionX, 170*ProportionX)];
            if (![dic objectForKey:@"name"]) {
                EPACell.title.text = @"无数据";
            } else {
                EPACell.title.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            }
            if (![dic objectForKey:@"price"]) {
                EPACell.price.text = @"无数据";
            } else {
                EPACell.price.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
            }
            
            if (![dic objectForKey:@"timeStart"]) {
                EPACell.timeStart.text = @"无数据";
            } else {
                EPACell.timeStart.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timeStart"]];
            }
            
            if (![dic objectForKey:@"timeStop"]) {
                EPACell.timeStop.text = @"无数据";
            } else {
                EPACell.timeStop.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timeStop"]];
            }
            
            if (![dic objectForKey:@"iseffect"]) {
                EPACell.IsEffect.text = @"无数据";
            } else {
                EPACell.IsEffect.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isEffext"]];
            }
            
            [cell addSubview:EPACell];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    headView.backgroundColor = [UIColor clearColor];
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
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    } else {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.000001)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!EEPAVC) {
        EEPAVC = [[EditElectricityPriceViewController alloc] init];
    }
    self.model = [[ElectrictyModel alloc] init];
    NSDictionary *dic = [arr objectAtIndex:indexPath.section];
    
    if (![dic objectForKey:@"name"]) {
        self.model.name = @"无数据";
    } else {
        self.model.name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    }
    if (![dic objectForKey:@"price"]) {
        self.model.price = @"无数据";
    } else {
        self.model.price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
    }
    
    if (![dic objectForKey:@"timeStart"]) {
        self.model.timeStart = @"无数据";
    } else {
        self.model.timeStart = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timeStart"]];
    }
    
    if (![dic objectForKey:@"timeStop"]) {
        self.model.timeStop = @"无数据";
    } else {
        self.model.timeStop= [NSString stringWithFormat:@"%@",[dic objectForKey:@"timeStop"]];
    }
    
    if (![dic objectForKey:@"iseffect"]) {
        self.model.IsEffect = @"无数据";
    } else {
        self.model.IsEffect = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isEffext"]];
    }
    
    
    [EEPAVC loadDataWithModel:self.model];
    [self.navigationController pushViewController:EEPAVC animated:YES];
    [EEPAVC loadDataWithModel:self.model];
}

- (void)btnAddClickAction{
    if (!AEPAVC) {
        AEPAVC = [[AddElectricityPriceAllocationViewController alloc] init];
    }
    [self.navigationController pushViewController:AEPAVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
