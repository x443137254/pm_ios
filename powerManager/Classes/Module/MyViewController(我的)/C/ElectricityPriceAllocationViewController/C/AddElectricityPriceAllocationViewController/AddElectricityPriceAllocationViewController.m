//
//  AddElectricityPriceAllocationViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/24.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "AddElectricityPriceAllocationViewController.h"
#import "common.h"
#import "Personal.h"

@interface AddElectricityPriceAllocationViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
    UITableView *tableView;
    UIButton *btnSave;
    UITextField *textName;
    UITextField *textPrice;
    UITextField *textStart;
    UITextField *textStop;
    UITextField *textEffect;
    
}

@property (nonatomic, strong) ElectrictyModel *model;

@end

@implementation AddElectricityPriceAllocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
        [backImageView setImage:[UIImage imageNamed:@"bg"]];
        tableView.backgroundView= backImageView;
        [self.view addSubview:tableView];
    }
}


- (void)setNavigationBar{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"新增电价";
    if (!btnSave) {
        btnSave = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnSave setTitle:@"保存" forState:UIControlStateNormal];
        [btnSave addTarget:self action:@selector(btnSaveClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    self.navigationItem.rightBarButtonItem = btnR;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*ProportionX;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"cell";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = FontL;
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    if (indexPath.row >= 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"电价名称";
        textName = [[UITextField alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        textName.textColor = [UIColor whiteColor];
        textName.text = @"请输入电价名称";
        textName.delegate = self;
        [cell addSubview:textName];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"单价";
        textPrice = [[UITextField alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        textPrice.textColor = [UIColor whiteColor];
        textPrice.placeholder = @"请输入单价";
        textPrice.delegate = self;
        [cell addSubview:textPrice];
        
        UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 0, 70, 45*ProportionX)];
        lblPrice.textColor = ColorCustom;
        lblPrice.textAlignment = NSTextAlignmentRight;
        lblPrice.text = @"元/kWh";
        [cell addSubview:lblPrice];
        
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"起始时间";
        UILabel *lblTimeStart = [[UILabel alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        lblTimeStart.textColor = [UIColor whiteColor];
        lblTimeStart.text = self.model.timeStart;
        [cell addSubview:lblTimeStart];
        
        textStart = [[UITextField alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        textStart.textColor = [UIColor whiteColor];
        textStart.placeholder = @"";
        textStart.delegate = self;
        [cell addSubview:textStart];
        
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"有效时间";
        UILabel *lbltimeStop = [[UILabel alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        lbltimeStop.textColor = [UIColor whiteColor];
        lbltimeStop.text = self.model.timeStop;
        [cell addSubview:lbltimeStop];
        
        textStop = [[UITextField alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        textStop.textColor = [UIColor whiteColor];
        textStop.placeholder = @"";
        textStop.delegate = self;
        [cell addSubview:textStop];
        
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"是否生效";
        UILabel *lblIsEffect = [[UILabel alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        lblIsEffect.textColor = [UIColor whiteColor];
        lblIsEffect.text = self.model.IsEffect;
        [cell addSubview:lblIsEffect];
        
        textEffect = [[UITextField alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        textEffect.textColor = [UIColor whiteColor];
        textEffect.placeholder = @"是";
        textEffect.delegate = self;
        [cell addSubview:textEffect];
    }
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*ProportionX, self.view.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:10/255.0 green:73/255.0 blue:92/255.0 alpha:1];
    lblLine0.backgroundColor = [UIColor colorWithRed:10/255.0 green:73/255.0 blue:92/255.0 alpha:1];
    [cell addSubview:lblLine];
    [cell addSubview:lblLine0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        
    }
}

- (void)btnSaveClickAction{
    //    @{@"":@""}
    NSMutableDictionary *dic0 = [[NSMutableDictionary alloc] init];
    [dic0 setValue:@"start" forKey:@"19:03"];
    [dic0 setValue:@"stop" forKey:@"20:30"];
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *jsonArray = [ArrToJSON arrToJSONWithArray:array];
    
    [Personal getAddElePrice:@{@"uniqueId":@"DYSWMXJ",@"name":@"peak",@"time":@"[]",@"price":@0.865,@"effectiveTime":@"20201231"} Success:^(id data) {
        NSLog(@"data = %@",data);
    }];
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textResign{
    [textName resignFirstResponder];
    [textPrice resignFirstResponder];
    [textStart resignFirstResponder];
    [textStop resignFirstResponder];
    [textEffect resignFirstResponder];
//    texts
}

@end
