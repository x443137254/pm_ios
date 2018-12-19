//
//  InstallerCodeView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/13.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "InstallerCodeView.h"
#import "common.h"

@interface InstallerCodeView () <UITextFieldDelegate> {
    UserInfoModel *model;
    
    UITextField *textCode;
    UITextField *textNum;
}

@end

@implementation InstallerCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:3/255.0 green:45/255.0 blue:59/255.0 alpha:1];
        [self loadView];

    }
    return self;
}



/**
 加载视图
 */
- (void)loadView{
    
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 50)];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    lblTitle.font = [UIFont systemFontOfSize:20];
    lblTitle.text = @"校验采集器序列号";
    [self addSubview:lblTitle];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(30, lblTitle.frame.origin.y + 10, 60, 30)];
    [LayerView Button:btnCancel BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:[UIColor colorWithRed:66/255.0 green:151/255.0 blue:190/255.0 alpha:1] Cor:15];
    [LayerView Button:btnCancel Title:@"取消" TitleColor:[UIColor colorWithRed:66/255.0 green:151/255.0 blue:190/255.0 alpha:1]];
    [btnCancel addTarget:self action:@selector(btnCancelClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnCancel];
    
    UIButton *btnSure = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 30 - 60, lblTitle.frame.origin.y + 10, 60, 30)];
    [LayerView Button:btnSure BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:[UIColor clearColor] Cor:15];
    [LayerView Button:btnSure Title:@"确定" TitleColor:[UIColor whiteColor]];
    [btnSure setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [btnSure addTarget:self action:@selector(btnSureClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnSure];

    textNum = [[UITextField alloc] initWithFrame:CGRectMake(40, lblTitle.frame.size.height + lblTitle.frame.origin.y + 30, self.frame.size.width - 80, 50)];
    [LayerView TextFiled:textNum BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:[UIColor colorWithRed:66/255.0 green:151/255.0 blue:190/255.0 alpha:1] Cor:textNum.frame.size.height/2.0];
    [LayerView TextFiled:textNum Title:@"请输入采集器序列号" TitleColor:[UIColor colorWithRed:66/255.0 green:151/255.0 blue:190/255.0 alpha:1]];
    textNum.textAlignment = NSTextAlignmentCenter;
    textNum.delegate = self;
    [self addSubview:textNum];
    
    textCode = [[UITextField alloc] initWithFrame:CGRectMake(40, textNum.frame.size.height + textNum.frame.origin.y + 40, self.frame.size.width - 80, 50)];
    [LayerView TextFiled:textCode BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:[UIColor colorWithRed:66/255.0 green:151/255.0 blue:190/255.0 alpha:1] Cor:textCode.frame.size.height/2.0];
    [LayerView TextFiled:textCode Title:@"请输入采集器校验码" TitleColor:[UIColor colorWithRed:66/255.0 green:151/255.0 blue:190/255.0 alpha:1]];
    textCode.textAlignment = NSTextAlignmentCenter;
    textCode.delegate = self;
    [self addSubview:textCode];
    
    UILabel *lblTips = [[UILabel alloc] initWithFrame:CGRectMake(0, textCode.frame.size.height + textCode.frame.origin.y + 40, self.frame.size.width, 20)];
    lblTips.textAlignment = NSTextAlignmentCenter;
    lblTips.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    lblTips.text = @"验证码为采集器背面5位字符";
    [self addSubview:lblTips];
    
}

- (void)btnSureClickAction{
    
    if (!model) {
        model = [[UserInfoModel alloc] init];
    }
    model.collectorNum = @"";
    model.collectorCheckCode = @"";
    
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"CollectorCheacK" info:model];
    }
}

- (void)btnCancelClickAction{
    if (!model) {
        model = [[UserInfoModel alloc] init];
    }
    model.collectorNum = @"";
    model.collectorCheckCode = @"";
    
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:info:)]) {
        [self.customDelegate btnClickWithTag:@"CollectorCheacKCancel" info:model];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
    textField.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textNum.text.length == 0) {
        textNum.text = @"请输入采集器序列号";
        textNum.textColor = [UIColor colorWithRed:5/255.0 green:59/255.0 blue:76/255.0 alpha:1];
    }
    
    if (textCode.text.length == 0) {
        textCode.text = @"请输入采集器校验码";
        textCode.textColor = [UIColor colorWithRed:5/255.0 green:59/255.0 blue:76/255.0 alpha:1];
    }
    
    return YES;
}

@end
