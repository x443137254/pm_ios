//
//  ElectricityPriceAllocationCell.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/23.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "ElectricityPriceAllocationCell.h"
#import "common.h"

@implementation ElectricityPriceAllocationCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self pretreatment];
    }
    return self;
}

- (void)pretreatment{
    if ([common isPhone]) {
        UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imgBG.layer.masksToBounds = YES;
        imgBG.layer.cornerRadius = 10*ProportionX;
        imgBG.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:imgBG];
        
        UIImageView *imgH = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10*ProportionX)];
        imgH.image = [UIImage imageNamed:@"高光"];
        [self addSubview:imgH];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(21*ProportionX, 0, self.frame.size.width - 21*ProportionX, 57*ProportionX)];
        self.title.textColor = [UIColor whiteColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = FontL;
        [self addSubview:self.title];
        
        UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(21*ProportionX, 57*ProportionX, (self.frame.size.width - 42*ProportionX)/2.0, 15*ProportionX)];
        lblPrice.textAlignment = NSTextAlignmentLeft;
        lblPrice.textColor = [UIColor colorWithRed:92/255.0 green:189/255.0 blue:223/255.0 alpha:1];
        lblPrice.font = FontS;
        lblPrice.text = @"单价";
        [self addSubview:lblPrice];

        self.price = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 57*ProportionX, (self.frame.size.width - 42*ProportionX)/2.0, 15*ProportionX)];
        self.price.textAlignment = NSTextAlignmentLeft;
        self.price.textColor = [UIColor whiteColor];
        self.price.font = FontS;
        [self addSubview:self.price];
        
        UILabel *lblTimeStart = [[UILabel alloc] initWithFrame:CGRectMake(21*ProportionX, 86*ProportionX, (self.frame.size.width - 42*ProportionX)/2.0, 15*ProportionX)];
        lblTimeStart.textAlignment = NSTextAlignmentLeft;
        lblTimeStart.textColor = [UIColor colorWithRed:92/255.0 green:189/255.0 blue:223/255.0 alpha:1];
        lblTimeStart.font = FontS;
        lblTimeStart.text = @"起始时间";
        [self addSubview:lblTimeStart];
        
        self.timeStart = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 86*ProportionX, (self.frame.size.width - 42*ProportionX)/2.0, 15*ProportionX)];
        self.timeStart.textAlignment = NSTextAlignmentLeft;
        self.timeStart.textColor = [UIColor whiteColor];
        self.timeStart.font = FontS;
        [self addSubview:self.timeStart];
        
        UILabel *lblTimeStop = [[UILabel alloc] initWithFrame:CGRectMake(21*ProportionX, 115*ProportionX, (self.frame.size.width - 42*ProportionX)/2.0, 15*ProportionX)];
        lblTimeStop.textAlignment = NSTextAlignmentLeft;
        lblTimeStop.textColor = [UIColor colorWithRed:92/255.0 green:189/255.0 blue:223/255.0 alpha:1];
        lblTimeStop.font = FontS;
        lblTimeStop.text = @"有效时间";
        [self addSubview:lblTimeStop];
        
        self.timeStop = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 115*ProportionX, (self.frame.size.width - 42*ProportionX)/2.0, 15*ProportionX)];
        self.timeStop.textAlignment = NSTextAlignmentLeft;
        self.timeStop.textColor = [UIColor whiteColor];
        self.timeStop.font = FontS;
        [self addSubview:self.timeStop];
        
        
        UILabel *lblIsEffect = [[UILabel alloc] initWithFrame:CGRectMake(21*ProportionX, 145*ProportionX, (self.frame.size.width - 42*ProportionX)/2.0, 15*ProportionX)];
        lblIsEffect.textAlignment = NSTextAlignmentLeft;
        lblIsEffect.textColor = [UIColor colorWithRed:92/255.0 green:189/255.0 blue:223/255.0 alpha:1];
        lblIsEffect.font = FontS;
        lblIsEffect.text = @"是否有效";
        [self addSubview:lblIsEffect];
        
        self.IsEffect = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 145*ProportionX, (self.frame.size.width - 42*ProportionX)/2.0, 15*ProportionX)];
        self.IsEffect.textAlignment = NSTextAlignmentLeft;
        self.IsEffect.textColor = [UIColor whiteColor];
        self.IsEffect.font = FontS;
        [self addSubview:self.IsEffect];
        
    } else {
        
        UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imgBG.layer.masksToBounds = YES;
        imgBG.layer.cornerRadius = 10;
        imgBG.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:imgBG];
        
        UIImageView *imgH = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        imgH.image = [UIImage imageNamed:@"高光"];
        [self addSubview:imgH];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, self.frame.size.width - 21, 57)];
        self.title.textColor = [UIColor whiteColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.title];
        
        UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(21, 57, (self.frame.size.width - 42)/2.0, 15)];
        lblPrice.textAlignment = NSTextAlignmentLeft;
        lblPrice.textColor = [UIColor colorWithRed:92/255.0 green:189/255.0 blue:223/255.0 alpha:1];
        self.title.font = [UIFont systemFontOfSize:16];
        lblPrice.text = @"单价";
        [self addSubview:lblPrice];
        
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 57, (self.frame.size.width - 42)/2.0, 15)];
        self.price.textAlignment = NSTextAlignmentLeft;
        self.price.textColor = [UIColor whiteColor];
        self.title.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.price];
        
        UILabel *lblTimeStart = [[UILabel alloc] initWithFrame:CGRectMake(21, 86, (self.frame.size.width - 42)/2.0, 15)];
        lblTimeStart.textAlignment = NSTextAlignmentLeft;
        lblTimeStart.textColor = [UIColor colorWithRed:92/255.0 green:189/255.0 blue:223/255.0 alpha:1];
        self.title.font = [UIFont systemFontOfSize:16];
        lblTimeStart.text = @"起始时间";
        [self addSubview:lblTimeStart];
        
        self.timeStart = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 86, (self.frame.size.width - 42)/2.0, 15)];
        self.timeStart.textAlignment = NSTextAlignmentLeft;
        self.timeStart.textColor = [UIColor whiteColor];
        self.title.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.timeStart];
        
        UILabel *lblTimeStop = [[UILabel alloc] initWithFrame:CGRectMake(21, 115, (self.frame.size.width - 42)/2.0, 15)];
        lblTimeStop.textAlignment = NSTextAlignmentLeft;
        lblTimeStop.textColor = [UIColor colorWithRed:92/255.0 green:189/255.0 blue:223/255.0 alpha:1];
        self.title.font = [UIFont systemFontOfSize:16];
        lblTimeStop.text = @"有效时间";
        [self addSubview:lblTimeStop];
        
        self.timeStop = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 115, (self.frame.size.width - 42)/2.0, 15)];
        self.timeStop.textAlignment = NSTextAlignmentLeft;
        self.timeStop.textColor = [UIColor whiteColor];
        self.title.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.timeStop];
        
        
        UILabel *lblIsEffect = [[UILabel alloc] initWithFrame:CGRectMake(21, 145, (self.frame.size.width - 42)/2.0, 15)];
        lblIsEffect.textAlignment = NSTextAlignmentLeft;
        lblIsEffect.textColor = [UIColor colorWithRed:92/255.0 green:189/255.0 blue:223/255.0 alpha:1];
        self.title.font = [UIFont systemFontOfSize:16];
        lblIsEffect.text = @"是否有效";
        [self addSubview:lblIsEffect];
        
        self.IsEffect = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 145, (self.frame.size.width - 42)/2.0, 15)];
        self.IsEffect.textAlignment = NSTextAlignmentLeft;
        self.IsEffect.textColor = [UIColor whiteColor];
        self.title.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.IsEffect];
    }
}

@end
