//
//  RegisterView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/13.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "RegisterView.h"

#import "common.h"
#import "DNTableViewCell.h"
#import "TLHeader.h"


@interface RegisterView ()  <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    UITableView *tableView;
    UITextField *textM;
    UIButton *btnTerm;
    UIButton *btnSubmit;
    UIButton *btnCancel;
    BOOL IsSure;
    
    UserInfoModel *model;
    
    DNTableViewCell *DNCell00;
    DNTableViewCell *DNCell10;
    DNTableViewCell *DNCell11;
    DNTableViewCell *DNCell20;
    DNTableViewCell *DNCell30;
    DNTableViewCell *DNCell31;
    DNTableViewCell *DNCell32;
    DNTableViewCell *DNCell40;
    DNTableViewCell *DNCell50;
    
}

/** 地区 */
@property (nonatomic, strong) BRTextField *addressTF;

@end

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    IsSure = NO;
    UIButton *btnm = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //    [btnm addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnm];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    img.image = [UIImage imageNamed:@"bg"];
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundView = img;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    [self addSubview:tableView];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 3;
    } else if (section == 4) {
        return 1;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*ProportionX;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor colorWithRed:3/255.0 green:34/255.0 blue:44/255.0 alpha:0.7];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DNCell00 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
            DNCell00.lblTitle.text = @"手机/邮箱";
            DNCell00.lblMark.text = @"*";
            DNCell00.textContent.delegate = self;
            DNCell00.textContent.text = @"请输入手机号或邮箱";
            [cell addSubview:DNCell00];
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            DNCell10 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
            DNCell10.lblTitle.text = @"密码";
            DNCell10.lblMark.text = @"*";
            DNCell10.textContent.delegate = self;
            DNCell10.textContent.text = @"请输入密码";
            [cell addSubview:DNCell10];
        } else {
            DNCell11 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
            DNCell11.lblTitle.text = @"确认密码";
            DNCell11.lblMark.text = @"*";
            DNCell11.textContent.delegate = self;
            DNCell11.textContent.text = @"请再次输入密码";
            [cell addSubview:DNCell11];
        }
    } else if (indexPath.section == 2) {
        DNCell20 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
        DNCell20.lblTitle.text = @"公司名称";
        DNCell20.lblMark.text = @"*";
        DNCell20.textContent.delegate = self;
        DNCell20.textContent.text = @"请输入公司名称";
        [cell addSubview:DNCell20];
    } else if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
////            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            [self setupAddressTF:cell];
            DNCell30 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
            DNCell30.lblTitle.text = @"国家地区";
            DNCell30.lblMark.text = @"*";
            DNCell30.textContent.delegate = self;
            DNCell30.textContent.text = @"请选择国家";
            [cell addSubview:DNCell30];
        } else if (indexPath.row == 1) {
            DNCell31 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
//            DNCell31.lblTitle.text = @"国家地区";
//            DNCell31.lblMark.text = @"*";
            DNCell31.textContent.delegate = self;
            DNCell31.textContent.text = @"请选择地区";
            [cell addSubview:DNCell31];
        } else if (indexPath.row == 2) {
            DNCell32 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
            //            DNCell31.lblTitle.text = @"国家地区";
            //            DNCell31.lblMark.text = @"*";
            DNCell32.textContent.delegate = self;
            DNCell32.textContent.text = @"详细地址";
            [cell addSubview:DNCell32];
        }
    } else if (indexPath.section == 4) {
        DNCell40 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
        DNCell40.lblTitle.text = @"语言";
        DNCell40.lblMark.text = @"*";
        DNCell40.textContent.delegate = self;
        DNCell40.textContent.text = @"请选择语言";
        [cell addSubview:DNCell40];
    } else {
        DNCell50 = [[DNTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
        DNCell50.lblTitle.text = @"安装编码";
//        DNCell50.lblMark.text = @"*";
        DNCell50.textContent.delegate = self;
        DNCell50.textContent.text = @"请输入安装商编码";
        [cell addSubview:DNCell50];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 18*ProportionX;
    } else {
        return 9*ProportionX;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 9*ProportionX)];
    headView.backgroundColor = [UIColor clearColor];
    UIButton *btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
    [btnM addTarget:self action:@selector(textResign) forControlEvents:UIControlEventTouchUpInside];
    if (section == 0) {
        headView.frame = CGRectMake(0, 0, self.frame.size.width, 18*ProportionX);
        btnM.frame = CGRectMake(0, 0, self.frame.size.width, 18*ProportionX);
    }
    [headView addSubview:btnM];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 5) {
        return self.frame.size.height - 64 - (18 + 27 + 45*9)*ProportionX;
    } else {
        return 0.00000000001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 5) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64 - (18 + 27 + 45*9)*ProportionX)];
        
        btnTerm = [[UIButton alloc] initWithFrame:CGRectMake(55*ProportionX, 35*ProportionX, self.frame.size.width - 110*ProportionX, 30*ProportionX)];
        [btnTerm setImage:[UIImage imageNamed:@"不同意"] forState:UIControlStateNormal];
        [btnTerm setTitle:@"《同意本公司各项条款》" forState:UIControlStateNormal];
        [btnTerm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnTerm.titleLabel.font = FontM;
        [btnTerm addTarget:self action:@selector(btnTermClickAction) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:btnTerm];
        
        if (!btnSubmit) {
            btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0 + 10, 75*ProportionX, 300/2.0 *ProportionX, 50*ProportionX)];
            btnSubmit.layer.masksToBounds = YES;
            btnSubmit.layer.cornerRadius = 25*ProportionX;
            [btnSubmit setTitle:@"下一步" forState:UIControlStateNormal];
            [btnSubmit addTarget:self action:@selector(btnRegSubmitClickAction) forControlEvents:UIControlEventTouchUpInside];
            [btnSubmit setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
        }
        [footView addSubview:btnSubmit];
        
        if (!btnCancel) {
            btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0 - 150*ProportionX - 10, 75*ProportionX, 300/2.0 *ProportionX, 50*ProportionX)];
            btnCancel.layer.masksToBounds = YES;
            btnCancel.layer.cornerRadius = 25*ProportionX;
            [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
            [btnCancel addTarget:self action:@selector(btnCancelClickAction) forControlEvents:UIControlEventTouchUpInside];
            [btnCancel setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
        }
        [footView addSubview:btnCancel];
        
        return footView;
    } else {
        return nil;
    }
}


#pragma mark - text代理
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@"请输入手机号或邮箱"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    }
    if ([textField.text isEqualToString:@"请输入密码"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
        textField.secureTextEntry = YES;
    }
    if ([textField.text isEqualToString:@"请再次输入密码"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
        textField.secureTextEntry = YES;
    }
    if ([textField.text isEqualToString:@"请输入公司名称"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    }
    if ([textField.text isEqualToString:@"请选择国家"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    }
    if ([textField.text isEqualToString:@"请选择地区"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    }
    if ([textField.text isEqualToString:@"详细地址"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    }
    if ([textField.text isEqualToString:@"请选择语言"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    }
    if ([textField.text isEqualToString:@"请输入安装商编码"]) {
        textField.text = @"";
        textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    }
    
    if (textField == DNCell31.textContent) {
        [textField resignFirstResponder];
        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3]
                                                     isAutoSelect:NO
                                                      resultBlock:^(NSArray *selectAddressArr) {
//                                                          __weak typeof(self) weakSelf = self;
//                                                          weakSelf.addressTF.text = [NSString stringWithFormat:@"%@  %@  %@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
                                                          self->DNCell31.textContent.text = [NSString stringWithFormat:@"%@  %@  %@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
                                                          self->DNCell31.textContent.textColor = RGB_HEX(0xffffff, 1);
                                                          [textField resignFirstResponder];
                                                      }];
        
    }
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField == DNCell00.textContent) {
        if (DNCell00.textContent.text.length > 0) {
//            判断是否存在
            if (!model) {
                model = [[UserInfoModel alloc] init];
            }
            model.account = textField.text;
            if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
                [self.customDelegate btnClickWithTag:@"AccountExit" info:model];
            }
        }
    }
    
    if (DNCell00.textContent.text.length == 0) {
        DNCell00.textContent.text = @"请输入手机号或邮箱";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    }
    
    if (DNCell10.textContent.text.length == 0) {
        DNCell10.textContent.text = @"请输入密码";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
        textField.secureTextEntry = NO;
    }
    
    if (DNCell11.textContent.text.length == 0) {
        DNCell11.textContent.text = @"请再次输入密码";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
        textField.secureTextEntry = NO;
    }
    
    if (DNCell20.textContent.text.length == 0) {
        DNCell20.textContent.text = @"请输入公司名称";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    }
    
    if (DNCell30.textContent.text.length == 0) {
        DNCell30.textContent.text = @"请选择国家";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    }
    
    if (DNCell31.textContent.text.length == 0) {
        DNCell31.textContent.text = @"请选择地区";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    }
    
    if (DNCell32.textContent.text.length == 0) {
        DNCell32.textContent.text = @"详细地址";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    }
    
    if (DNCell40.textContent.text.length == 0) {
        DNCell40.textContent.text = @"请选择语言";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    }
    
    if (DNCell50.textContent.text.length == 0) {
        DNCell50.textContent.text = @"请输入安装编码";
        textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    }

    
    return YES;
}

#pragma mark - 方法

- (void)btnTermClickAction{
    if (IsSure) {
        IsSure = NO;
        [btnTerm setImage:[UIImage imageNamed:@"不同意"] forState:UIControlStateNormal];
    } else {
        IsSure = YES;
        [btnTerm setImage:[UIImage imageNamed:@"同意"] forState:UIControlStateNormal];
    }
}

- (void)btnRegSubmitClickAction{
    [self textResign];
    UIColor *colorCustom = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    if (CGColorEqualToColor(DNCell00.textContent.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(DNCell10.textContent.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(DNCell11.textContent.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(DNCell20.textContent.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(DNCell30.textContent.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(DNCell31.textContent.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(DNCell32.textContent.textColor.CGColor, colorCustom.CGColor) || CGColorEqualToColor(DNCell40.textContent.textColor.CGColor, colorCustom.CGColor) )
    {
        
        [self makeToast:@"请填入完整的信息,红色标注为必填"];
        
    }
    else
    {
        if (![DNCell10.textContent.text isEqualToString:DNCell11.textContent.text]) {
            [self makeToast:@"密码与确认密码输入不一致"];
        } else {
            model.account = DNCell00.textContent.text;
            model.password = DNCell10.textContent.text;
            model.nick = DNCell00.textContent.text;
            model.phone = DNCell00.textContent.text;
            model.email = DNCell00.textContent.text;
            model.country = DNCell30.textContent.text;
            model.language = DNCell40.textContent.text;
            model.company = DNCell20.textContent.text;
            
            NSString *addr = [NSString stringWithFormat:@"%@%@",DNCell31.textContent.text,DNCell32.textContent.text];
            
            
//           model.addr =  [[self removeSpaceAndNewline:addr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            model.addr = [self removeSpaceAndNewline:addr];
            
            NSString *userType = DNCell50.textContent.text;
            if ([userType isEqualToString:@"请输入安装商编码"]) {
                userType = @"无";
            }
            model.userType = userType;
            if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
                [self.customDelegate btnClickWithTag:@"Register" info:model];
            }
        }
    }
   
}

- (void)btnCancelClickAction{
    [self textResign];
    if (!model) {
        model = [[UserInfoModel alloc] init];
    }
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"Cancel" info:model];
    }
}

#pragma mark - 地址 textField
- (void)setupAddressTF:(UITableViewCell *)cell {
    [self textResign];
    if (!_addressTF) {
        _addressTF = [self getTextField:cell];
        _addressTF.placeholder = @"请选择";
        _addressTF.text = @"请选择地址";
    }
}

- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(137*ProportionX, 7.5*ProportionX, self.frame.size.width - 10*ProportionX - 117*ProportionX, 30*ProportionX)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 3) {
//        if (indexPath.row == 1) {
//            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {
//                __weak typeof(self) weakSelf = self;
//                weakSelf.addressTF.text = [NSString stringWithFormat:@"%@  %@  %@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
//            }];
//        }
//    }
//}

- (void)textResign{
    if (!textM) {
        textM = [[UITextField alloc] initWithFrame:CGRectMake(0, self.frame.size.width - 0.1, 1, 0.1)];
    }
    [self addSubview:textM];
    [textM becomeFirstResponder];
    [textM resignFirstResponder];
//    [textM removeFromSuperview];
}


/**
 使用替换的方式去掉空格转行

 @param str 需要转换的字符串
 @return 返回转换好的字符串
 */
- (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
