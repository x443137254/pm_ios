//
//  DNTableViewCell.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/23.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "DNTableViewCell.h"
#import "common.h"

@implementation DNTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX, 7.5*ProportionX, 137*ProportionX, 30*ProportionX)];
    self.lblTitle.font = FontM;
    self.lblTitle.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    self.lblTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.lblTitle];
    
    self.lblMark = [[UILabel alloc] initWithFrame:CGRectMake(10*ProportionX, 17.5*ProportionX, 10*ProportionX, 10*ProportionX)];
    self.lblMark.textColor = [UIColor redColor];
    self.lblMark.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lblMark];
    
    UIButton *btnM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+10)];
    [btnM addTarget:self action:@selector(btnMClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnM];
    
    self.textContent = [[UITextField alloc] initWithFrame:CGRectMake(137*ProportionX, 7.5*ProportionX, self.frame.size.width - 10*ProportionX - 117*ProportionX, 30*ProportionX)];
    self.textContent.font = FontS;
    self.textContent.textColor = [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];
    self.textContent.textAlignment = NSTextAlignmentLeft;
    [self.textContent setValue:[UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self addSubview:self.textContent];
    
    UILabel *lblline1 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 1)];
    if (self.lblTitle.text.length <= 0) {
        lblline1.frame = CGRectMake(137*ProportionX, self.frame.size.height - 1, self.frame.size.width - 137*ProportionX, 1);
    }
    lblline1.backgroundColor = [UIColor colorWithRed:7/255.0 green:71/255.0 blue:93/255.0 alpha:1];
    [self addSubview:lblline1];
}

- (void)btnMClickAction{
    [self.textContent resignFirstResponder];
}

@end
