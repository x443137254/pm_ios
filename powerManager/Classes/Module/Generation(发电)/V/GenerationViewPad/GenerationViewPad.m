//
//  GenerationViewPad.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/7.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "GenerationViewPad.h"
#import "common.h"
#import "TLHeader.h"
#import "InterverDetailViewController.h"
#import "AlertDetailsPadView.h"

@interface GenerationViewPad () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    
    UIButton *btnRealTime;
    UIButton *btnDay;
    UIButton *btnMonth;
    UIButton *btnYear;
    UIButton *btnChoose;
    NSArray *listCellHeight;
    
    UIImageView *imgRD;
    UIImageView *imgLD;
    UIImageView *imgRA;
    UIImageView *imgLA;
    UIImageView *imgBA;
    CABasicAnimation *rotationAnimation;
    int t;
    
    UIImageView *imgBD;
    UIImageView *imgTD;
    UIImageView *imgR0;
    UIImageView *imgR1;
    UIImageView *imgL0;
    UIImageView *imgL1;
    
    UIView *opticalStorageview;
    UIView *statisticalDataView;
    UIView *PVPowerView;
    UIView *deviceView;
    
    AlertDetailsPadView *ADPV;
    
}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@end

@implementation GenerationViewPad

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    NSLog(@"%f %f",self.frame.size.width,self.frame.size.height);

    if (!rotationAnimation) {
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 4;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
        t = -1;
    }
    
    if (self.frame.size.width > self.frame.size.height) {
        opticalStorageview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 375)];
        statisticalDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 350, 375, self.frame.size.height - 350)];
        PVPowerView = [[UIView alloc] initWithFrame:CGRectMake(375 + 15, 0, 1060/2.0, 600/2.0)];
        deviceView = [[UIView alloc] initWithFrame:CGRectMake(375 + 15, 300+15, 1060/2.0, 808/2.0)];
        
        [self opticalStorage];
        [self statisticalDataView];
        [self PVPowerView0];
        [self deviceView];
        
        
        [self loadViewHorizontal];
    } else {
        
        opticalStorageview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 686/2.0)];
        PVPowerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300)];
        statisticalDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 400)];
        deviceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 406)];
        
        [self opticalStorage];
        [self statisticalDataView];
        [self PVPowerView0];
        [self deviceView];
        
        [self addSubview:opticalStorageview];
        [self loadViewVertical];
    }
    

    
}

#pragma mark- 竖屏
//竖屏
- (void)loadViewVertical{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.bounces = NO;
    [self addSubview:tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 15)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return opticalStorageview.frame.size.height;
    } else if (indexPath.section == 1) {
        return PVPowerView.frame.size.height;
    } else if (indexPath.section == 2) {
       return statisticalDataView.frame.size.height;
    } else if (indexPath.section == 3) {
        return deviceView.frame.size.height;
    } else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        
        [cell addSubview:opticalStorageview];
        
    } else if (indexPath.section == 1) {
        [cell addSubview:PVPowerView];
        
    } else if (indexPath.section == 2) {
        
        [cell addSubview:statisticalDataView];
        
    } else if (indexPath.section == 3) {
        
        [cell addSubview:deviceView];
    }
    
    
    return cell;
}


#pragma mark- 横屏
//横屏
- (void)loadViewHorizontal{
    
    [self addSubview:opticalStorageview];
    [self addSubview:statisticalDataView];
    [self addSubview:PVPowerView];
    [self addSubview:deviceView];
}


/**
 光储运行图
 */
- (void)opticalStorage{
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, opticalStorageview.frame.size.width/2.0, 44)];
    lblTitle.font = [UIFont systemFontOfSize:26];
    lblTitle.text = @"光储系统运行图";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentLeft;
    [opticalStorageview addSubview:lblTitle];
    
    UIButton *btnTitle = [[UIButton alloc] initWithFrame:CGRectMake(opticalStorageview.frame.size.width - 250/2.0, (44-30)/2.0, 250/2.0, 30)];
    [LayerView Button:btnTitle BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:[UIColor colorWithRed:4/255.0 green:86/255.0 blue:83/255.0 alpha:1] Cor:30/2.0];
    [btnTitle setTitle:@"NRC5096002" forState:UIControlStateNormal];
    btnTitle.titleLabel.font = [UIFont systemFontOfSize:14];
    [opticalStorageview addSubview:btnTitle];
    
    ProgressView *progressView0 = [[ProgressView alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0, 60, 100, 100)];
    progressView0.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView0.colorTop = [UIColor colorWithRed:37/255.0 green:206/255.0 blue:77/255.0 alpha:1];
    progressView0.progress = 0.2;
    progressView0.colorButtom = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    progressView0.animationTime = 1;
    progressView0.topWidth = 5;
    progressView0.buttomWidth = 5;
    [opticalStorageview addSubview:progressView0];
    
    UIImageView *imgbuttom0 = [[UIImageView alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 118)/2.0, progressView0.frame.origin.y - 9, 118, 118)];
    imgbuttom0.image = [UIImage imageNamed:@"光伏产出_用电消耗bg"];
    [opticalStorageview addSubview:imgbuttom0];

    
    UILabel *lblDataPhotovoltaicOutput = [[UILabel alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0, progressView0.frame.origin.y + 30, 100, 20)];
    lblDataPhotovoltaicOutput.text = @"1000kWh";
    lblDataPhotovoltaicOutput.textAlignment = NSTextAlignmentCenter;
    lblDataPhotovoltaicOutput.textColor = [UIColor whiteColor];
    [opticalStorageview addSubview:lblDataPhotovoltaicOutput];
    
    UILabel *lblPhotovoltaicOutput = [[UILabel alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0, progressView0.frame.origin.y+50, 100, 20)];
    lblPhotovoltaicOutput.text = @"光伏产出";
    lblPhotovoltaicOutput.font = [UIFont systemFontOfSize:18];
    lblPhotovoltaicOutput.textAlignment = NSTextAlignmentCenter;
    lblPhotovoltaicOutput.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    [opticalStorageview addSubview:lblPhotovoltaicOutput];
    
    imgL0 = [[UIImageView alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 - 50, progressView0.frame.origin.y + 50 - 12.5, 13*25/18.0, 18*25/18.0)];
    if (self.frame.size.width < self.frame.size.height) {
        imgL0.frame = CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 - 125, progressView0.frame.origin.y + 50 - 12.5, 13*25/18.0, 18*25/18.0);
    }
    imgL0.image = [UIImage imageNamed:@"自发自用_流动_work"];
    [opticalStorageview addSubview:imgL0];
    
    UILabel *lblDataSpontaneousUse = [[UILabel alloc] initWithFrame:CGRectMake(0, progressView0.frame.origin.y + 50 - 30, 90, 20)];
    lblDataSpontaneousUse.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataSpontaneousUse.textAlignment = NSTextAlignmentCenter;
    lblDataSpontaneousUse.text = @"800kWh";
    [opticalStorageview addSubview:lblDataSpontaneousUse];
    
    UILabel *lblTL0 = [[UILabel alloc] initWithFrame:CGRectMake(0, progressView0.frame.origin.y + 50 - 10, 90, 20)];
    lblTL0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTL0.textAlignment = NSTextAlignmentCenter;
    lblTL0.text = @"自发自用";
    [opticalStorageview addSubview:lblTL0];
    
    UILabel *lblBL0 = [[UILabel alloc] initWithFrame:CGRectMake(0, progressView0.frame.origin.y + 50 + 10, 90, 20)];
    lblBL0.textColor = [UIColor whiteColor];
    lblBL0.textAlignment = NSTextAlignmentCenter;
    lblBL0.text = @"80%";
    [opticalStorageview addSubview:lblBL0];
    
    imgR0 = [[UIImageView alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 + 100 +50- 13*25/18.0, progressView0.frame.origin.y + 50 - 12.5, 13*25/18.0, 18*25/18.0)];
    if (self.frame.size.width < self.frame.size.height) {
        imgR0.frame =CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 + 100 +125- 13*25/18.0, progressView0.frame.origin.y + 50 - 12.5, 13*25/18.0, 18*25/18.0);
    }
    imgR0.image = [UIImage imageNamed:@"馈回电网_流动_work"];
    [opticalStorageview addSubview:imgR0];
    
    UILabel *lblDataFeedBackGrid = [[UILabel alloc] initWithFrame:CGRectMake(opticalStorageview.frame.size.width - 90, progressView0.frame.origin.y + 50 - 30, 90, 20)];
    lblDataFeedBackGrid.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFeedBackGrid.textAlignment = NSTextAlignmentCenter;
    lblDataFeedBackGrid.text = @"200kWh";
    [opticalStorageview addSubview:lblDataFeedBackGrid];
    
    UILabel *lblTR0 = [[UILabel alloc] initWithFrame:CGRectMake(opticalStorageview.frame.size.width - 90, progressView0.frame.origin.y + 50 - 10, 90, 20)];
    lblTR0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTR0.textAlignment = NSTextAlignmentCenter;
    lblTR0.text = @"馈回电网";
    [opticalStorageview addSubview:lblTR0];
    
    UILabel *lblBR0 = [[UILabel alloc] initWithFrame:CGRectMake(opticalStorageview.frame.size.width - 90, progressView0.frame.origin.y + 50 + 10, 90, 20)];
    lblBR0.textColor = [UIColor whiteColor];
    lblBR0.textAlignment = NSTextAlignmentCenter;
    lblBR0.text = @"20%";
    [opticalStorageview addSubview:lblBR0];
    
    ProgressView *progressView1 = [[ProgressView alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 , 60 + 120 + 20, 100, 100)];
    progressView1.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView1.colorTop = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:51/255.0 alpha:1];
    progressView1.progress = 0.2;
    progressView1.colorButtom = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    progressView1.animationTime = 1;
    progressView1.topWidth = 5;
    progressView1.buttomWidth = 5;
    [opticalStorageview addSubview:progressView1];
    
    UIImageView *imgbuttom1 = [[UIImageView alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 118)/2.0, progressView1.frame.origin.y - 9 , 118, 118)];
    imgbuttom1.image = [UIImage imageNamed:@"光伏产出_用电消耗bg"];
    [opticalStorageview addSubview:imgbuttom1];
    
    UILabel *lblDataPowerConsumption = [[UILabel alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0, progressView1.frame.origin.y + 30, 100, 20)];
    lblDataPowerConsumption.text = @"1000kWh";
    lblDataPowerConsumption.textAlignment = NSTextAlignmentCenter;
    lblDataPowerConsumption.textColor = [UIColor whiteColor];
    [opticalStorageview addSubview:lblDataPowerConsumption];
    
    UILabel *lblPowerConsumption = [[UILabel alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0, progressView1.frame.origin.y + 50, 100, 20)];
    lblPowerConsumption.text = @"用电消耗";
    lblPowerConsumption.font = [UIFont systemFontOfSize:18];
    lblPowerConsumption.textAlignment = NSTextAlignmentCenter;
    lblPowerConsumption.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    [opticalStorageview addSubview:lblPowerConsumption];
    
    imgL1 = [[UIImageView alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 - 50, progressView1.frame.origin.y + 50 - 12.5, 13*25/18.0, 18*25/18.0)];
    if (self.frame.size.width < self.frame.size.height) {
        imgL1.frame = CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 - 120, progressView1.frame.origin.y + 50 - 12.5, 13*25/18.0, 18*25/18.0);
    }
    imgL1.image = [UIImage imageNamed:@"来自光伏_流动_work"];
    [opticalStorageview addSubview:imgL1];
    
    UILabel *lblDataFromPhotovoltaic = [[UILabel alloc] initWithFrame:CGRectMake(0, progressView1.frame.origin.y + 50 - 30, 90, 20)];
    lblDataFromPhotovoltaic.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFromPhotovoltaic.textAlignment = NSTextAlignmentCenter;
    lblDataFromPhotovoltaic.text = @"800kWh";
    [opticalStorageview addSubview:lblDataFromPhotovoltaic];
    
    UILabel *lblTL1 = [[UILabel alloc] initWithFrame:CGRectMake(0, progressView1.frame.origin.y + 50 - 10, 90, 20)];
    lblTL1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTL1.textAlignment = NSTextAlignmentCenter;
    lblTL1.text = @"来自光伏";
    [opticalStorageview addSubview:lblTL1];
    
    UILabel *lblBL1 = [[UILabel alloc] initWithFrame:CGRectMake(0, progressView1.frame.origin.y + 50 + 10, 90, 20)];
    lblBL1.textColor = [UIColor whiteColor];
    lblBL1.textAlignment = NSTextAlignmentCenter;
    lblBL1.text = @"80%";
    [opticalStorageview addSubview:lblBL1];
    
    imgR1 = [[UIImageView alloc] initWithFrame:CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 + 100 +50- 13*25/18.0, progressView1.frame.origin.y + 50 - 12.5, 13*25/18.0, 18*25/18.0)];
    if (self.frame.size.width < self.frame.size.height) {
        imgR1.frame = CGRectMake((opticalStorageview.frame.size.width - 100)/2.0 + 100 +120- 13*25/18.0, progressView1.frame.origin.y + 50 - 12.5, 13*25/18.0, 18*25/18.0);
    }
    imgR1.image = [UIImage imageNamed:@"来自电网_流动_work"];
    [opticalStorageview addSubview:imgR1];
    
    UILabel *lblDataFromGrid = [[UILabel alloc] initWithFrame:CGRectMake(opticalStorageview.frame.size.width - 90, progressView1.frame.origin.y + 50 - 30, 90, 20)];
    lblDataFromGrid.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFromGrid.textAlignment = NSTextAlignmentCenter;
    lblDataFromGrid.text = @"200kWh";
    [opticalStorageview addSubview:lblDataFromGrid];
    
    UILabel *lblTR1 = [[UILabel alloc] initWithFrame:CGRectMake(opticalStorageview.frame.size.width - 90, progressView1.frame.origin.y + 50 - 10, 90, 20)];
    lblTR1.textColor = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:51/255.0 alpha:1];
    lblTR1.textAlignment = NSTextAlignmentCenter;
    lblTR1.text = @"来自电网";
    [opticalStorageview addSubview:lblTR1];
    
    UILabel *lblBR1 = [[UILabel alloc] initWithFrame:CGRectMake(opticalStorageview.frame.size.width - 90, progressView1.frame.origin.y + 50 + 10, 90, 20)];
    lblBR1.textColor = [UIColor whiteColor];
    lblBR1.textAlignment = NSTextAlignmentCenter;
    lblBR1.text = @"20%";
    [opticalStorageview addSubview:lblBR1];
    
}


/**
 统计数据
 */
- (void)statisticalDataView{
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, statisticalDataView.frame.size.width, 44)];
    lblTitle.font = [UIFont systemFontOfSize:26];
    lblTitle.text = @"统计数据";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [statisticalDataView addSubview:lblTitle];
    
    float gap = statisticalDataView.frame.size.width/3.0;
    float width = 45;
    
    UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake((gap - width)/2.0 , 44, width, width)];
    img0.image = [UIImage imageNamed:@"统计_装机功率"];
    [statisticalDataView addSubview:img0];
    
    UILabel *lblD0 = [[UILabel alloc] initWithFrame:CGRectMake(0, img0.frame.origin.y + img0.frame.size.height , gap, 30)];
    lblD0.textAlignment = NSTextAlignmentCenter;
    lblD0.textColor = [UIColor whiteColor];
    lblD0.text = @"22.124W";
    [statisticalDataView addSubview:lblD0];
    
    UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(0, img0.frame.origin.y + img0.frame.size.height + 30, gap, 20)];
    lbl0.textAlignment = NSTextAlignmentCenter;
    lbl0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl0.text = @"装机功率";
    [statisticalDataView addSubview:lbl0];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake((gap - width)/2.0 + gap, 44, width, width)];
    img1.image = [UIImage imageNamed:@"统计_总发电"];
    [statisticalDataView addSubview:img1];
    
    UILabel *lblD1 = [[UILabel alloc] initWithFrame:CGRectMake(gap, img0.frame.origin.y + img0.frame.size.height, gap, 30)];
    lblD1.textAlignment = NSTextAlignmentCenter;
    lblD1.textColor = [UIColor whiteColor];
    lblD1.text = @"130.2kWh";
    [statisticalDataView addSubview:lblD1];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(gap, img0.frame.origin.y + img0.frame.size.height +30, gap, 20)];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl1.text = @"总发电量";
    [statisticalDataView addSubview:lbl1];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake((gap - width)/2.0 + gap*2, 44, width, width)];
    img2.image = [UIImage imageNamed:@"统计_累计收益"];
    [statisticalDataView addSubview:img2];
    
    UILabel *lblD2 = [[UILabel alloc] initWithFrame:CGRectMake(gap*2, img0.frame.origin.y + img0.frame.size.height, gap, 30)];
    lblD2.textAlignment = NSTextAlignmentCenter;
    lblD2.textColor = [UIColor whiteColor];
    lblD2.text = @"￥130.2";
    [statisticalDataView addSubview:lblD2];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(gap*2, img0.frame.origin.y + img0.frame.size.height +30, gap, 20)];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl2.text = @"累计收益";
    [statisticalDataView addSubview:lbl2];
    
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl2.frame.size.height + lbl2.frame.origin.y + 10, statisticalDataView.frame.size.width, statisticalDataView.frame.size.height - lbl2.frame.size.height - lbl2.frame.origin.y +1)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [statisticalDataView addSubview:lblBG];
    
    btnRealTime = [[UIButton alloc] initWithFrame:CGRectMake(5, lblBG.frame.origin.y + 20, 100, 27)];
    btnRealTime.layer.borderWidth = 1;
    btnRealTime.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnRealTime.layer.masksToBounds = YES;
    btnRealTime.layer.cornerRadius = 13.5;
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRealTime setTitle:@"实时" forState:UIControlStateNormal];
    btnRealTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnRealTime.titleLabel.font = [UIFont systemFontOfSize:14];
    btnRealTime.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btnRealTime addTarget:self action:@selector(btnRealTimeClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticalDataView addSubview:btnRealTime];
    
    btnYear = [[UIButton alloc] initWithFrame:CGRectMake(5+100, lblBG.frame.origin.y + 20, 100, 27)];
    btnYear.layer.borderWidth = 1;
    btnYear.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnYear.layer.masksToBounds = YES;
    btnYear.layer.cornerRadius = 13.5;
    [btnYear setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setTitle:@"年" forState:UIControlStateNormal];
    btnYear.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnYear.titleLabel.font = [UIFont systemFontOfSize:14];
    btnYear.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [btnYear addTarget:self action:@selector(btnYearClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticalDataView addSubview:btnYear];
    
    btnDay = [[UIButton alloc] initWithFrame:CGRectMake(5+50, lblBG.frame.origin.y + 20, 50, 27)];
    btnDay.layer.borderWidth = 1;
    btnDay.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnDay.layer.masksToBounds = YES;
    btnDay.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnDay setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setTitle:@"日" forState:UIControlStateNormal];
    [btnDay addTarget:self action:@selector(btnDayClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticalDataView addSubview:btnDay];
    
    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(5+100, lblBG.frame.origin.y + 20, 50, 27)];
    btnMonth.layer.borderWidth = 1;
    btnMonth.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnMonth.layer.masksToBounds = YES;
    btnMonth.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setTitle:@"月" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(btnMonthClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticalDataView addSubview:btnMonth];
    
    btnChoose = [[UIButton alloc] initWithFrame:CGRectMake(lblBG.frame.size.width -15 - 130, lblBG.frame.origin.y + 20, 130, 27)];
    btnChoose.layer.masksToBounds = YES;
    btnChoose.layer.cornerRadius = 13.5;
    btnChoose.layer.borderWidth = 1;
    btnChoose.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    [btnChoose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnChoose setTitle:@"2018" forState:UIControlStateNormal];
    [btnChoose setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
    [btnChoose addTarget:self action:@selector(btnChooseClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticalDataView addSubview:btnChoose];
    
    HomeLineChartView *chart = [[HomeLineChartView alloc] initWithFrame:CGRectMake(0,lblBG.frame.origin.y + 50, lblBG.frame.size.width, lblBG.frame.size.height - 50)];
    chart.colorTitleY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart.colorTitleX = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:1];
    chart.colorLineX = [UIColor colorWithRed:29/255.0 green:68/255.0 blue:78/255.0 alpha:0.6];
    chart.colorTextY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart.colorTextX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    
    chart.colorLine = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:1];
    chart.colorGradientTop = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0.6];
    chart.colorGradientCenter = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0.3];
    chart.colorGradientButtom = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0];

   
    chart.lblTitleY.text = @"kW";
    chart.lblTitleX.text = @"功率 ——";
    chart.lblTitleX.font = [UIFont systemFontOfSize:10];
    chart.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:0];
    chart.dataArrOfY = @[@"800",@"600",@"400",@"200",@"0"];//Y轴坐标
    chart.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];//X轴坐标
    chart.dataArrOfPoint = @[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"];
    
    [chart startDraw];
    [statisticalDataView addSubview:chart];
    
}

/**
 PV功率 电网
 */
- (void)PVPowerView0{
    
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, PVPowerView.frame.size.width, PVPowerView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [PVPowerView addSubview:lblBG];
    
    UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 40 )/2.0, 184/2.0 - 20, 40 , 40 )];
    imgC.image = [UIImage imageNamed:@"system_system"];
    [PVPowerView addSubview:imgC];
    
    UIButton *btnStatus = [[UIButton alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 129 - 20), 15, 129, 30)];
    btnStatus.layer.masksToBounds = YES;
    btnStatus.layer.cornerRadius = 15;
    btnStatus.layer.borderWidth = 1;
    btnStatus.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:80/255.0 blue:88/255.0 alpha:1] CGColor];
    [btnStatus setTitleColor:[UIColor colorWithRed:235/255.0 green:166/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    [btnStatus setTitle:@"系统状态:并网" forState:UIControlStateNormal];
    btnStatus.titleLabel.font = [UIFont systemFontOfSize:16];
    [PVPowerView addSubview:btnStatus];
    
    UIImageView *imgB = [[UIImageView alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 60 )/2.0, imgC.frame.size.height + imgC.frame.origin.y + 65 , 60, 60)];
    imgB.image = [UIImage imageNamed:@"system_bat"];
    [PVPowerView addSubview:imgB];
    
    imgBA = [[UIImageView alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 15)/2.0, (imgB.frame.origin.y - imgC.frame.size.height - imgC.frame.origin.y - 47)/2.0 + imgC.frame.size.height + imgC.frame.origin.y, 15, 47)];
    imgBA.image = [UIImage imageNamed:@"system_load_arrow1电池不做工"];
    [PVPowerView addSubview:imgBA];
    
    UILabel *lblGrid = [[UILabel alloc] initWithFrame:CGRectMake(0, imgB.frame.size.height + imgB.frame.origin.y + 10, PVPowerView.frame.size.width, 20)];
    lblGrid.textAlignment = NSTextAlignmentCenter;
    lblGrid.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGrid.font = [UIFont systemFontOfSize:16];
    lblGrid.text = @"用电功率:12.5W";
    [PVPowerView addSubview:lblGrid];
    
    UILabel *lblLoadB = [[UILabel alloc] initWithFrame:CGRectMake(0, imgB.frame.size.height + imgB.frame.origin.y + 10 + 20, PVPowerView.frame.size.width, 20)];
    lblLoadB.textAlignment = NSTextAlignmentCenter;
    lblLoadB.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblLoadB.font = [UIFont systemFontOfSize:16];
    lblLoadB.text = @"20%";
    [PVPowerView addSubview:lblLoadB];
    
    UIImageView *imgL = [[UIImageView alloc] initWithFrame:CGRectMake(57, 184/2.0 - 30, 60, 60)];
    imgL.image = [UIImage imageNamed:@"system_grid"];
    [PVPowerView addSubview:imgL];
    
    imgLA = [[UIImageView alloc] initWithFrame:CGRectMake(imgL.frame.size.width + imgL.frame.origin.x + (imgC.frame.origin.x - imgL.frame.size.width - imgL.frame.origin.x - 11)/2.0, 204/2.0 - 7.5, 11, 15)];
    imgLA.image = [UIImage imageNamed:@"system_grid_arrow1电池不做工"];
    [PVPowerView addSubview:imgLA];
    
    UILabel *lblL = [[UILabel alloc] initWithFrame:CGRectMake(20, imgL.frame.size.height + imgL.frame.origin.y + 10, 140, 20)];
    lblL.textAlignment = NSTextAlignmentCenter;
    lblL.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblL.font = [UIFont systemFontOfSize:18];
    lblL.text = @"电网功率0.56W";
    [PVPowerView addSubview:lblL];
    
    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(PVPowerView.frame.size.width - 57- 60, 184/2.0 - 30, 60, 60)];
    imgR.image = [UIImage imageNamed:@"system_solor"];
    [PVPowerView addSubview:imgR];
    
    imgRA = [[UIImageView alloc] initWithFrame:CGRectMake(imgC.frame.size.width + imgC.frame.origin.x + (imgR.frame.origin.x - imgC.frame.origin.x - imgC.frame.size.width - 11)/2.0, imgLA.frame.origin.y, 11, 15)];
    imgRA.image = [UIImage imageNamed:@"system_solor_arrow1电池不做工"];
    [PVPowerView addSubview:imgRA];
    
    UILabel *lblR = [[UILabel alloc] initWithFrame:CGRectMake(PVPowerView.frame.size.width - 140 - 20, imgR.frame.size.height + imgR.frame.origin.y + 10, 140, 20)];
    lblR.textAlignment = NSTextAlignmentCenter;
    lblR.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblR.font = [UIFont systemFontOfSize:18];
    lblR.text = @"PV功率:0.6W";
    [PVPowerView addSubview:lblR];
    
    if (t == -1) {
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeImage1) userInfo:nil repeats:YES];
    }
}


/**
 PV功率 电池
 */
- (void)PVPowerView1{
    
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, PVPowerView.frame.size.width, PVPowerView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [PVPowerView addSubview:lblBG];
    
    UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 40 )/2.0, PVPowerView.frame.size.height/2.0 - 20 , 40 , 40 )];
    imgC.image = [UIImage imageNamed:@"system_system"];
    [PVPowerView addSubview:imgC];
    
    UIButton *btnStatus = [[UIButton alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 109 - 20), 15, 109, 25)];
    btnStatus.layer.masksToBounds = YES;
    btnStatus.layer.cornerRadius = 12.5;
    btnStatus.layer.borderWidth = 1;
    btnStatus.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:80/255.0 blue:88/255.0 alpha:1] CGColor];
    [btnStatus setTitleColor:[UIColor colorWithRed:235/255.0 green:166/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    [btnStatus setTitle:@"系统状态:并网" forState:UIControlStateNormal];
    btnStatus.titleLabel.font = [UIFont systemFontOfSize:16];
    [PVPowerView addSubview:btnStatus];
    
    UILabel *lblPV = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, PVPowerView.frame.size.width - 20, 20 )];
    lblPV.textAlignment = NSTextAlignmentCenter;
    lblPV.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPV.font = [UIFont systemFontOfSize:18];
    lblPV.text = @"PV功率:0.6W";
    [PVPowerView addSubview:lblPV];
    
    UIImageView *imgT = [[UIImageView alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 60 )/2.0, 38 , 60, 60)];
    imgT.image = [UIImage imageNamed:@"system_solor"];
    [PVPowerView addSubview:imgT];
    
    imgTD = [[UIImageView alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 18)/2.0, 105, 18, 12)];
    imgTD.image = [UIImage imageNamed:@"system_solor_arrow1"];
    [PVPowerView addSubview:imgTD];
    
    imgBD = [[UIImageView alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 18)/2.0, 183, 18, 12)];
    imgBD.image = [UIImage imageNamed:@"system_grid_arrow1"];
    [PVPowerView addSubview:imgBD];
    
    UIImageView *imgB = [[UIImageView alloc] initWithFrame:CGRectMake((PVPowerView.frame.size.width - 60 )/2.0, 202 , 60, 60)];
    imgB.image = [UIImage imageNamed:@"system_grid"];
    [PVPowerView addSubview:imgB];
    
    UILabel *lblGrid = [[UILabel alloc] initWithFrame:CGRectMake(0, 262, PVPowerView.frame.size.width, 20)];
    lblGrid.textAlignment = NSTextAlignmentCenter;
    lblGrid.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGrid.font = [UIFont systemFontOfSize:16];
    lblGrid.text = @"电网功率:0.56W";
    [PVPowerView addSubview:lblGrid];
    
    UIImageView *imgL = [[UIImageView alloc] initWithFrame:CGRectMake(57, 150-30, 60, 60)];
    imgL.image = [UIImage imageNamed:@"system_bat"];
    [PVPowerView addSubview:imgL];
    
    imgLD = [[UIImageView alloc] initWithFrame:CGRectMake(150, 150 - 16/2.0, 47, 16)];
    if (self.frame.size.width < self.frame.size.height) {
        imgLD.frame = CGRectMake(180, 150 - 16/2.0, 47, 16);
    }
    imgLD.image = [UIImage imageNamed:@"system_bat_arrow0"];
    [PVPowerView addSubview:imgLD];
    
    UILabel *lblBat = [[UILabel alloc] initWithFrame:CGRectMake(30, 150+30, 120, 20)];
    lblBat.textAlignment = NSTextAlignmentCenter;
    lblBat.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblBat.font = [UIFont systemFontOfSize:16];
    lblBat.text = @"放电功率:26W";
    [PVPowerView addSubview:lblBat];
    
    UILabel *lblBatB = [[UILabel alloc] initWithFrame:CGRectMake(30, 150+30+20, 120, 20)];
    lblBatB.textAlignment = NSTextAlignmentCenter;
    lblBatB.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblBatB.font = [UIFont systemFontOfSize:16];
    lblBatB.text = @"80%";
    [PVPowerView addSubview:lblBatB];
    
    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(PVPowerView.frame.size.width - 57- 60, 150-30, 60, 60)];
    imgR.image = [UIImage imageNamed:@"system_load"];
    [PVPowerView addSubview:imgR];
    
    imgRD = [[UIImageView alloc] initWithFrame:CGRectMake(PVPowerView.frame.size.width - 150-47, 150 - 16/2.0, 47, 16)];
    if (self.frame.size.width < self.frame.size.height) {
        imgRD.frame = CGRectMake(PVPowerView.frame.size.width - 180-47, 150 - 16/2.0, 47, 16);
    }
    imgRD.image = [UIImage imageNamed:@"system_load_arrow0"];
    
    [PVPowerView addSubview:imgRD];
    
    UILabel *lblLoad = [[UILabel alloc] initWithFrame:CGRectMake(PVPowerView.frame.size.width - 120 - 30, 150+30, 120, 20)];
    lblLoad.textAlignment = NSTextAlignmentCenter;
    lblLoad.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblLoad.font = [UIFont systemFontOfSize:16];
    lblLoad.text = @"用电功率:12.5W";
    [PVPowerView addSubview:lblLoad];
    
    UILabel *lblLoadB = [[UILabel alloc] initWithFrame:CGRectMake(PVPowerView.frame.size.width - 120 - 30, 150+30+20, 120, 20)];
    lblLoadB.textAlignment = NSTextAlignmentCenter;
    lblLoadB.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblLoadB.font = [UIFont systemFontOfSize:16];
    lblLoadB.text = @"20%";
    [PVPowerView addSubview:lblLoadB];
    
    if (t == -1) {
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeImage1) userInfo:nil repeats:YES];
    }
}

/**
 设备管理
 */
- (void)deviceView{
    
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, deviceView.frame.size.width, deviceView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [deviceView addSubview:lblBG];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, deviceView.frame.size.width, 44)];
    lblTitle.font = [UIFont systemFontOfSize:20];
    lblTitle.text = @"设备管理";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [deviceView addSubview:lblTitle];
    
    UIButton *btnWhole = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, 89, 30)];
    btnWhole.layer.masksToBounds = YES;
    btnWhole.layer.cornerRadius = 15;
    btnWhole.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:142/255.0 blue:240/255.0 alpha:1] CGColor];
    btnWhole.layer.borderWidth = 1;
    [btnWhole setTitle:@"全部区域  " forState:UIControlStateNormal];
    btnWhole.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnWhole setImage:[UIImage imageNamed:@"drop"] forState:UIControlStateNormal];
    [btnWhole setTitleEdgeInsets:UIEdgeInsetsMake(0, -btnWhole.imageView.bounds.size.width, 0, btnWhole.imageView.bounds.size.width)];
    [btnWhole setImageEdgeInsets:UIEdgeInsetsMake(0, btnWhole.titleLabel.bounds.size.width, 0, -btnWhole.titleLabel.bounds.size.width)];
    [deviceView addSubview:btnWhole];
    
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(PVPowerView.frame.size.width - 89 -10 - 10, 41, 89, 28)];
    btnAdd.layer.masksToBounds = YES;
    btnAdd.layer.cornerRadius = 14;
    [btnAdd setBackgroundColor:[UIColor colorWithRed:5/255.0 green:142/255.0 blue:240/255.0 alpha:1]];
    [btnAdd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btnAdd setTitle:@"  添加" forState:UIControlStateNormal];
    [deviceView addSubview:btnAdd];
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80 , deviceView.frame.size.width - 20, 1)];
    lblLine0.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];
    [deviceView addSubview:lblLine0];
    
    UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(10 +10, 80 +25, 35, 35)];
    img0.image = [UIImage imageNamed:@"设备_逆变器"];
    [deviceView addSubview:img0];
    
    UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(69, 80, deviceView.frame.size.width - 69 - 10, 37)];
    lbl0.textAlignment = NSTextAlignmentLeft;
    lbl0.font = [UIFont systemFontOfSize:16];
    lbl0.textColor = [UIColor whiteColor];
    lbl0.text = @"A栋大楼逆变器(CRA2714003)";
    [deviceView addSubview:lbl0];
    
    UILabel *lblStatus0 = [[UILabel alloc] initWithFrame:CGRectMake(69, (35+80), deviceView.frame.size.width - 69 - 10, 20)];
    lblStatus0.textColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:144/255.0 alpha:1];
    lblStatus0.textAlignment = NSTextAlignmentLeft;
    lblStatus0.font = [UIFont systemFontOfSize:16];
    lblStatus0.text = @"状态:正常";
    [deviceView addSubview:lblStatus0];
    
    UILabel *lblPower0 = [[UILabel alloc] initWithFrame:CGRectMake(69 +130, (35+80+25), deviceView.frame.size.width - 69 - 10, 20)];
    lblPower0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPower0.textAlignment = NSTextAlignmentLeft;
    lblPower0.font = [UIFont systemFontOfSize:16];
    lblPower0.text = @"当日发电:2000W";
    [deviceView addSubview:lblPower0];
    
    UILabel *lblGenery0 = [[UILabel alloc] initWithFrame:CGRectMake(69, (35+80+25), deviceView.frame.size.width - 69 - 10, 20)];
    lblGenery0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGenery0.textAlignment = NSTextAlignmentLeft;
    lblGenery0.font = [UIFont systemFontOfSize:16];
    lblGenery0.text = @"功率:2000W";
    [deviceView addSubview:lblGenery0];
    
    UIButton *btnStatus0 = [[UIButton alloc] initWithFrame:CGRectMake(lblLine0.frame.origin.x, lblLine0.frame.origin.y, deviceView.frame.size.width, 85)];
    [btnStatus0 addTarget:self action:@selector(btnStatus0ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [deviceView addSubview:btnStatus0];
    
    UILabel *lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80 +85, deviceView.frame.size.width - 20, 1)];
    lblLine1.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];

    [deviceView addSubview:lblLine1];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10+10, 80 +25 +85*1, 35, 35)];
    img1.image = [UIImage imageNamed:@"设备_逆变器"];
    [deviceView addSubview:img1];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(69, 80+85*1, deviceView.frame.size.width - 69* - 10, 37)];
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.font = [UIFont systemFontOfSize:18];
    lbl1.textColor = [UIColor whiteColor];
    lbl1.text = @"A栋大楼逆变器(CRA2714003)";
    [deviceView addSubview:lbl1];
    
    UILabel *lblStatus1 = [[UILabel alloc] initWithFrame:CGRectMake(69, (35+80)+85*1, deviceView.frame.size.width - 69 - 10, 20)];
    lblStatus1.textColor = [UIColor colorWithRed:163/255.0 green:169/255.0 blue:171/255.0 alpha:1];
    lblStatus1.textAlignment = NSTextAlignmentLeft;
    lblStatus1.font = [UIFont systemFontOfSize:16];
    lblStatus1.text = @"状态:离线";
    [deviceView addSubview:lblStatus1];
    
    UILabel *lblPower1 = [[UILabel alloc] initWithFrame:CGRectMake(69 +130, (35+80+25)+85*1, deviceView.frame.size.width - 69 - 10, 20)];
    lblPower1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPower1.textAlignment = NSTextAlignmentLeft;
    lblPower1.font = [UIFont systemFontOfSize:16];
    lblPower1.text = @"当日发电:2000W";
    [deviceView addSubview:lblPower1];
    
    UILabel *lblGenery1 = [[UILabel alloc] initWithFrame:CGRectMake(69, (35+80+25)+85*1, deviceView.frame.size.width - 69 - 10, 20)];
    lblGenery1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGenery1.textAlignment = NSTextAlignmentLeft;
    lblGenery1.font = [UIFont systemFontOfSize:16];
    lblGenery1.text = @"功率:2000W";
    [deviceView addSubview:lblGenery1];
    
    UIButton *btnStatus1 = [[UIButton alloc] initWithFrame:CGRectMake(lblLine0.frame.origin.x, lblLine1.frame.origin.y, self.frame.size.width, 85)];
    [btnStatus1 addTarget:self action:@selector(btnStatus1ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [deviceView addSubview:btnStatus1];
    
    UILabel *lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80 +85*2, deviceView.frame.size.width - 20, 1)];
    lblLine2.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];
    [deviceView addSubview:lblLine2];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10 +10, 80 +25 +85*2, 35, 35)];
    img2.image = [UIImage imageNamed:@"设备_逆变器"];
    [deviceView addSubview:img2];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(69, 80+85*2, deviceView.frame.size.width - 69 - 10, 37)];
    lbl2.textAlignment = NSTextAlignmentLeft;
    lbl2.font = [UIFont systemFontOfSize:20];
    lbl2.textColor = [UIColor whiteColor];
    lbl2.text = @"A栋大楼逆变器(CRA2714003)";
    [deviceView addSubview:lbl2];
    
    UILabel *lblStatus2 = [[UILabel alloc] initWithFrame:CGRectMake(69, (35+80)+85*2, deviceView.frame.size.width - 69 - 10, 20)];
    lblStatus2.textColor = [UIColor colorWithRed:251/255.0 green:43/255.0 blue:78/255.0 alpha:1];
    lblStatus2.textAlignment = NSTextAlignmentLeft;
    lblStatus2.font = [UIFont systemFontOfSize:16];
    lblStatus2.text = @"状态:告警";
    [deviceView addSubview:lblStatus2];
    
    UILabel *lblPower2 = [[UILabel alloc] initWithFrame:CGRectMake(69 +130, (35+80+25)+85*2, deviceView.frame.size.width - 69 - 10, 20)];
    lblPower2.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPower2.textAlignment = NSTextAlignmentLeft;
    lblPower2.font = [UIFont systemFontOfSize:16];
    lblPower2.text = @"当日发电:2000W";
    [deviceView addSubview:lblPower2];
    
    UILabel *lblGenery2 = [[UILabel alloc] initWithFrame:CGRectMake(69, (35+80+25)+85*2, deviceView.frame.size.width - 69 - 10, 20)];
    lblGenery2.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGenery2.textAlignment = NSTextAlignmentLeft;
    lblGenery2.font = [UIFont systemFontOfSize:16];
    lblGenery2.text = @"功率:2000W";
    [deviceView addSubview:lblGenery2];
    
    UIButton *btnStatus2 = [[UIButton alloc] initWithFrame:CGRectMake(lblLine0.frame.origin.x, lblLine2.frame.origin.y, self.frame.size.width, 85)];
    [btnStatus2 addTarget:self action:@selector(btnStatus2ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [deviceView addSubview:btnStatus2];
    
    UILabel *lblLine3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80 +85*3, deviceView.frame.size.width - 20, 1)];
    lblLine2.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];
    [deviceView addSubview:lblLine3];
}

//实时、日月年 四个按钮
- (void)btnRealTimeClickAction{
    
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDay setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnDayClickAction{
    
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnMonthClickAction{
    
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnYear setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnYearClickAction{
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:3/255.0 green:46/255.0 blue:56/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)btnChooseClickAction{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        
        [self->btnChoose setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
        
    }];
}


/**
 电网系统
 */
- (void)changeImage0{
    
    if (t%2 == 1) {
        imgTD.image = [UIImage imageNamed:@"system_grid_arrow1"];
        imgBD.image = [UIImage imageNamed:@"system_solor_arrow1"];
        imgL0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
        imgL1.image = [UIImage imageNamed:@"来自光伏_流动_nowork"];
        imgR0.image = [UIImage imageNamed:@"馈回电网_流动_work"];
        imgR1.image = [UIImage imageNamed:@"来自电网_流动_nowork"];
    } else {
        imgTD.image = [UIImage imageNamed:@"system_grid_arrow2"];
        imgBD.image = [UIImage imageNamed:@"system_solor_arrow2"];
        imgL0.image = [UIImage imageNamed:@"馈回电网_流动_work"];
        imgL1.image = [UIImage imageNamed:@"来自光伏_流动_work"];
        imgR0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
        imgR1.image = [UIImage imageNamed:@"来自电网_流动_work"];
    }
    
    if (t == 0) {
        t = t + 1;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow1"];
    } else if (t == 1) {
        t = t + 1;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow2"];
    } else if (t == 2) {
        t = t+1;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow3"];
    } else if (t == 3) {
        t = t+1;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow0"];
        imgRD.image = [UIImage imageNamed:@"system_load_arrow1"];
    } else if (t == 4) {
        t = t+1;
        imgRD.image = [UIImage imageNamed:@"system_load_arrow2"];
    } else if (t == 5) {
        t = t+1;
        imgRD.image = [UIImage imageNamed:@"system_load_arrow3"];
    } else {
        imgL0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
        imgR0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
        imgL1.image = [UIImage imageNamed:@"来自光伏_流动_nowork"];
        imgR1.image = [UIImage imageNamed:@"来自电网_流动_nowork"];
        t = 0;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow0"];
        imgRD.image = [UIImage imageNamed:@"system_load_arrow0"];
    }
    
}



/**
 电池系统
 */
- (void)changeImage1{
    
    if (t%2 == 1) {
        imgTD.image = [UIImage imageNamed:@"system_grid_arrow1"];
        imgBD.image = [UIImage imageNamed:@"system_solor_arrow1"];
        imgL0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
        imgL1.image = [UIImage imageNamed:@"来自光伏_流动_nowork"];
        imgR0.image = [UIImage imageNamed:@"馈回电网_流动_work"];
        imgR1.image = [UIImage imageNamed:@"来自电网_流动_nowork"];
        imgRA.image = [UIImage imageNamed:@"system_solor_arrow1电池不做工"];
        imgLA.image = [UIImage imageNamed:@"system_grid_arrow1电池不做工"];
    } else {
        imgTD.image = [UIImage imageNamed:@"system_grid_arrow2"];
        imgBD.image = [UIImage imageNamed:@"system_solor_arrow2"];
        imgL0.image = [UIImage imageNamed:@"馈回电网_流动_work"];
        imgL1.image = [UIImage imageNamed:@"来自光伏_流动_work"];
        imgR0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
        imgR1.image = [UIImage imageNamed:@"来自电网_流动_work"];
        imgRA.image = [UIImage imageNamed:@"system_solor_arrow2电池不做工"];
        imgLA.image = [UIImage imageNamed:@"system_grid_arrow2电池不做工"];
    }
    
    if (t == 0) {
        t = t + 1;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow1"];
        imgBA.image = [UIImage imageNamed:@"system_load_arrow1电池不做工"];
    } else if (t == 1) {
        t = t + 1;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow2"];
        imgBA.image = [UIImage imageNamed:@"system_load_arrow2电池不做工"];
    } else if (t == 2) {
        t = t+1;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow3"];
        imgBA.image = [UIImage imageNamed:@"system_load_arrow3电池不做工"];
    } else if (t == 3) {
        t = t+1;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow0"];
        imgRD.image = [UIImage imageNamed:@"system_load_arrow1"];
        imgBA.image = [UIImage imageNamed:@"system_load_arrow1电池不做工"];
    } else if (t == 4) {
        t = t+1;
        imgRD.image = [UIImage imageNamed:@"system_load_arrow2"];
        imgBA.image = [UIImage imageNamed:@"system_load_arrow2电池不做工"];
    } else if (t == 5) {
        t = t+1;
        imgRD.image = [UIImage imageNamed:@"system_load_arrow3"];
        imgBA.image = [UIImage imageNamed:@"system_load_arrow3电池不做工"];
    } else {
        imgL0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
        imgR0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
        imgL1.image = [UIImage imageNamed:@"来自光伏_流动_nowork"];
        imgR1.image = [UIImage imageNamed:@"来自电网_流动_nowork"];
        t = 0;
        imgLD.image = [UIImage imageNamed:@"system_bat_arrow0"];
        imgRD.image = [UIImage imageNamed:@"system_load_arrow0"];
        imgBA.image = [UIImage imageNamed:@"system_load_arrow0电池不做工"];
    }
    
}

- (void)btnAddClickAction{
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"btnAdd"];
//    }
}

- (void)btnlblInverterClickAction{
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"InterverDetail"];
//    }
}

//逆变器详情
- (void)btnStatus0ClickAction{
//    NSLog(@"123");
//    if (!ADPV) {
//        ADPV = [[AlertDetailsPadView alloc] initWithFrame:CGRectMake((self.frame.size.width - 480)/2.0, (self.frame.size.height - 720)/2.0, 960/2.0, 1440/2.0)];
//
//    }
//    [self addSubview:[LayerView View:ADPV BackgroundColor:[UIColor colorWithRed:1/255.0 green:31/255.0 blue:40/255.0 alpha:1] BorderWidth:1 BorderColor:[UIColor colorWithRed:0/255.0 green:61/255.0 blue:75/255.0 alpha:1] Cor:10]];
}

- (void)btnStatus1ClickAction{
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"InterverDetail"];
//    }
}

- (void)btnStatus2ClickAction{
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"InterverDetail"];
//    }
}

- (void)btnStatus3ClickAction{
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"InterverDetail"];
//    }
}

#pragma mark 获取当前的控制器
- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

@end
