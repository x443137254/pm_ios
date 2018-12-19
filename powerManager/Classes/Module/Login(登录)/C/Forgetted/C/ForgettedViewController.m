//
//  ForgettedViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/22.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "ForgettedViewController.h"
#import "common.h"
#import "DNTableViewCell.h"
#import "UserLogin.h"
#import "ForgettedViewPad.h"

@interface ForgettedViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    UIButton *btnType0;
    UIButton *btnType1;
    UILabel *lblType;
    
    UIView *phoneView;
    UIView *emailView;
    
    UITextField *textPhone;
    UITextField *textPhoneCode;
    UITextField *textPasswordNew0;
    UITextField *textPasswordAgain0;
    UIButton *btnCode0;
    
    UITextField *textEmail;
    UITextField *textEmailCode;
    UITextField *textPasswordNew1;
    UITextField *textPasswordAgain1;
    UIButton *btnCode1;
    
    UITableView *tableView;
    
    UITextField *text00;
    UITextField *text01;
    UITextField *text02;
    UITextField *text03;

    NSString *code;
    
    int t;
    NSTimer *timer;
}

@property (nonatomic, strong) ForgettedViewPad *FVP;

@end

@implementation ForgettedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    code = @"";
    if ([common isPhone]) {
        [self setNavigation];
        [self setMainView];
    } else if ([common isPad]) {
        self.view.backgroundColor = RGB_HEX(0x042a38, 1);
        [self setNavigationPad];
        [self setMainViewPad];
    }
}

- (void)setNavigation{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = FontTitle;
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"忘记密码";
}


- (void)setNavigationPad{
    UIColor *color = [UIColor whiteColor];
    UIFont *font = [UIFont systemFontOfSize:20];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:color forKey:NSForegroundColorAttributeName];
    [dict setObject:font forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.title = @"忘记密码";

    UIButton *btnRegistered = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 22)];
    [btnRegistered setTitle:@"登录" forState:UIControlStateNormal];
    btnRegistered.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnRegistered setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRegistered.layer.masksToBounds = YES;
    btnRegistered.layer.cornerRadius = 10;
    btnRegistered.layer.borderWidth = 1;
    btnRegistered.layer.borderColor = [[UIColor whiteColor] CGColor];
    [btnRegistered addTarget:self action:@selector(btnLoginClickAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithCustomView:btnRegistered];
    self.navigationItem.rightBarButtonItem = btnR;
}

- (void)setMainView{
    UIButton *btnBG = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [btnBG setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    [btnBG setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateHighlighted];
    [self.view addSubview:btnBG];

    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        tableView.bounces = NO;
        UIGestureRecognizer *ges = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(btnMClickAction)];
        [tableView addGestureRecognizer:ges];
    }
    [self.view addSubview:tableView];
}

- (void)setMainViewPad{
    if (!_FVP) {
        self.FVP = [[NSBundle mainBundle] loadNibNamed:@"ForgettedViewPad" owner:self options:nil].lastObject;
    }
    self.FVP.frame = CGRectMake(0, 0, 960/2.0, 700/2.0);
    self.FVP.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    [self.view addSubview:self.FVP];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   if (section == 0) {
        return 2;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45*ProportionX;
    } else {
        return 45*ProportionX;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (indexPath.section == 0) {
//
//        btnType0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2.0, 40*ProportionX)];
//        [btnType0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        btnType0.titleLabel.font = FontM;
//        [btnType0 setTitle:@"通过手机号找回" forState:UIControlStateNormal];
//        [btnType0 addTarget:self action:@selector(btnType0ClickAction) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:btnType0];
//
//        btnType1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0, 0, self.view.frame.size.width / 2.0, 40*ProportionX)];
//        [btnType1 setTitleColor:[UIColor colorWithRed:4/255.0 green:103/255.0 blue:123/255.0 alpha:1] forState:UIControlStateNormal];
//        btnType1.titleLabel.font = FontM;
//        [btnType1 setTitle:@"通过手机号找回" forState:UIControlStateNormal];
//        [btnType1 addTarget:self action:@selector(btnType1ClickAction) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:btnType1];
//
//        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*ProportionX, self.view.frame.size.width, 1)];
//        lblB.backgroundColor = [UIColor colorWithRed:53/255.0 green:78/255.0 blue:87/255.0 alpha:1];
//        [cell addSubview:lblB];
//
//        lblType = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/8.0, 40*ProportionX, self.view.frame.size.width/4.0, 1)];
//        lblType.backgroundColor = [UIColor whiteColor];
//        [cell addSubview:lblType];
//    } else {
        UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        lblT.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [cell addSubview:lblT];
        
        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*ProportionX, self.view.frame.size.width, 1)];
        lblB.backgroundColor = [UIColor colorWithRed:7/255.0 green:69/255.0 blue:90/255.0 alpha:1];
        [cell addSubview:lblB];
        
        UILabel *lblL0 = [[UILabel alloc] initWithFrame:CGRectMake(10*ProportionX, 0, 20*ProportionX, 45*ProportionX)];
        lblL0.textColor = [UIColor redColor];
        lblL0.textAlignment = NSTextAlignmentCenter;
        lblL0.text = @"*";
        lblL0.font = Font18;
        [cell addSubview:lblL0];
        
        UILabel *lblL1 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 0, 100*ProportionX, 45*ProportionX)];
        lblL1.textColor = [UIColor whiteColor];
        lblL1.font = Font18;
//    }

//    UILabel *lblL1 = [[UILabel alloc] initWithFrame:CGRectMake(30*ProportionX, 0, 100*ProportionX, 45*ProportionX)];
//    lblL1.textColor = [UIColor whiteColor];
//    lblL1.font = Font18;

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            lblL1.text = @"手机号";
            text00 = [[UITextField alloc] initWithFrame:CGRectMake(150*ProportionX, 0, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
            text00.textColor = [UIColor colorWithRed:95/255.0 green:174/255.0 blue:204/255.0 alpha:1];
            text00.textAlignment = NSTextAlignmentLeft;
            text00.text = @"请输入手机号";
            text00.delegate = self;
            [cell addSubview:text00];
        } else {
            lblL1.text = @"手机验证码";
            text01 = [[UITextField alloc] initWithFrame:CGRectMake(150*ProportionX, 0, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
            text01.textColor = [UIColor colorWithRed:95/255.0 green:174/255.0 blue:204/255.0 alpha:1];
            text01.textAlignment = NSTextAlignmentLeft;
            text01.text = @"请输入验证码";
            text01.delegate = self;
            [cell addSubview:text01];
            
            btnCode0 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 110*ProportionX, 10*ProportionX , 100*ProportionX, 25*ProportionX)];
            btnCode0.layer.masksToBounds = YES;
            btnCode0.layer.cornerRadius = 12.5*ProportionX;
            btnCode0.layer.borderWidth = 1;
            btnCode0.layer.borderColor = [[UIColor colorWithRed:29/255.0 green:124/255.0 blue:191/255.0 alpha:1] CGColor];
            [btnCode0 setTitleColor:[UIColor colorWithRed:29/255.0 green:124/255.0 blue:191/255.0 alpha:1] forState:UIControlStateNormal];
            [btnCode0 setTitle:@"获取验证码" forState:UIControlStateNormal];
            btnCode0.titleLabel.font = [UIFont systemFontOfSize:16*ProportionX];
            [btnCode0 addTarget:self action:@selector(btnCodeClickAction) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnCode0];
        }
    } else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            lblL1.text = @"新密码";
            text02 = [[UITextField alloc] initWithFrame:CGRectMake(150*ProportionX, 0, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
            text02.textColor = [UIColor colorWithRed:95/255.0 green:174/255.0 blue:204/255.0 alpha:1];
            text02.textAlignment = NSTextAlignmentLeft;
            text02.text = @"新密码";
            text02.delegate = self;
            [cell addSubview:text02];
        } else {
            lblL1.text = @"确认新密码";
            text03 = [[UITextField alloc] initWithFrame:CGRectMake(150*ProportionX, 0, self.view.frame.size.width - 130*ProportionX, 45*ProportionX)];
            text03.textColor = [UIColor colorWithRed:95/255.0 green:174/255.0 blue:204/255.0 alpha:1];
            text03.textAlignment = NSTextAlignmentLeft;
            text03.text = @"确认新密码";
            text03.delegate = self;
            [cell addSubview:text03];
        }
    }
    [cell addSubview:lblL1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10*ProportionX;
    } else if (section == 1) {
        return 20*ProportionX;
    } else {
        return 10*ProportionX;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.01)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 100;
    } else {
        return 0.0000000001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        
        UIButton *btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(30*ProportionX, 40*ProportionX, self.view.frame.size.width - 60*ProportionX, 50*ProportionX)];
        [btnSubmit setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
        [btnSubmit setTitle:@"确定" forState:UIControlStateNormal];
        btnSubmit.layer.masksToBounds = YES;
        btnSubmit.layer.cornerRadius = 25*ProportionX;
        [footView addSubview:btnSubmit];
        
        
        return footView;
    } else {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000000001)];
    }
}

#pragma mark - 按钮方法

/**
 验证码按钮
 */
- (void)btnCodeClickAction{
    [self btnMClickAction];
    if (text00.text.length == 11) {
        btnCode0.userInteractionEnabled = NO;
        [UserLogin getCodePhone:@{@"phone":text00} Success:^(id data) {
            self->code = [NSString stringWithFormat:@"%@",data];
        }];
        t = 60;
        [btnCode0 setTitle:[NSString stringWithFormat:@"%d",t] forState:normal];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(TimerAction) userInfo:nil repeats:YES];
        [self.view makeToast:@"发送成功"];
    } else {
        [self.view makeToast:@"请输入正确的手机号"];
    }
}


/**
 计时器
 */
- (void)TimerAction{
    t = t - 1;
    [btnCode0 setTitle:[NSString stringWithFormat:@"%d",t] forState:normal];
    if (t == 1) {
        [timer invalidate];
        btnCode0.userInteractionEnabled = YES;
        [btnCode0 setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}


//- (void)btnType0ClickAction{
//    [btnType0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btnType1 setTitleColor:[UIColor colorWithRed:4/255.0 green:103/255.0 blue:123/255.0 alpha:1] forState:UIControlStateNormal];
//    [UIView animateWithDuration:0.4 animations:^{
//        self->lblType.frame = CGRectMake(self.view.frame.size.width/8.0, 40*ProportionX, self.view.frame.size.width/4.0, 1);
//    }];
//}
//
//- (void)btnType1ClickAction{
//    [btnType1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btnType0 setTitleColor:[UIColor colorWithRed:4/255.0 green:103/255.0 blue:123/255.0 alpha:1] forState:UIControlStateNormal];
//    [UIView animateWithDuration:0.4 animations:^{
//        self->lblType.frame = CGRectMake(self.view.frame.size.width/8.0 * 5, 40*ProportionX, self.view.frame.size.width/4.0, 1);
//    }];
//}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
    textField.textColor = [UIColor whiteColor];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (text00.text.length == 0) {
        text00.textColor = [UIColor colorWithRed:95/255.0 green:174/255.0 blue:204/255.0 alpha:1];
        text00.text = @"请输入手机号";
    }
    
    if (text01.text.length == 0) {
        text01.textColor = [UIColor colorWithRed:95/255.0 green:174/255.0 blue:204/255.0 alpha:1];
        text01.text = @"请输入验证码";
    }
    
    if (text02.text.length == 0 || [text02.text isEqualToString:@"新密码"]) {
        text02.textColor = [UIColor colorWithRed:95/255.0 green:174/255.0 blue:204/255.0 alpha:1];
        text02.text = @"新密码";
        text02.secureTextEntry = NO;
    } else {
        text02.secureTextEntry = YES;
    }
    
    if (text03.text.length == 0 || [text03.text isEqualToString:@"确认新密码"]) {
        text03.textColor = [UIColor colorWithRed:95/255.0 green:174/255.0 blue:204/255.0 alpha:1];
        text03.text = @"确认新密码";
        text03.secureTextEntry = NO;
    } else {
        text03.secureTextEntry = YES;
    }
    return YES;
}

- (void)btnMClickAction{
    [text00 resignFirstResponder];
    [text01 resignFirstResponder];
    [text02 resignFirstResponder];
    [text03 resignFirstResponder];
}

- (void)btnLoginClickAction{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 屏幕旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{

    //    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    self.FVP.center = CGPointMake(self.view.frame.size.height/2.0, self.view.frame.size.width/2.0);

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
