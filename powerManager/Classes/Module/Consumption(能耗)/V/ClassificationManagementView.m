//
//  ClassificationManagementView.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/28.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "ClassificationManagementView.h"
#import "common.h"

@interface ClassificationManagementView () {
    int t;
    UIImageView *imgL;
    
}

@property (nonatomic, copy) UIImage *icon;

@end

@implementation ClassificationManagementView

- (void)loadView{
    
    NSLog(@"width = %f ,height = %f",self.frame.size.width,self.frame.size.height);
    t = -1;
    float ProportionView = self.frame.size.width / 375.0;
    
    UIButton *btnTitle = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45)];
    if (self.frame.size.width == 649) {
        btnTitle.frame = CGRectMake(0, 0, self.frame.size.width, 45);
    } else if (self.frame.size.width == 510){
        btnTitle.frame = CGRectMake(0, 0, self.frame.size.width, 45);
    }
    
    [btnTitle setTitle:[NSString stringWithFormat:@"%@",self.title] forState:UIControlStateNormal];
    [btnTitle setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [btnTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, - btnTitle.imageView.image.size.width, 0, btnTitle.imageView.image.size.width)];
    [btnTitle setImageEdgeInsets:UIEdgeInsetsMake(0, btnTitle.titleLabel.bounds.size.width, 0, -btnTitle.titleLabel.bounds.size.width)];
    [self addSubview:btnTitle];
    
    if ([self.title isEqualToString:@"空调"]) {
        self.icon = [UIImage imageNamed:@"分类_aircondition"];
    } else if ([self.title isEqualToString:@"照明"]) {
        self.icon = [UIImage imageNamed:@"分类_light"];
    } else {
        self.icon = [UIImage imageNamed:@"分类_charger"];
    }
    
    UIImageView *imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12*ProportionView, 47*ProportionView, 26*ProportionView, 26*ProportionView)];
    if (self.frame.size.width == 649) {
        imgIcon.frame = CGRectMake(39, 50, 40, 40);
    } else if (self.frame.size.width == 510){
        imgIcon.frame = CGRectMake(39, 50, 40, 40);
    }
    imgIcon.image = self.icon;
    [self addSubview:imgIcon];
    
    UILabel *lblDataTotol = [[UILabel alloc] initWithFrame:CGRectMake(50*ProportionView, 40*ProportionView, 69*ProportionView, 20*ProportionView)];
    if (self.frame.size.width == 649) {
        lblDataTotol.frame = CGRectMake(83, 50, 100, 20);
    } else if (self.frame.size.width == 510){
        lblDataTotol.frame = CGRectMake(83, 50, 100, 20);
    }
    lblDataTotol.textAlignment = NSTextAlignmentLeft;
    lblDataTotol.textColor = [UIColor whiteColor];
    lblDataTotol.text = self.dataTotle;
    [self addSubview:lblDataTotol];
    
    UILabel *lblTotol = [[UILabel alloc] initWithFrame:CGRectMake(50*ProportionView, 40*ProportionView +20*ProportionView, 69*ProportionView, 20*ProportionView)];
    if (self.frame.size.width == 649) {
        lblTotol.frame = CGRectMake(83, 70, 100, 20);
    } else if (self.frame.size.width == 510){
        lblTotol.frame = CGRectMake(83, 70, 100, 20);
    }
    lblTotol.textAlignment = NSTextAlignmentLeft;
    lblTotol.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTotol.text = @"全部";
    [self addSubview:lblTotol];
    
    ProgressView *progressView0 = [[ProgressView alloc] initWithFrame:CGRectMake(109*ProportionView, 40*ProportionView , 35*ProportionView, 35*ProportionView)];
    if (self.frame.size.width == 649) {
        progressView0.frame = CGRectMake(250, 45, 50, 50);
    } else if (self.frame.size.width == 510){
        progressView0.frame = CGRectMake(200, 45, 50, 50);
    }
    progressView0.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView0.colorTop = [UIColor colorWithRed:255/255.0 green:193/255.0 blue:0/255.0 alpha:1];
    float progress = [self.num floatValue] / [self.dataTotle floatValue];
    progressView0.progress = progress;
    progressView0.colorButtom = [UIColor colorWithRed:9/255.0 green:92/255.0 blue:121/255.0 alpha:1];
    progressView0.animationTime = 1;
    progressView0.topWidth = 5*ProportionView;
    progressView0.buttomWidth = 5*ProportionView;
    [self addSubview:progressView0];
    
    UILabel *lblDataNum = [[UILabel alloc] initWithFrame:CGRectMake(progressView0.frame.origin.x + progressView0.frame.size.width + 10*ProportionView, 40*ProportionView, 69*ProportionView, 20*ProportionView)];
    if (self.frame.size.width == 649) {
        lblDataNum.frame = CGRectMake(315, 50, 100, 20);
    } else if (self.frame.size.width == 510){
        lblDataNum.frame = CGRectMake(255, 50, 100, 20);
    }
    lblDataNum.textAlignment = NSTextAlignmentLeft;
    lblDataNum.textColor = [UIColor colorWithRed:255/255.0 green:193/255.0 blue:0/255.0 alpha:1];
    lblDataNum.text = self.num;
    [self addSubview:lblDataNum];
    
    UILabel *lblNum = [[UILabel alloc] initWithFrame:CGRectMake(progressView0.frame.origin.x + progressView0.frame.size.width + 10*ProportionView, 40*ProportionView +20*ProportionView, 69*ProportionView, 20*ProportionView)];
    if (self.frame.size.width == 649) {
        lblNum.frame = CGRectMake(315, 70, 100, 20);
    } else if (self.frame.size.width == 510){
        lblNum.frame = CGRectMake(255, 70, 100, 20);
    }
    lblNum.textAlignment = NSTextAlignmentLeft;
    lblNum.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblNum.text = @"运行中";
    [self addSubview:lblNum];
    
   imgL = [[UIImageView alloc] initWithFrame:CGRectMake(220*ProportionView, 54*ProportionView, 40*ProportionView, (40*11/36.0)*ProportionView)];
    if (self.frame.size.width == 649) {
        imgL.frame = CGRectMake(388, 65, 36, 11);
    } else if (self.frame.size.width == 510){
        imgL.frame = CGRectMake(339, 65, 36, 11);
    }
    imgL.image = [UIImage imageNamed:@"电网功率_流动_work3"];
    [self addSubview:imgL];
    
    UILabel *lblDataPower = [[UILabel alloc] initWithFrame:CGRectMake(280*ProportionView, 40*ProportionView, 69*ProportionView, 20*ProportionView)];
    if (self.frame.size.width == 649) {
        lblDataPower.frame = CGRectMake(476, 50, 100, 20);
    } else if (self.frame.size.width == 510){
        lblDataPower.frame = CGRectMake(427, 50, 100, 20);
    }
    lblDataPower.textAlignment = NSTextAlignmentLeft;
    lblDataPower.textColor = [UIColor whiteColor];
    lblDataPower.text = [NSString stringWithFormat:@"%@kWh",self.power];
    lblDataPower.font = [UIFont systemFontOfSize:12*ProportionView];
    [self addSubview:lblDataPower];
    
    UILabel *lblPower = [[UILabel alloc] initWithFrame:CGRectMake(280*ProportionView, 40*ProportionView +20*ProportionView, 69*ProportionView, 20*ProportionView)];
    if (self.frame.size.width == 649) {
        lblPower.frame = CGRectMake(476, 70, 100, 20);
    } else if (self.frame.size.width == 510){
        lblPower.frame = CGRectMake(427, 70, 100, 20);
    }
    lblPower.textAlignment = NSTextAlignmentLeft;
    lblPower.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPower.text = @"能耗";
    [self addSubview:lblPower];
}

//轮播图
- (void)changeImage{
    t = t + 1;
    if (t == 0) {
        imgL.image = [UIImage imageNamed:@"电网功率_流动_work1"];
    } else if (t == 1) {
        imgL.image = [UIImage imageNamed:@"电网功率_流动_work2"];
    } else if (t == 2) {
        t = -1;
        imgL.image = [UIImage imageNamed:@"电网功率_流动_work3"];
    }
    
}


@end
