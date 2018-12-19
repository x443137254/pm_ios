//
//  GenerationView.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "GenerationView.h"
#import "common.h"

@interface GenerationView () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    
    UIButton *btnRealTime;
    UIButton *btnDay;
    UIButton *btnMonth;
    UIButton *btnYear;
    NSArray *listCellHeight;
    
    UIImageView *imgRD;
    UIImageView *imgLD;
    CABasicAnimation *rotationAnimation;
    int t;
    
    UIImageView *imgBD;
    UIImageView *imgTD;
    UIImageView *imgR0;
    UIImageView *imgR1;
    UIImageView *imgL0;
    UIImageView *imgL1;
    UIImageView *imgL2;
    
    /**
     光伏做工
     */
    BOOL isPhotovoltaicWork;
    
    UIView *operateViewType1;
    UIView *operateViewType2;
    
    /**
     电池做工
     */
    BOOL isBatWork;
    
    UIView *statusViewType1;
    UIView *statusViewType2;
    UIView *statusViewType3;
    
    UIView *statisticsViewType1;
    UIView *statisticsViewType2;
    
    UIView *deviceView;
    
    UIView *batView;
    
    UIImageView *cellBG;
    
}

@end

@implementation GenerationView


#pragma mark - 加载视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        isPhotovoltaicWork = YES;
        isBatWork = NO;
        [self pretreatment];
    }
    return self;
}

- (void)pretreatment{
    
    if (isPhotovoltaicWork)
    {
        if (!isBatWork)
        {
            listCellHeight = @[@"250",@"280",@"400",@"340"];
            [self loadOperatingViewType1];
            [self loadStatusViewType1];
            [self loadStatisticalViewType1];
            [self loadDeviceView];
            
        }
        else
        {
            listCellHeight = @[@"250",@"320",@"400",@"340",@"300"];
            [self loadOperatingViewType2];
            [self loadStatusViewType2];
            [self loadStatisticalViewType2];
            [self loadDeviceView];
            [self loadBatSystomViewType];
        }
    }
    else
    {
        listCellHeight = @[@"320",@"400",@"340",@"300"];
        [self loadStatusViewType3];
        [self loadStatisticalViewType1];
        [self loadDeviceView];
        [self loadBatSystomViewType];
    }
    
    if (!tableView)
    {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
    }
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 4;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    t = -1;
    [self addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return listCellHeight.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.0000000001)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i<listCellHeight.count; i++)
    {
        if (indexPath.section == i)
        {
            return [[listCellHeight objectAtIndex:i] floatValue] *ProportionX;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section != 0) {
        cellBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 50*ProportionX)];
        for (int i = 1; i< listCellHeight.count; i++) {
            if (indexPath.section == i) {
                cellBG.frame = CGRectMake(10, 0, self.frame.size.width - 20, [[listCellHeight objectAtIndex:i] floatValue] *ProportionX);
            }
        }
        cellBG.backgroundColor = [UIColor colorWithRed:0 green:31/255.0 blue:40/255.0 alpha:0.8];
        cellBG.layer.masksToBounds = YES;
        cellBG.layer.cornerRadius = 10;
        [cell addSubview:cellBG];
        
        UIImageView *cellFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 10)];
        cellFrame.image = [UIImage imageNamed:@"高光"];
        [cell addSubview:cellFrame];
    } else {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width, 38*ProportionX)];
        lblTitle.font = FontM;
        lblTitle.text = @"光储系统运行图";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:lblTitle];
        
        UIButton *btnRU = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 150, 5, 130, 30)];
        [LayerView Button:btnRU BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:RGB_HEX(0x0c4166, 1) Cor:15];
        [LayerView Button:btnRU Title:@"NRC5096002 " TitleColor:RGB_HEX(0xffffff, 1)];
        btnRU.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnRU setImage:[UIImage imageNamed:@"drop"] forState:UIControlStateNormal];
        [btnRU setTitleEdgeInsets:UIEdgeInsetsMake(0, -btnRU.imageView.frame.size.width, 0, btnRU.imageView.frame.size.width)];
        [btnRU setImageEdgeInsets:UIEdgeInsetsMake(0, btnRU.titleLabel.bounds.size.width, 0, -btnRU.titleLabel.bounds.size.width)];
        [cell addSubview:btnRU];
        
    }
    
    if (isPhotovoltaicWork)
    {
        if (!isBatWork)
        {
            if (indexPath.section == 0)
            {
                [cell addSubview:operateViewType1];
            }
            else if (indexPath.section == 1)
            {
                [cell addSubview:statusViewType1];
            }
            else if (indexPath.section ==2)
            {
                [cell addSubview:statisticsViewType1];
            }
            else if (indexPath.section ==3)
            {
                 [cell addSubview:deviceView];
//                if (t == -1)
//                {
//                    t = 0;
//                    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
//                }
            }
        }
        else
        {
            if (indexPath.section == 0)
            {
                [cell addSubview:operateViewType2];
            }
            else if (indexPath.section == 1)
            {
                [cell addSubview:statusViewType2];
            }
            else if (indexPath.section ==2)
            {
                [cell addSubview:statisticsViewType2];
            }
            else if (indexPath.section ==3)
            {
                [cell addSubview:deviceView];
            }
            else if (indexPath.section ==4)
            {
                [cell addSubview:batView];
//                if (t == -1)
//                {
//                    t = 0;
//                    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
//                }
            }
        }
        
        
    }
    else
    {
        if (indexPath.section == 0)
        {
            [cell addSubview:statusViewType3];
        }
        else if (indexPath.section == 1)
        {
            [cell addSubview:statisticsViewType1];
        }
        else if (indexPath.section ==2)
        {
            [cell addSubview:deviceView];
        }
        else if (indexPath.section ==3)
        {
            [cell addSubview:batView];
//            if (t == -1)
//            {
//                t = 0;
//                [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
//            }
        }
    }
    
    return cell;
}

#pragma mark - 加载模块视图


/**
 光储系统运行图 光伏做工 电池不做工 类型1
 */
- (void)loadOperatingViewType1{
    
    operateViewType1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[listCellHeight objectAtIndex:0] floatValue] *ProportionX)];
    
    
    ProgressView *progressView0 = [[ProgressView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 38*ProportionX, 90*ProportionX, 90*ProportionX)];
    progressView0.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView0.colorTop = [UIColor colorWithRed:37/255.0 green:206/255.0 blue:77/255.0 alpha:1];
    progressView0.progress = 0.2;
    progressView0.colorButtom = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    progressView0.animationTime = 1;
    progressView0.topWidth = 5*ProportionX;
    progressView0.buttomWidth = 5*ProportionX;
    [operateViewType1 addSubview:progressView0];
    
    UIImageView *imgbuttom0 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 105*ProportionX)/2.0, 30.5*ProportionX, 105*ProportionX, 105*ProportionX)];
    imgbuttom0.image = [UIImage imageNamed:@"光伏产出_用电消耗bg"];
    [operateViewType1 addSubview:imgbuttom0];
    
    imgL0 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 - 40*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgL0.image = [UIImage imageNamed:@"自发自用_流动_work"];
    [operateViewType1 addSubview:imgL0];
    
    UILabel *lblDataSpontaneousUse = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataSpontaneousUse.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataSpontaneousUse.textAlignment = NSTextAlignmentCenter;
    lblDataSpontaneousUse.text = @"800kWh";
    [operateViewType1 addSubview:lblDataSpontaneousUse];
    
    UILabel *lblTL0 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTL0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTL0.textAlignment = NSTextAlignmentCenter;
    lblTL0.text = @"自发自用";
    [operateViewType1 addSubview:lblTL0];
    
    UILabel *lblBL0 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblBL0.textColor = [UIColor whiteColor];
    lblBL0.textAlignment = NSTextAlignmentCenter;
    lblBL0.text = @"80%";
    [operateViewType1 addSubview:lblBL0];
    
    imgR0 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 + 90*ProportionX + 40*ProportionX - 13*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgR0.image = [UIImage imageNamed:@"馈回电网_流动_work"];
    [operateViewType1 addSubview:imgR0];
    
    UILabel *lblDataFeedBackGrid = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataFeedBackGrid.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFeedBackGrid.textAlignment = NSTextAlignmentCenter;
    lblDataFeedBackGrid.text = @"200kWh";
    [operateViewType1 addSubview:lblDataFeedBackGrid];
    
    UILabel *lblTR0 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTR0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTR0.textAlignment = NSTextAlignmentCenter;
    lblTR0.text = @"馈回电网";
    [operateViewType1 addSubview:lblTR0];
    
    UILabel *lblBR0 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblBR0.textColor = [UIColor whiteColor];
    lblBR0.textAlignment = NSTextAlignmentCenter;
    lblBR0.text = @"20%";
    [operateViewType1 addSubview:lblBR0];
    
    UILabel *lblDataPhotovoltaicOutput = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 63*ProportionX, 90*ProportionX, 20*ProportionX)];
    lblDataPhotovoltaicOutput.text = @"1000kWh";
    lblDataPhotovoltaicOutput.textAlignment = NSTextAlignmentCenter;
    lblDataPhotovoltaicOutput.textColor = [UIColor whiteColor];
    [operateViewType1 addSubview:lblDataPhotovoltaicOutput];
    
    UILabel *lblPhotovoltaicOutput = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 63*ProportionX +20*ProportionX, 90*ProportionX, 20*ProportionX)];
    lblPhotovoltaicOutput.text = @"光伏产出";
    lblPhotovoltaicOutput.font = FontS;
    lblPhotovoltaicOutput.textAlignment = NSTextAlignmentCenter;
    lblPhotovoltaicOutput.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    [operateViewType1 addSubview:lblPhotovoltaicOutput];
    
    
    ProgressView *progressView1 = [[ProgressView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 38*ProportionX +105*ProportionX, 90*ProportionX, 90*ProportionX)];
    progressView1.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView1.colorTop = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:51/255.0 alpha:1];
    progressView1.progress = 0.2;
    progressView1.colorButtom = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    progressView1.animationTime = 1;
    progressView1.topWidth = 5*ProportionX;
    progressView1.buttomWidth = 5*ProportionX;
    [operateViewType1 addSubview:progressView1];
    
    UIImageView *imgbuttom1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 105*ProportionX)/2.0, 30.5*ProportionX +105*ProportionX, 105*ProportionX, 105*ProportionX)];
    imgbuttom1.image = [UIImage imageNamed:@"光伏产出_用电消耗bg"];
    [operateViewType1 addSubview:imgbuttom1];
    
    imgL1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 - 40*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX +105*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgL1.image = [UIImage imageNamed:@"来自光伏_流动_work"];
    [operateViewType1 addSubview:imgL1];
    
    UILabel *lblDataFromPhotovoltaic = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX+105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataFromPhotovoltaic.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFromPhotovoltaic.textAlignment = NSTextAlignmentCenter;
    lblDataFromPhotovoltaic.text = @"800kWh";
    [operateViewType1 addSubview:lblDataFromPhotovoltaic];
    
    UILabel *lblTL1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX+105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTL1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTL1.textAlignment = NSTextAlignmentCenter;
    lblTL1.text = @"来自光伏";
    [operateViewType1 addSubview:lblTL1];
    
    UILabel *lblBL1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX+105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblBL1.textColor = [UIColor whiteColor];
    lblBL1.textAlignment = NSTextAlignmentCenter;
    lblBL1.text = @"80%";
    [operateViewType1 addSubview:lblBL1];
    
    imgR1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 + 90*ProportionX + 40*ProportionX - 13*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX +105*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgR1.image = [UIImage imageNamed:@"来自电网_流动_work"];
    [operateViewType1 addSubview:imgR1];
    
    UILabel *lblDataFromGrid = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataFromGrid.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFromGrid.textAlignment = NSTextAlignmentCenter;
    lblDataFromGrid.text = @"200kWh";
    [operateViewType1 addSubview:lblDataFromGrid];
    
    UILabel *lblTR1 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX +105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTR1.textColor = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:51/255.0 alpha:1];
    lblTR1.textAlignment = NSTextAlignmentCenter;
    lblTR1.text = @"来自电网";
    [operateViewType1 addSubview:lblTR1];
    
    UILabel *lblBR1 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX +105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblBR1.textColor = [UIColor whiteColor];
    lblBR1.textAlignment = NSTextAlignmentCenter;
    lblBR1.text = @"20%";
    [operateViewType1 addSubview:lblBR1];
    
    UILabel *lblDataPowerConsumption = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 63*ProportionX +105*ProportionX, 90*ProportionX, 20*ProportionX)];
    lblDataPowerConsumption.text = @"1000kWh";
    lblDataPowerConsumption.textAlignment = NSTextAlignmentCenter;
    lblDataPowerConsumption.textColor = [UIColor whiteColor];
    [operateViewType1 addSubview:lblDataPowerConsumption];
    
    UILabel *lblPowerConsumption = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 63*ProportionX +20*ProportionX+105*ProportionX, 90*ProportionX, 20*ProportionX)];
    lblPowerConsumption.text = @"用电消耗";
    lblPowerConsumption.font = FontS;
    lblPowerConsumption.textAlignment = NSTextAlignmentCenter;
    lblPowerConsumption.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    [operateViewType1 addSubview:lblPowerConsumption];
    
}

/**
 光储系统运行图 光伏做工 电池做工 类型2
 */
- (void)loadOperatingViewType2{
    operateViewType2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[listCellHeight objectAtIndex:0] floatValue] *ProportionX)];
    
    ProgressView *progressView0 = [[ProgressView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 38*ProportionX, 90*ProportionX, 90*ProportionX)];
    progressView0.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView0.colorTop = [UIColor colorWithRed:37/255.0 green:206/255.0 blue:77/255.0 alpha:1];
    progressView0.progress = 0.2;
    progressView0.colorButtom = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    progressView0.animationTime = 1;
    progressView0.topWidth = 5*ProportionX;
    progressView0.buttomWidth = 5*ProportionX;
    [operateViewType2 addSubview:progressView0];
    
    UIImageView *imgbuttom0 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 105*ProportionX)/2.0, 30.5*ProportionX, 105*ProportionX, 105*ProportionX)];
    imgbuttom0.image = [UIImage imageNamed:@"光伏产出_用电消耗bg"];
    [operateViewType2 addSubview:imgbuttom0];
    
    imgL0 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 - 40*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgL0.image = [UIImage imageNamed:@"自发自用_流动_work"];
    [operateViewType2 addSubview:imgL0];
    
    UILabel *lblDataSpontaneousUse = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataSpontaneousUse.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataSpontaneousUse.textAlignment = NSTextAlignmentCenter;
    lblDataSpontaneousUse.text = @"800kWh";
    [operateViewType2 addSubview:lblDataSpontaneousUse];
    
    UILabel *lblTL0 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTL0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTL0.textAlignment = NSTextAlignmentCenter;
    lblTL0.text = @"自发自用";
    [operateViewType2 addSubview:lblTL0];
    
    UILabel *lblBL0 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblBL0.textColor = [UIColor whiteColor];
    lblBL0.textAlignment = NSTextAlignmentCenter;
    lblBL0.text = @"80%";
    [operateViewType2 addSubview:lblBL0];
    
    imgR0 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 + 90*ProportionX + 40*ProportionX - 13*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgR0.image = [UIImage imageNamed:@"馈回电网_流动_work"];
    [operateViewType2 addSubview:imgR0];
    
    UILabel *lblDataFeedBackGrid = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataFeedBackGrid.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFeedBackGrid.textAlignment = NSTextAlignmentCenter;
    lblDataFeedBackGrid.text = @"200kWh";
    [operateViewType2 addSubview:lblDataFeedBackGrid];
    
    UILabel *lblTR0 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTR0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTR0.textAlignment = NSTextAlignmentCenter;
    lblTR0.text = @"馈回电网";
    [operateViewType2 addSubview:lblTR0];
    
    UILabel *lblBR0 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblBR0.textColor = [UIColor whiteColor];
    lblBR0.textAlignment = NSTextAlignmentCenter;
    lblBR0.text = @"20%";
    [operateViewType2 addSubview:lblBR0];
    
    UILabel *lblDataPhotovoltaicOutput = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 63*ProportionX, 90*ProportionX, 20*ProportionX)];
    lblDataPhotovoltaicOutput.text = @"1000kWh";
    lblDataPhotovoltaicOutput.textAlignment = NSTextAlignmentCenter;
    lblDataPhotovoltaicOutput.textColor = [UIColor whiteColor];
    [operateViewType2 addSubview:lblDataPhotovoltaicOutput];
    
    UILabel *lblPhotovoltaicOutput = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 63*ProportionX +20*ProportionX, 90*ProportionX, 20*ProportionX)];
    lblPhotovoltaicOutput.text = @"光伏产出";
    lblPhotovoltaicOutput.font = FontS;
    lblPhotovoltaicOutput.textAlignment = NSTextAlignmentCenter;
    lblPhotovoltaicOutput.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    [operateViewType2 addSubview:lblPhotovoltaicOutput];
    
    
    ProgressView *progressView1 = [[ProgressView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 38*ProportionX +105*ProportionX, 90*ProportionX, 90*ProportionX)];
    progressView1.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView1.colorTop = RGB_HEX(0xab60ff, 1);
    progressView1.progress = 0.3;
    progressView1.colorButtom = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    progressView1.animationTime = 1;
    progressView1.topWidth = 5*ProportionX;
    progressView1.buttomWidth = 5*ProportionX;
    [operateViewType2 addSubview:progressView1];
    
    ProgressView *progressView2 = [[ProgressView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 38*ProportionX +105*ProportionX, 90*ProportionX, 90*ProportionX)];
    progressView2.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView2.colorTop = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:51/255.0 alpha:1];
    progressView2.progress = 0.2;
    progressView2.colorButtom = [UIColor clearColor];
    progressView2.animationTime = 1;
    progressView2.topWidth = 5*ProportionX;
    progressView2.buttomWidth = 5*ProportionX;
    [operateViewType2 addSubview:progressView2];
    
    UIImageView *imgbuttom1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 105*ProportionX)/2.0, 30.5*ProportionX +105*ProportionX, 105*ProportionX, 105*ProportionX)];
    imgbuttom1.image = [UIImage imageNamed:@"光伏产出_用电消耗bg"];
    [operateViewType2 addSubview:imgbuttom1];
    
    imgL1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 - 40*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX +105*ProportionX - 32*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgL1.image = [UIImage imageNamed:@"来自光伏_流动_work"];
    [operateViewType2 addSubview:imgL1];
    
    UILabel *lblDataFromPhotovoltaic = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX+105*ProportionX - 32*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataFromPhotovoltaic.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFromPhotovoltaic.textAlignment = NSTextAlignmentCenter;
    lblDataFromPhotovoltaic.text = @"800kWh";
    [operateViewType2 addSubview:lblDataFromPhotovoltaic];
    
    UILabel *lblTL1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX+105*ProportionX - 32*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTL1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTL1.textAlignment = NSTextAlignmentCenter;
    lblTL1.text = @"来自光伏";
    [operateViewType2 addSubview:lblTL1];
    
    UILabel *lblBL1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX+105*ProportionX - 32*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblBL1.textColor = [UIColor whiteColor];
    lblBL1.textAlignment = NSTextAlignmentCenter;
    lblBL1.text = @"80%";
    [operateViewType2 addSubview:lblBL1];
    
    imgL2 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 - 40*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX +105*ProportionX + 32*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgL2.image = [UIImage imageNamed:@"来自光伏_流动_work"];
    [operateViewType2 addSubview:imgL2];
    
    UILabel *lblDataFromPhotovoltaic2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX+105*ProportionX + 32*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataFromPhotovoltaic2.textColor = RGB_HEX(0xab60ff, 1);
    lblDataFromPhotovoltaic2.textAlignment = NSTextAlignmentCenter;
    lblDataFromPhotovoltaic2.text = @"100kWh";
    [operateViewType2 addSubview:lblDataFromPhotovoltaic2];
    
    UILabel *lblTL2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX+105*ProportionX + 32*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTL2.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTL2.textAlignment = NSTextAlignmentCenter;
    lblTL2.text = @"来自光伏";
    [operateViewType2 addSubview:lblTL2];
    
    UILabel *lblBL2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX+105*ProportionX+ 32*ProportionX , 100*ProportionX, 20*ProportionX)];
    lblBL2.textColor = [UIColor whiteColor];
    lblBL2.textAlignment = NSTextAlignmentCenter;
    lblBL2.text = @"10%";
    [operateViewType2 addSubview:lblBL2];
    
    imgR1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0 + 90*ProportionX + 40*ProportionX - 13*ProportionX, 38*ProportionX + 45*ProportionX - 9*ProportionX +105*ProportionX, 13*ProportionX, 18*ProportionX)];
    imgR1.image = [UIImage imageNamed:@"来自电网_流动_work"];
    [operateViewType2 addSubview:imgR1];
    
    UILabel *lblDataFromGrid = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblDataFromGrid.textColor = [UIColor colorWithRed:235/255.0 green:166/255.0 blue:0/255.0 alpha:1];
    lblDataFromGrid.textAlignment = NSTextAlignmentCenter;
    lblDataFromGrid.text = @"200kWh";
    [operateViewType2 addSubview:lblDataFromGrid];
    
    UILabel *lblTR1 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +20*ProportionX +105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblTR1.textColor = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:51/255.0 alpha:1];
    lblTR1.textAlignment = NSTextAlignmentCenter;
    lblTR1.text = @"来自电网";
    [operateViewType2 addSubview:lblTR1];
    
    UILabel *lblBR1 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 5 - 100*ProportionX, 38*ProportionX + 45*ProportionX - 30*ProportionX +40*ProportionX +105*ProportionX, 100*ProportionX, 20*ProportionX)];
    lblBR1.textColor = [UIColor whiteColor];
    lblBR1.textAlignment = NSTextAlignmentCenter;
    lblBR1.text = @"20%";
    [operateViewType2 addSubview:lblBR1];
    
    UILabel *lblDataPowerConsumption = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 63*ProportionX +105*ProportionX, 90*ProportionX, 20*ProportionX)];
    lblDataPowerConsumption.text = @"1000kWh";
    lblDataPowerConsumption.textAlignment = NSTextAlignmentCenter;
    lblDataPowerConsumption.textColor = [UIColor whiteColor];
    [operateViewType2 addSubview:lblDataPowerConsumption];
    
    UILabel *lblPowerConsumption = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 90*ProportionX)/2.0, 63*ProportionX +20*ProportionX+105*ProportionX, 90*ProportionX, 20*ProportionX)];
    lblPowerConsumption.text = @"用电消耗";
    lblPowerConsumption.font = FontS;
    lblPowerConsumption.textAlignment = NSTextAlignmentCenter;
    lblPowerConsumption.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    [operateViewType2 addSubview:lblPowerConsumption];
}

/**
 系统状态图 光伏做工 电池不做工 类型1
 */
- (void)loadStatusViewType1{
    
    statusViewType1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[listCellHeight objectAtIndex:0] floatValue] *ProportionX)];
    
//
//    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, statusViewType1.frame.size.width, statusViewType1.frame.size.height)];
//    lblBG.layer.masksToBounds = YES;
//    lblBG.layer.cornerRadius = 5;
//    lblBG.layer.borderWidth = 1;
//    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
//    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
//    [statusViewType1 addSubview:lblBG];
//
    UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake((statusViewType1.frame.size.width - 40 )/2.0, 184/2.0 - 20, 40 , 40 )];
    imgC.image = [UIImage imageNamed:@"system_system"];
    [statusViewType1 addSubview:imgC];
    
    UIButton *btnStatus = [[UIButton alloc] initWithFrame:CGRectMake((statusViewType1.frame.size.width - 129)/2.0, 15, 129, 30)];
    btnStatus.layer.masksToBounds = YES;
    btnStatus.layer.cornerRadius = 15;
    btnStatus.layer.borderWidth = 1;
    btnStatus.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:80/255.0 blue:88/255.0 alpha:1] CGColor];
    [btnStatus setTitleColor:[UIColor colorWithRed:235/255.0 green:166/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    [btnStatus setTitle:@"系统状态:并网" forState:UIControlStateNormal];
    btnStatus.titleLabel.font = [UIFont systemFontOfSize:16];
    [statusViewType1 addSubview:btnStatus];
    
    UIImageView *imgB = [[UIImageView alloc] initWithFrame:CGRectMake((statusViewType1.frame.size.width - 60 )/2.0, imgC.frame.size.height + imgC.frame.origin.y + 65 , 60, 60)];
    imgB.image = [UIImage imageNamed:@"system_bat"];
    [statusViewType1 addSubview:imgB];
    
    imgBD = [[UIImageView alloc] initWithFrame:CGRectMake((statusViewType1.frame.size.width - 15)/2.0, (imgB.frame.origin.y - imgC.frame.size.height - imgC.frame.origin.y - 47)/2.0 + imgC.frame.size.height + imgC.frame.origin.y, 15, 47)];
    imgBD.image = [UIImage imageNamed:@"system_load_arrow1电池不做工"];
    [statusViewType1 addSubview:imgBD];
    
    UILabel *lblGrid = [[UILabel alloc] initWithFrame:CGRectMake(0, imgB.frame.size.height + imgB.frame.origin.y + 10, statusViewType1.frame.size.width, 20)];
    lblGrid.textAlignment = NSTextAlignmentCenter;
    lblGrid.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGrid.font = [UIFont systemFontOfSize:16];
    lblGrid.text = @"用电功率:12.5W";
    [statusViewType1 addSubview:lblGrid];
    
    UILabel *lblLoadB = [[UILabel alloc] initWithFrame:CGRectMake(0, imgB.frame.size.height + imgB.frame.origin.y + 10 + 20, statusViewType1.frame.size.width, 20)];
    lblLoadB.textAlignment = NSTextAlignmentCenter;
    lblLoadB.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblLoadB.font = [UIFont systemFontOfSize:16];
    lblLoadB.text = @"20%";
    [statusViewType1 addSubview:lblLoadB];
    
    UIImageView *imgL = [[UIImageView alloc] initWithFrame:CGRectMake(57, 184/2.0 - 30, 60, 60)];
    imgL.image = [UIImage imageNamed:@"system_grid"];
    [statusViewType1 addSubview:imgL];
    
    imgLD = [[UIImageView alloc] initWithFrame:CGRectMake(imgL.frame.size.width + imgL.frame.origin.x + (imgC.frame.origin.x - imgL.frame.size.width - imgL.frame.origin.x - 11)/2.0, imgC.center.y - 7.5, 11, 15)];
    imgLD.image = [UIImage imageNamed:@"system_grid_arrow1电池不做工"];
    [statusViewType1 addSubview:imgLD];
    
    UILabel *lblL = [[UILabel alloc] initWithFrame:CGRectMake(20, imgL.frame.size.height + imgL.frame.origin.y + 10, 140, 20)];
    lblL.textAlignment = NSTextAlignmentCenter;
    lblL.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblL.font = [UIFont systemFontOfSize:18];
    lblL.text = @"电网功率0.56W";
    [statusViewType1 addSubview:lblL];
    
    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(statusViewType1.frame.size.width - 57- 60, 184/2.0 - 30, 60, 60)];
    imgR.image = [UIImage imageNamed:@"system_solor"];
    [statusViewType1 addSubview:imgR];
    
    imgRD = [[UIImageView alloc] initWithFrame:CGRectMake(imgC.frame.size.width + imgC.frame.origin.x + (imgR.frame.origin.x - imgC.frame.origin.x - imgC.frame.size.width - 11)/2.0, imgC.center.y - 7.5, 11, 15)];
    imgRD.image = [UIImage imageNamed:@"system_solor_arrow1电池不做工"];
    [statusViewType1 addSubview:imgRD];
    
    UILabel *lblR = [[UILabel alloc] initWithFrame:CGRectMake(statusViewType1.frame.size.width - 140 - 20, imgR.frame.size.height + imgR.frame.origin.y + 10, 140, 20)];
    lblR.textAlignment = NSTextAlignmentCenter;
    lblR.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblR.font = [UIFont systemFontOfSize:18];
    lblR.text = @"PV功率:0.6W";
    [statusViewType1 addSubview:lblR];
}

/**
 系统状态图 光伏做工 电池做工 类型2
 */
- (void)loadStatusViewType2{
    
    statusViewType2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[listCellHeight objectAtIndex:2] floatValue] *ProportionX)];
    
    UIButton *btnStatus = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 109*ProportionX)/2.0, 15*ProportionX, 109*ProportionX, 25*ProportionX)];
    btnStatus.layer.masksToBounds = YES;
    btnStatus.layer.cornerRadius = 12.5*ProportionX;
    btnStatus.layer.borderWidth = 1;
    btnStatus.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:80/255.0 blue:88/255.0 alpha:1] CGColor];
    [btnStatus setTitleColor:[UIColor colorWithRed:235/255.0 green:166/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    [btnStatus setTitle:@"系统状态:并网" forState:UIControlStateNormal];
    btnStatus.titleLabel.font = FontS;
    [statusViewType2 addSubview:btnStatus];
    
    UILabel *lblPV = [[UILabel alloc] initWithFrame:CGRectMake(10, 50*ProportionX, self.frame.size.width - 20, 20*ProportionX)];
    lblPV.textAlignment = NSTextAlignmentCenter;
    lblPV.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPV.font = FontL;
    lblPV.text = @"PV功率:0.6W";
    [statusViewType2 addSubview:lblPV];
    
    UIImageView *imgT = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 60*ProportionX)/2.0, 70*ProportionX, 60*ProportionX, 60*ProportionX)];
    imgT.image = [UIImage imageNamed:@"system_solor"];
    [statusViewType2 addSubview:imgT];
    
    imgTD = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 24*ProportionX)/2.0, 135*ProportionX, 24*ProportionX, 16*ProportionX)];
    imgTD.image = [UIImage imageNamed:@"system_solor_arrow1"];
    [statusViewType2 addSubview:imgTD];
    
    UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 40*ProportionX)/2.0, 155*ProportionX, 40*ProportionX, 40*ProportionX)];
    imgC.image = [UIImage imageNamed:@"system_system"];
    [statusViewType2 addSubview:imgC];
    
    
    imgLD = [[UIImageView alloc] initWithFrame:CGRectMake(90*ProportionX, 175*ProportionX -12*ProportionX, 47*1.5*ProportionX, 16*1.5*ProportionX)];
    imgLD.image = [UIImage imageNamed:@"system_bat_arrow0"];
    [statusViewType2 addSubview:imgLD];
    
    imgBD = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 24*ProportionX)/2.0, 200*ProportionX, 24*ProportionX, 16*ProportionX)];
    imgBD.image = [UIImage imageNamed:@"system_grid_arrow1"];
    [statusViewType2 addSubview:imgBD];
    
    UIImageView *imgB = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 60*ProportionX)/2.0, 223*ProportionX, 60*ProportionX, 60*ProportionX)];
    imgB.image = [UIImage imageNamed:@"system_grid"];
    [statusViewType2 addSubview:imgB];
    
    UILabel *lblGrid = [[UILabel alloc] initWithFrame:CGRectMake(0, 283*ProportionX, self.frame.size.width, 20*ProportionX)];
    lblGrid.textAlignment = NSTextAlignmentCenter;
    lblGrid.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGrid.font = FontM;
    lblGrid.text = @"电网功率:0.56W";
    [statusViewType2 addSubview:lblGrid];
    
    UIImageView *imgL = [[UIImageView alloc] initWithFrame:CGRectMake(20*ProportionX, 145*ProportionX, 60*ProportionX, 60*ProportionX)];
    imgL.image = [UIImage imageNamed:@"system_bat"];
    [statusViewType2 addSubview:imgL];
    
    UILabel *lblBat = [[UILabel alloc] initWithFrame:CGRectMake(12, 205*ProportionX, 130*ProportionX, 20*ProportionX)];
    lblBat.textAlignment = NSTextAlignmentLeft;
    lblBat.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblBat.font = FontM;
    lblBat.text = @"发电功率:26W";
    [statusViewType2 addSubview:lblBat];
    
    UILabel *lblBatB = [[UILabel alloc] initWithFrame:CGRectMake(10, 205*ProportionX + 20*ProportionX, 60*ProportionX, 20*ProportionX)];
    lblBatB.textAlignment = NSTextAlignmentCenter;
    lblBatB.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblBatB.font = FontM;
    lblBatB.text = @"80%";
    [statusViewType2 addSubview:lblBatB];
    
    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 20*ProportionX - 60*ProportionX, 145*ProportionX, 60*ProportionX, 60*ProportionX)];
    imgR.image = [UIImage imageNamed:@"system_load"];
    [statusViewType2 addSubview:imgR];
    
    UILabel *lblLoad = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 130*ProportionX - 12, 205*ProportionX, 130*ProportionX, 20*ProportionX)];
    lblLoad.textAlignment = NSTextAlignmentRight;
    lblLoad.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblLoad.font = FontM;
    lblLoad.text = @"用电功率:12.5W";
    [statusViewType2 addSubview:lblLoad];
    
    UILabel *lblLoadB = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 60*ProportionX - 10, 205*ProportionX + 20*ProportionX, 60*ProportionX, 20*ProportionX)];
    lblLoadB.textAlignment = NSTextAlignmentCenter;
    lblLoadB.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblLoadB.font = FontM;
    lblLoadB.text = @"20%";
    [statusViewType2 addSubview:lblLoadB];
    
    imgRD = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-90*ProportionX-47*1.5*ProportionX, 175*ProportionX -12*ProportionX, 47*1.5*ProportionX, 16*1.5*ProportionX)];
    imgRD.image = [UIImage imageNamed:@"system_load_arrow0"];
    [statusViewType2 addSubview:imgRD];
}

/**
 系统状态图 光伏不做工 电池做工 类型3
 */
- (void)loadStatusViewType3{
    
    statusViewType3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[listCellHeight objectAtIndex:0] floatValue] *ProportionX)];
    
    UIButton *btnStatus = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 109*ProportionX)/2.0, 15*ProportionX, 109*ProportionX, 25*ProportionX)];
    btnStatus.layer.masksToBounds = YES;
    btnStatus.layer.cornerRadius = 12.5*ProportionX;
    btnStatus.layer.borderWidth = 1;
    btnStatus.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:80/255.0 blue:88/255.0 alpha:1] CGColor];
    [btnStatus setTitleColor:[UIColor colorWithRed:235/255.0 green:166/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    [btnStatus setTitle:@"系统状态:并网" forState:UIControlStateNormal];
    btnStatus.titleLabel.font = FontS;
    [statusViewType3 addSubview:btnStatus];
    
    UILabel *lblPV = [[UILabel alloc] initWithFrame:CGRectMake(10, 50*ProportionX, self.frame.size.width - 20, 20*ProportionX)];
    lblPV.textAlignment = NSTextAlignmentCenter;
    lblPV.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPV.font = FontL;
    lblPV.text = @"PV功率:0.6W";
    [statusViewType3 addSubview:lblPV];
    
    UIImageView *imgT = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 60*ProportionX)/2.0, 70*ProportionX, 60*ProportionX, 60*ProportionX)];
    imgT.image = [UIImage imageNamed:@"system_solor"];
    [statusViewType3 addSubview:imgT];
    
    imgTD = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 24*ProportionX)/2.0, 135*ProportionX, 24*ProportionX, 16*ProportionX)];
    imgTD.image = [UIImage imageNamed:@"system_solor_arrow1"];
    [statusViewType3 addSubview:imgTD];
    
    UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 40*ProportionX)/2.0, 155*ProportionX, 40*ProportionX, 40*ProportionX)];
    imgC.image = [UIImage imageNamed:@"system_system"];
    [statusViewType3 addSubview:imgC];
    
    
    imgLD = [[UIImageView alloc] initWithFrame:CGRectMake(90*ProportionX, 175*ProportionX -12*ProportionX, 47*1.5*ProportionX, 16*1.5*ProportionX)];
    imgLD.image = [UIImage imageNamed:@"system_bat_arrow0"];
    [statusViewType3 addSubview:imgLD];
    
    imgBD = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 24*ProportionX)/2.0, 200*ProportionX, 24*ProportionX, 16*ProportionX)];
    imgBD.image = [UIImage imageNamed:@"system_grid_arrow1"];
    [statusViewType3 addSubview:imgBD];
    
    UIImageView *imgB = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 60*ProportionX)/2.0, 223*ProportionX, 60*ProportionX, 60*ProportionX)];
    imgB.image = [UIImage imageNamed:@"system_grid"];
    [statusViewType3 addSubview:imgB];
    
    UILabel *lblGrid = [[UILabel alloc] initWithFrame:CGRectMake(0, 283*ProportionX, self.frame.size.width, 20*ProportionX)];
    lblGrid.textAlignment = NSTextAlignmentCenter;
    lblGrid.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGrid.font = FontM;
    lblGrid.text = @"电网功率:0.56W";
    [statusViewType3 addSubview:lblGrid];
    
    UIImageView *imgL = [[UIImageView alloc] initWithFrame:CGRectMake(20*ProportionX, 145*ProportionX, 60*ProportionX, 60*ProportionX)];
    imgL.image = [UIImage imageNamed:@"system_bat"];
    [statusViewType3 addSubview:imgL];
    
    UILabel *lblBat = [[UILabel alloc] initWithFrame:CGRectMake(12, 205*ProportionX, 130*ProportionX, 20*ProportionX)];
    lblBat.textAlignment = NSTextAlignmentLeft;
    lblBat.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblBat.font = FontM;
    lblBat.text = @"发电功率:26W";
    [statusViewType3 addSubview:lblBat];
    
    UILabel *lblBatB = [[UILabel alloc] initWithFrame:CGRectMake(10, 205*ProportionX + 20*ProportionX, 60*ProportionX, 20*ProportionX)];
    lblBatB.textAlignment = NSTextAlignmentCenter;
    lblBatB.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblBatB.font = FontM;
    lblBatB.text = @"80%";
    [statusViewType3 addSubview:lblBatB];
    
    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 20*ProportionX - 60*ProportionX, 145*ProportionX, 60*ProportionX, 60*ProportionX)];
    imgR.image = [UIImage imageNamed:@"system_load"];
    [statusViewType3 addSubview:imgR];
    
    UILabel *lblLoad = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 130*ProportionX - 12, 205*ProportionX, 130*ProportionX, 20*ProportionX)];
    lblLoad.textAlignment = NSTextAlignmentRight;
    lblLoad.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblLoad.font = FontM;
    lblLoad.text = @"用电功率:12.5W";
    [statusViewType3 addSubview:lblLoad];
    
    UILabel *lblLoadB = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 60*ProportionX - 10, 205*ProportionX + 20*ProportionX, 60*ProportionX, 20*ProportionX)];
    lblLoadB.textAlignment = NSTextAlignmentCenter;
    lblLoadB.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblLoadB.font = FontM;
    lblLoadB.text = @"20%";
    [statusViewType3 addSubview:lblLoadB];
    
    imgRD = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-90*ProportionX-47*1.5*ProportionX, 175*ProportionX -12*ProportionX, 47*1.5*ProportionX, 16*1.5*ProportionX)];
    imgRD.image = [UIImage imageNamed:@"system_load_arrow0"];
    [statusViewType3 addSubview:imgRD];

}

/**
 统计数据图 光伏做工 电池不做工(或电池做工 光伏不做工) 类型1
 */
- (void)loadStatisticalViewType1{
    float height;
    if (isPhotovoltaicWork) {
        height = [[listCellHeight objectAtIndex:2] floatValue] *ProportionX;
    } else {
       height = [[listCellHeight objectAtIndex:1] floatValue] *ProportionX;
    }

    statisticsViewType1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height)];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38*ProportionX)];
    lblTitle.font = FontL;
    lblTitle.text = @"统计数据";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [statisticsViewType1 addSubview:lblTitle];
    
    float gap = (self.frame.size.width - 20)/3.0;
    float width = 40*ProportionX;
    float x = (gap - 40*ProportionX)/2.0;
    
    UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + x + gap*0 , 49*ProportionX, width, width)];
    img0.image = [UIImage imageNamed:@"统计_装机功率"];
    [statisticsViewType1 addSubview:img0];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + x + gap*1 , 49*ProportionX, width, width)];
    img1.image = [UIImage imageNamed:@"统计_总发电"];
    [statisticsViewType1 addSubview:img1];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + x + gap*2 , 49*ProportionX, width, width)];
    img2.image = [UIImage imageNamed:@"统计_累计收益"];
    [statisticsViewType1 addSubview:img2];
    
    UILabel *lblD0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 0, 49*ProportionX + width, gap, 30*ProportionX)];
    lblD0.textAlignment = NSTextAlignmentCenter;
    lblD0.textColor = [UIColor whiteColor];
    lblD0.text = @"22.124W";
    [statisticsViewType1 addSubview:lblD0];
    
    UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 0, 49*ProportionX + width + 30*ProportionX, gap, 30*ProportionX)];
    lbl0.textAlignment = NSTextAlignmentCenter;
    lbl0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl0.text = @"装机功率";
    [statisticsViewType1 addSubview:lbl0];
    
    UILabel *lblD1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 1, 49*ProportionX + width, gap, 30*ProportionX)];
    lblD1.textAlignment = NSTextAlignmentCenter;
    lblD1.textColor = [UIColor whiteColor];
    lblD1.text = @"130.2kWh";
    [statisticsViewType1 addSubview:lblD1];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 1, 49*ProportionX + width + 30*ProportionX, gap, 30*ProportionX)];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl1.text = @"总发电量";
    [statisticsViewType1 addSubview:lbl1];
    
    UILabel *lblD2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 2, 49*ProportionX + width, gap, 30*ProportionX)];
    lblD2.textAlignment = NSTextAlignmentCenter;
    lblD2.textColor = [UIColor whiteColor];
    lblD2.text = @"￥130.2";
    [statisticsViewType1 addSubview:lblD2];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 2, 49*ProportionX + width + 30*ProportionX, gap, 30*ProportionX)];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl2.text = @"累计收益";
    [statisticsViewType1 addSubview:lbl2];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 49*ProportionX + width + 30*ProportionX +40*ProportionX , self.frame.size.width - 20, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];
    [statisticsViewType1 addSubview:lblLine];
    
    btnRealTime = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 200*ProportionX)/2.0 +50*ProportionX*0, 49*ProportionX + width + 30*ProportionX +10*ProportionX + 40*ProportionX, 100*ProportionX, 22*ProportionX)];
    btnRealTime.layer.borderWidth = 1;
    btnRealTime.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnRealTime.layer.masksToBounds = YES;
    btnRealTime.layer.cornerRadius = 11*ProportionX;
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRealTime setTitle:@"实时" forState:UIControlStateNormal];
    btnRealTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnRealTime.titleEdgeInsets = UIEdgeInsetsMake(0, 10*ProportionX, 0, 0);
    [btnRealTime addTarget:self action:@selector(btnRealTimeClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticsViewType1 addSubview:btnRealTime];
    
    btnYear = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 200*ProportionX)/2.0 +50*ProportionX*2, 49*ProportionX + width + 30*ProportionX +10*ProportionX + 40*ProportionX, 100*ProportionX, 22*ProportionX)];
    btnYear.layer.borderWidth = 1;
    btnYear.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnYear.layer.masksToBounds = YES;
    btnYear.layer.cornerRadius = 11*ProportionX;
    [btnYear setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setTitle:@"年" forState:UIControlStateNormal];
    btnYear.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnYear.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20*ProportionX);
    [btnYear addTarget:self action:@selector(btnYearClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticsViewType1 addSubview:btnYear];
    
    btnDay = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 200*ProportionX)/2.0 +50*ProportionX*1, 49*ProportionX + width + 30*ProportionX +10*ProportionX + 40*ProportionX, 50*ProportionX, 22*ProportionX)];
    btnDay.layer.borderWidth = 1;
    btnDay.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnDay.layer.masksToBounds = YES;
    [btnDay setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setTitle:@"日" forState:UIControlStateNormal];
    [btnDay addTarget:self action:@selector(btnDayClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticsViewType1 addSubview:btnDay];
    
    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 200*ProportionX)/2.0 +50*ProportionX*2, 49*ProportionX + width + 30*ProportionX +10*ProportionX + 40*ProportionX, 50*ProportionX, 22*ProportionX)];
    btnMonth.layer.borderWidth = 1;
    btnMonth.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnMonth.layer.masksToBounds = YES;
    [btnMonth setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setTitle:@"月" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(btnMonthClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticsViewType1 addSubview:btnMonth];
    
    HomeLineChartView *chart = [[HomeLineChartView alloc] initWithFrame:CGRectMake(10,btnDay.frame.origin.y + btnDay.frame.size.height + 10, self.frame.size.width - 20, 200*ProportionX)];
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
    chart.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:0];
    chart.dataArrOfY = @[@"800",@"600",@"400",@"200",@"0"];//Y轴坐标
    chart.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];//X轴坐标
    chart.dataArrOfPoint = @[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"];
    
    [chart startDraw];
    [statisticsViewType1 addSubview:chart];
}

/**
 统计数据图 光伏做工 电池做工 类型2
 */
- (void)loadStatisticalViewType2{
    
    statisticsViewType2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[listCellHeight objectAtIndex:2] floatValue] *ProportionX)];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38*ProportionX)];
    lblTitle.font = FontL;
    lblTitle.text = @"统计数据";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [statisticsViewType2 addSubview:lblTitle];
    
    float gap = (self.frame.size.width - 20)/3.0;
    float width = 40*ProportionX;
    float x = (gap - 40*ProportionX)/2.0;
    
    UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + x + gap*0 , 49*ProportionX, width, width)];
    img0.image = [UIImage imageNamed:@"统计_装机功率"];
    [statisticsViewType2 addSubview:img0];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + x + gap*1 , 49*ProportionX, width, width)];
    img1.image = [UIImage imageNamed:@"统计_总发电"];
    [statisticsViewType2 addSubview:img1];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + x + gap*2 , 49*ProportionX, width, width)];
    img2.image = [UIImage imageNamed:@"统计_累计收益"];
    [statisticsViewType2 addSubview:img2];
    
    UILabel *lblD0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 0, 49*ProportionX + width, gap, 30*ProportionX)];
    lblD0.textAlignment = NSTextAlignmentCenter;
    lblD0.textColor = [UIColor whiteColor];
    lblD0.text = @"22.124W";
    [statisticsViewType2 addSubview:lblD0];
    
    UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 0, 49*ProportionX + width + 30*ProportionX, gap, 30*ProportionX)];
    lbl0.textAlignment = NSTextAlignmentCenter;
    lbl0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl0.text = @"装机功率";
    [statisticsViewType2 addSubview:lbl0];
    
    UILabel *lblD1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 1, 49*ProportionX + width, gap, 30*ProportionX)];
    lblD1.textAlignment = NSTextAlignmentCenter;
    lblD1.textColor = [UIColor whiteColor];
    lblD1.text = @"130.2kWh";
    [statisticsViewType2 addSubview:lblD1];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 1, 49*ProportionX + width + 30*ProportionX, gap, 30*ProportionX)];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl1.text = @"总发电量";
    [statisticsViewType2 addSubview:lbl1];
    
    UILabel *lblD2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 2, 49*ProportionX + width, gap, 30*ProportionX)];
    lblD2.textAlignment = NSTextAlignmentCenter;
    lblD2.textColor = [UIColor whiteColor];
    lblD2.text = @"￥130.2";
    [statisticsViewType2 addSubview:lblD2];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + gap * 2, 49*ProportionX + width + 30*ProportionX, gap, 30*ProportionX)];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl2.text = @"累计收益";
    [statisticsViewType2 addSubview:lbl2];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 49*ProportionX + width + 30*ProportionX +40*ProportionX , self.frame.size.width - 20, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];
    [statisticsViewType2 addSubview:lblLine];
    
    
    
    btnRealTime = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 200*ProportionX)/2.0 +50*ProportionX*0, 49*ProportionX + width + 30*ProportionX +10*ProportionX + 40*ProportionX, 100*ProportionX, 22*ProportionX)];
    btnRealTime.layer.borderWidth = 1;
    btnRealTime.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnRealTime.layer.masksToBounds = YES;
    btnRealTime.layer.cornerRadius = 11*ProportionX;
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRealTime setTitle:@"实时" forState:UIControlStateNormal];
    btnRealTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnRealTime.titleEdgeInsets = UIEdgeInsetsMake(0, 10*ProportionX, 0, 0);
    [btnRealTime addTarget:self action:@selector(btnRealTimeClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticsViewType2 addSubview:btnRealTime];
    
    btnYear = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 200*ProportionX)/2.0 +50*ProportionX*2, 49*ProportionX + width + 30*ProportionX +10*ProportionX + 40*ProportionX, 100*ProportionX, 22*ProportionX)];
    btnYear.layer.borderWidth = 1;
    btnYear.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnYear.layer.masksToBounds = YES;
    btnYear.layer.cornerRadius = 11*ProportionX;
    [btnYear setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setTitle:@"年" forState:UIControlStateNormal];
    btnYear.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnYear.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20*ProportionX);
    [btnYear addTarget:self action:@selector(btnYearClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticsViewType2 addSubview:btnYear];
    
    btnDay = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 200*ProportionX)/2.0 +50*ProportionX*1, 49*ProportionX + width + 30*ProportionX +10*ProportionX + 40*ProportionX, 50*ProportionX, 22*ProportionX)];
    btnDay.layer.borderWidth = 1;
    btnDay.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnDay.layer.masksToBounds = YES;
    [btnDay setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setTitle:@"日" forState:UIControlStateNormal];
    [btnDay addTarget:self action:@selector(btnDayClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticsViewType2 addSubview:btnDay];
    
    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 200*ProportionX)/2.0 +50*ProportionX*2, 49*ProportionX + width + 30*ProportionX +10*ProportionX + 40*ProportionX, 50*ProportionX, 22*ProportionX)];
    btnMonth.layer.borderWidth = 1;
    btnMonth.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnMonth.layer.masksToBounds = YES;
    [btnMonth setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setTitle:@"月" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(btnMonthClickAction) forControlEvents:UIControlEventTouchUpInside];
    [statisticsViewType2 addSubview:btnMonth];
    
    HomeLineChartView *chart = [[HomeLineChartView alloc] initWithFrame:CGRectMake(10,btnDay.frame.origin.y + btnDay.frame.size.height + 10, self.frame.size.width - 20, 200*ProportionX)];
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
    chart.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:0];
    chart.dataArrOfY = @[@"800",@"600",@"400",@"200",@"0"];//Y轴坐标
    chart.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];//X轴坐标
    chart.dataArrOfPoint = @[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"];
    
    [chart startDraw];
    [statisticsViewType2 addSubview:chart];
}

/**
 设备管理图
 */
- (void)loadDeviceView{
    
    deviceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 340*ProportionX)];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38*ProportionX)];
    lblTitle.font = FontL;
    lblTitle.text = @"设备管理";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [deviceView addSubview:lblTitle];
    
    UIButton *btnWhole = [[UIButton alloc] initWithFrame:CGRectMake(20*ProportionX, 40*ProportionX, 89*ProportionX, 30*ProportionX)];
    btnWhole.layer.masksToBounds = YES;
    btnWhole.layer.cornerRadius = 15*ProportionX;
    btnWhole.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:142/255.0 blue:240/255.0 alpha:1] CGColor];
    btnWhole.layer.borderWidth = 1;
    [btnWhole setTitle:@"全部区域  " forState:UIControlStateNormal];
    btnWhole.titleLabel.font = FontS;
    [btnWhole setImage:[UIImage imageNamed:@"drop"] forState:UIControlStateNormal];
    [btnWhole setTitleEdgeInsets:UIEdgeInsetsMake(0, -btnWhole.imageView.bounds.size.width, 0, btnWhole.imageView.bounds.size.width)];
    [btnWhole setImageEdgeInsets:UIEdgeInsetsMake(0, btnWhole.titleLabel.bounds.size.width, 0, -btnWhole.titleLabel.bounds.size.width)];
    [deviceView addSubview:btnWhole];
    
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 89*ProportionX -10*ProportionX - 10, 41*ProportionX, 89*ProportionX, 28*ProportionX)];
    btnAdd.layer.masksToBounds = YES;
    btnAdd.layer.cornerRadius = 14*ProportionX;
    [btnAdd setBackgroundColor:[UIColor colorWithRed:5/255.0 green:142/255.0 blue:240/255.0 alpha:1]];
    [btnAdd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btnAdd setTitle:@"  添加" forState:UIControlStateNormal];
    [deviceView addSubview:btnAdd];
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80*ProportionX , self.frame.size.width - 20, 1)];
    lblLine0.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];
    [deviceView addSubview:lblLine0];
    
    UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(10*ProportionX +10, 80*ProportionX +25*ProportionX, 35*ProportionX, 35*ProportionX)];
    img0.image = [UIImage imageNamed:@"设备_逆变器"];
    [deviceView addSubview:img0];
    
    UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, 80*ProportionX, self.frame.size.width - 69*ProportionX - 10, 37*ProportionX)];
    lbl0.textAlignment = NSTextAlignmentLeft;
    lbl0.font = FontL;
    lbl0.textColor = [UIColor whiteColor];
    lbl0.text = @"A栋大楼逆变器(CRA2714003)";
    [deviceView addSubview:lbl0];
    
    UILabel *lblStatus0 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, (35+80)*ProportionX, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblStatus0.textColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:144/255.0 alpha:1];
    lblStatus0.textAlignment = NSTextAlignmentLeft;
    lblStatus0.font = FontS;
    lblStatus0.text = @"状态:正常";
    [deviceView addSubview:lblStatus0];
    
    UILabel *lblPower0 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX +130*ProportionX, (35+80+25)*ProportionX, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblPower0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPower0.textAlignment = NSTextAlignmentLeft;
    lblPower0.font = FontS;
    lblPower0.text = @"当日发电:2000W";
    [deviceView addSubview:lblPower0];
    
    UILabel *lblGenery0 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, (35+80+25)*ProportionX, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblGenery0.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGenery0.textAlignment = NSTextAlignmentLeft;
    lblGenery0.font = FontS;
    lblGenery0.text = @"功率:2000W";
    [deviceView addSubview:lblGenery0];
    
    UIButton *btnStatus0 = [[UIButton alloc] initWithFrame:CGRectMake(lblLine0.frame.origin.x, lblLine0.frame.origin.y, self.frame.size.width, 85*ProportionX)];
    [btnStatus0 addTarget:self action:@selector(btnStatus0ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [deviceView addSubview:btnStatus0];
    
    UILabel *lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80*ProportionX +85*ProportionX, self.frame.size.width - 20, 1)];
    lblLine1.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];
    [deviceView addSubview:lblLine1];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10*ProportionX +10, 80*ProportionX +25*ProportionX +85*ProportionX*1, 35*ProportionX, 35*ProportionX)];
    img1.image = [UIImage imageNamed:@"设备_逆变器"];
    [deviceView addSubview:img1];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, 80*ProportionX+85*ProportionX*1, self.frame.size.width - 69*ProportionX - 10, 37*ProportionX)];
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.font = FontL;
    lbl1.textColor = [UIColor whiteColor];
    lbl1.text = @"A栋大楼逆变器(CRA2714003)";
    [deviceView addSubview:lbl1];
    
    UILabel *lblStatus1 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, (35+80)*ProportionX+85*ProportionX*1, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblStatus1.textColor = [UIColor colorWithRed:163/255.0 green:169/255.0 blue:171/255.0 alpha:1];
    lblStatus1.textAlignment = NSTextAlignmentLeft;
    lblStatus1.font = FontS;
    lblStatus1.text = @"状态:离线";
    [deviceView addSubview:lblStatus1];
    
    UILabel *lblPower1 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX +130*ProportionX, (35+80+25)*ProportionX+85*ProportionX*1, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblPower1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPower1.textAlignment = NSTextAlignmentLeft;
    lblPower1.font = FontS;
    lblPower1.text = @"当日发电:2000W";
    [deviceView addSubview:lblPower1];
    
    UILabel *lblGenery1 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, (35+80+25)*ProportionX+85*ProportionX*1, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblGenery1.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGenery1.textAlignment = NSTextAlignmentLeft;
    lblGenery1.font = FontS;
    lblGenery1.text = @"功率:2000W";
    [deviceView addSubview:lblGenery1];
    
    UIButton *btnStatus1 = [[UIButton alloc] initWithFrame:CGRectMake(lblLine0.frame.origin.x, lblLine1.frame.origin.y, self.frame.size.width, 85*ProportionX)];
    [btnStatus1 addTarget:self action:@selector(btnStatus1ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [deviceView addSubview:btnStatus1];
    
    UILabel *lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80*ProportionX +85*ProportionX*2, self.frame.size.width - 20, 1)];
    lblLine2.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:65/255.0 alpha:1];
    [deviceView addSubview:lblLine2];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10*ProportionX +10, 80*ProportionX +25*ProportionX +85*ProportionX*2, 35*ProportionX, 35*ProportionX)];
    img2.image = [UIImage imageNamed:@"设备_逆变器"];
    [deviceView addSubview:img2];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, 80*ProportionX+85*ProportionX*2, self.frame.size.width - 69*ProportionX - 10, 37*ProportionX)];
    lbl2.textAlignment = NSTextAlignmentLeft;
    lbl2.font = FontL;
    lbl2.textColor = [UIColor whiteColor];
    lbl2.text = @"A栋大楼逆变器(CRA2714003)";
    [deviceView addSubview:lbl2];
    
    UILabel *lblStatus2 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, (35+80)*ProportionX+85*ProportionX*2, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblStatus2.textColor = [UIColor colorWithRed:251/255.0 green:43/255.0 blue:78/255.0 alpha:1];
    lblStatus2.textAlignment = NSTextAlignmentLeft;
    lblStatus2.font = FontS;
    lblStatus2.text = @"状态:告警";
    [deviceView addSubview:lblStatus2];
    
    UILabel *lblPower2 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX +130*ProportionX, (35+80+25)*ProportionX+85*ProportionX*2, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblPower2.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPower2.textAlignment = NSTextAlignmentLeft;
    lblPower2.font = FontS;
    lblPower2.text = @"当日发电:2000W";
    [deviceView addSubview:lblPower2];
    
    UILabel *lblGenery2 = [[UILabel alloc] initWithFrame:CGRectMake(69*ProportionX, (35+80+25)*ProportionX+85*ProportionX*2, self.frame.size.width - 69*ProportionX - 10, 20*ProportionX)];
    lblGenery2.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblGenery2.textAlignment = NSTextAlignmentLeft;
    lblGenery2.font = FontS;
    lblGenery2.text = @"功率:2000W";
    [deviceView addSubview:lblGenery2];
    
    UIButton *btnStatus2 = [[UIButton alloc] initWithFrame:CGRectMake(lblLine0.frame.origin.x, lblLine2.frame.origin.y, self.frame.size.width, 85*ProportionX)];
    [btnStatus2 addTarget:self action:@selector(btnStatus2ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [deviceView addSubview:btnStatus2];
    
}


/**
 电池系统
 */
- (void)loadBatSystomViewType{
    batView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
}

#pragma mark - 方法

/**
 动画方法
 */
- (void)changeImage{
    
    if (isPhotovoltaicWork) {
        if (isBatWork) {
            if (t%2 == 1) {
                imgTD.image = [UIImage imageNamed:@"system_grid_arrow1"];
                imgBD.image = [UIImage imageNamed:@"system_solor_arrow1"];
                imgL0.image = [UIImage imageNamed:@"自发自用_流动_work"];
                imgL1.image = [UIImage imageNamed:@"来自光伏_流动_nowork"];
                imgR0.image = [UIImage imageNamed:@"馈回电网_流动_work"];
                imgR1.image = [UIImage imageNamed:@"来自电网_流动_nowork"];
            } else {
                imgTD.image = [UIImage imageNamed:@"system_grid_arrow2"];
                imgBD.image = [UIImage imageNamed:@"system_solor_arrow2"];
                imgL0.image = [UIImage imageNamed:@"自发自用_流动_nowork"];
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
                imgL0.image = [UIImage imageNamed:@"自发自用_流动_nowork"];
                imgR0.image = [UIImage imageNamed:@"馈回电网_流动_nowork"];
                imgL1.image = [UIImage imageNamed:@"来自光伏_流动_nowork"];
                imgR1.image = [UIImage imageNamed:@"来自电网_流动_nowork"];
                t = 0;
                imgLD.image = [UIImage imageNamed:@"system_bat_arrow0"];
                imgRD.image = [UIImage imageNamed:@"system_load_arrow0"];
            }
        }
    }

}

//逆变器详情
- (void)btnStatus0ClickAction{
//    NSLog(@"123");
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"InterverDetail"];
    }
}

- (void)btnStatus1ClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"InterverDetail"];
    }
}

- (void)btnStatus2ClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"InterverDetail"];
    }
}

- (void)btnStatus3ClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"InterverDetail"];
    }
}

//实时、日月年 四个按钮
- (void)btnRealTimeClickAction{
    
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDay setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnDayClickAction{
    
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnMonthClickAction{
    
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnYear setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnYearClickAction{
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)btnAllAreaClickAction{
}

- (void)btnAddClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"btnAdd"];
    }
}

- (void)btnlblInverterClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"InterverDetail"];
    }
}


@end
