
//
//  EditElectricityPriceViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/24.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "EditElectricityPriceViewController.h"
#import "common.h"
#import "Personal.h"

@interface EditElectricityPriceViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
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

@implementation EditElectricityPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadDataWithModel:(ElectrictyModel *)model{
    
    self.model = model;
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
        [backImageView setImage:[UIImage imageNamed:@"bg"]];
        tableView.backgroundView= backImageView;
    }
    [self.view addSubview:tableView];
    
    textName.text = model.name;
    textPrice.text = model.price;
    textStart.text = model.timeStart;
    textStop.text = model.timeStop;
    textEffect.text = model.IsEffect;

    [tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
    
    NSString *account = [[NSUserDefaults standardUserDefaults] stringForKey:TOKEN];
    
    [Personal getElePriceInfo:@{@"account":account,@"id":@"14"} Success:^(id data) {
        NSLog(@"data = %@",data);
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
        textName.placeholder = @"请输入电价名称";
        textName.text = self.model.name;
        [cell addSubview:textName];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"单价";
        textPrice = [[UITextField alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        textPrice.textColor = [UIColor whiteColor];
        textPrice.placeholder = @"请输入单价";
        textPrice.text = self.model.price;
        [cell addSubview:textPrice];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"起始时间";
        
        textStart = [[UITextField alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        textStart.textColor = [UIColor whiteColor];
        textStart.placeholder = @"";
        textStart.delegate = self;
        [cell addSubview:textStart];
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"有效时间";

        textStop = [[UITextField alloc] initWithFrame:CGRectMake(117*ProportionX, 0, self.view.frame.size.width - 117*ProportionX, 45*ProportionX)];
        textStop.textColor = [UIColor whiteColor];
        textStop.placeholder = @"";
        textStop.delegate = self;
        [cell addSubview:textStop];
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"是否生效";

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    return view;
}

- (void)btnSaveClickAction{
    [self textResign];
    
    
    
    
    [Personal getAddElePrice:@{@"uniqueId":@"DYSWMXJ",@"name":@"peak",@"time":@"[]",@"price":@0.865,@"effectiveTime":@"20201231"} Success:^(id data) {
        NSLog(@"data = %@",data);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
//    [self.navigationController popViewControllerAnimated:YES];
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
