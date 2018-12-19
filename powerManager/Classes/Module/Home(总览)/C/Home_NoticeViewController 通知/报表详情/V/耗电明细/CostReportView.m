//
//  CostReportView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/25.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "CostReportView.h"
#import "common.h"

@implementation CostReportView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    UIView *imgBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 261, 100)];
    imgBG.backgroundColor = RGB_HEX(0xffffff, 0.1);
    imgBG.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    [self addSubview:imgBG];

    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imgBG.frame.origin.x / 2.0, 30)];
    lblName.center = CGPointMake(imgBG.frame.origin.x / 2.0 , self.frame.size.height/2.0);
    lblName.textColor = RGB_HEX(0xffffff, 1);
    lblName.font = [UIFont systemFontOfSize:24];
    lblName.text = @"谷";
    lblName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lblName];


    UILabel *lblDWQD = [[UILabel alloc] initWithFrame:CGRectMake(5 + imgBG.frame.origin.x, 5+ imgBG.frame.origin.y, 250, 15)];
    lblDWQD.textColor = RGB_HEX(0xfeae15, 1);
    lblDWQD.textAlignment = NSTextAlignmentLeft;
    lblDWQD.text = @"4307kWh";
    [self addSubview:lblDWQD];

    UIImageView *imgDWQD = [[UIImageView alloc] initWithFrame:CGRectMake(lblDWQD.frame.origin.x, lblDWQD.frame.origin.y + lblDWQD.frame.size.height, 250*0.6, 10)];
    imgDWQD.image = [UIImage imageNamed:@"JB3"];
    imgDWQD.layer.masksToBounds = YES;
    imgDWQD.layer.cornerRadius = 3;
    [self addSubview:imgDWQD];

    UILabel *lblFY = [[UILabel alloc] initWithFrame:CGRectMake(lblDWQD.frame.origin.x, 35, 250, 15)];
    lblFY.textColor = RGB_HEX(0xa290ff, 1);
    lblFY.textAlignment = NSTextAlignmentLeft;
    lblFY.text = @"¥200";
    [self addSubview:lblFY];

    UIImageView *imgFY = [[UIImageView alloc] initWithFrame:CGRectMake(lblDWQD.frame.origin.x, lblFY.frame.origin.y + lblFY.frame.size.height, 250*0.2, 10)];
    imgFY.image = [UIImage imageNamed:@"JB2"];
    imgFY.layer.masksToBounds = YES;
    imgFY.layer.cornerRadius = 3;
    [self addSubview:imgFY];

    UILabel *lblGFGD = [[UILabel alloc] initWithFrame:CGRectMake(lblDWQD.frame.origin.x, 65, 250, 15)];
    lblGFGD.textColor = RGB_HEX(0x06f2d8, 1);
    lblGFGD.textAlignment = NSTextAlignmentLeft;
    lblGFGD.text = @"307kWh";
    [self addSubview:lblGFGD];

    UIImageView *imgGFGD = [[UIImageView alloc] initWithFrame:CGRectMake(lblDWQD.frame.origin.x, lblGFGD.frame.origin.y + lblGFGD.frame.size.height, 250*0.4, 10)];
    imgGFGD.image = [UIImage imageNamed:@"btn"];
    imgGFGD.layer.masksToBounds = YES;
    imgGFGD.layer.cornerRadius = 3;
    [self addSubview:imgGFGD];


}

@end
