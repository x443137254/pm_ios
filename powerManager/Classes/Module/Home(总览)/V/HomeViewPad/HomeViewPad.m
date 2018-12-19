//
//  HomeViewPad.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/6.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import "HomeViewPad.h"
#import "common.h"
#import "TLHeader.h"

@interface HomeViewPad () <UITableViewDelegate,UITableViewDataSource> {
    CABasicAnimation *rotationAnimation;
    int t;
    
    UIButton *btnDay;
    UIButton *btnMonth;
    UIButton *btnYear;
    UIImageView *imgAL;
    UIImageView *imgRL;
    
    UIImageView *imgTotol;
    UIImageView *imgLAround;
    UIImageView *imgRAround;
    UIImageView *imgC;
    
    UIButton *btnChoose;
    
    UIView *alertView;
    UIView *totolView;
    UIView *powerView;
    UIView *deviceView;
    UIView *energyView;
    UIView *contributeView;
}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@end

@implementation HomeViewPad

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}


/**
 加载方式
 */
- (void)loadView{
    
    if (!rotationAnimation) {
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 4;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
    }
    
    if (self.frame.size.width < self.frame.size.height) {
        
        //    竖屏
        [self loadVerticalView];
    } else {
        //    横屏
        [self loadHorizontalView];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(RotaAnimate) userInfo:nil repeats:YES];
}


/**
 竖屏加载
 */
- (void)loadVerticalView{
    
    alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80/2.0)];
    totolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, 956/2.0)];
    contributeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, 340/2.0)];

    energyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, 566/2.0)];
    deviceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, 260/2.0)];
    powerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, 550/2.0)];
    
    [self setAlertView];
    [self setTotolView];
    [self setContributeView];
    [self setEnergyView];
    [self setDeviceView];
    [self setPowerView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.bounces = NO;
    [self addSubview:tableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
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
        return alertView.frame.size.height;
    } else if (indexPath.section == 1) {
        return totolView.frame.size.height;
    } else if (indexPath.section == 2) {
        return powerView.frame.size.height;
    } else if (indexPath.section == 3) {
        return deviceView.frame.size.height;
    } else if (indexPath.section == 4) {
        return powerView.frame.size.height;
    } else if (indexPath.section == 5) {
        return contributeView.frame.size.height;
    } else {
        return 100;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{\
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [cell addSubview:alertView];
    } else if (indexPath.section == 1) {
        [cell addSubview:totolView];
    } else if (indexPath.section == 2) {
        [cell addSubview:energyView];
    } else if (indexPath.section == 3) {
        [cell addSubview:deviceView];
    } else if (indexPath.section == 4) {
        [cell addSubview:powerView];
    } else if (indexPath.section == 5) {
        [cell addSubview:contributeView];
    }
    return cell;
}


/**
 横屏加载
 */
- (void)loadHorizontalView{
    if (!alertView) {
        
//        左侧
        alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 750/2.0, 80/2.0)];
        totolView = [[UIView alloc] initWithFrame:CGRectMake(0, alertView.frame.size.height + 15 + alertView.frame.origin.y, 750/2.0, 956/2.0)];
        contributeView = [[UIView alloc] initWithFrame:CGRectMake(0, totolView.frame.size.height +15 +totolView.frame.origin.y, 750/2.0, 340/2.0)];
        
//        右侧
        powerView = [[UIView alloc] initWithFrame:CGRectMake(780/2.0, 0, 1060/2.0, 566/2.0)];
        deviceView = [[UIView alloc] initWithFrame:CGRectMake(780/2.0, powerView.frame.size.height + powerView.frame.origin.y + 15, 1060/2.0, 260/2.0)];
        energyView = [[UIView alloc] initWithFrame:CGRectMake(780/2.0, deviceView.frame.size.height + deviceView.frame.origin.y + 15, 1060/2.0, 550/2.0)];
    }
    
    [self setAlertView];
    [self setTotolView];
    [self setContributeView];
    [self setPowerView];
    [self setDeviceView];
    [self setEnergyView];
    
    [self addSubview:alertView];
    [self addSubview:totolView];
    [self addSubview:contributeView];
    [self addSubview:powerView];
    [self addSubview:deviceView];
    [self addSubview:energyView];
}


#pragma mark - 分块
/**
 告警 视图块
 */
- (void)setAlertView{
    
    //告警
    UILabel *lblAlertBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, 40)];
    lblAlertBG.layer.masksToBounds = YES;
    lblAlertBG.layer.cornerRadius = 5;
    lblAlertBG.layer.borderWidth = 1;
    lblAlertBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblAlertBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [alertView addSubview:lblAlertBG];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, lblAlertBG.frame.origin.y + 5, 30, 30)];
    img.image = [UIImage imageNamed:@"告警"];
    [alertView addSubview:img];
    
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(55, lblAlertBG.frame.origin.y + 5, 100, 30)];
    lbltitle.textAlignment = NSTextAlignmentLeft;
    lbltitle.text = @"告警";
    lbltitle.textColor = [UIColor whiteColor];
    lbltitle.font = [UIFont systemFontOfSize:20];
    [alertView addSubview:lbltitle];
    
    
    UILabel *lblNum = [[UILabel alloc] initWithFrame:CGRectMake(lblAlertBG.frame.origin.x + lblAlertBG.frame.size.width - 180, 5, 20, 30)];
    lblNum.textColor = [UIColor redColor];
    lblNum.textAlignment = NSTextAlignmentRight;
    lblNum.text = @"4";
    [alertView addSubview:lblNum];
    
    UIImageView *imgMore = [[UIImageView alloc] initWithFrame:CGRectMake(lblAlertBG.frame.origin.x + lblAlertBG.frame.size.width - 160, 5, 30, 30)];
    imgMore.image = [UIImage imageNamed:@"more"];
    [alertView addSubview:imgMore];
    
    UILabel *lblLineA = [[UILabel alloc] initWithFrame:CGRectMake(lblAlertBG.frame.origin.x + lblAlertBG.frame.size.width - 120, 0, 1, 40)];
    lblLineA.backgroundColor = [UIColor colorWithRed:2/255.0 green:80/255.0 blue:90/255.0 alpha:1];
    [alertView addSubview:lblLineA];
}


/**
 累计发电 视图块
 */
- (void)setTotolView{

    imgTotol = [[UIImageView alloc] initWithFrame:CGRectMake((totolView.frame.size.width - 320)/2, 0, 320, 320)];
    imgTotol.image = [UIImage imageNamed:@"总发电_bg"];
    [totolView addSubview:imgTotol];
    [imgTotol.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    
    UILabel *lblTotol = [[UILabel alloc] initWithFrame:CGRectMake(imgTotol.frame.origin.x, imgTotol.frame.origin.y + 108, imgTotol.frame.size.width, 30)];
    lblTotol.textColor = [UIColor whiteColor];
    lblTotol.text = @"累计发电";
    lblTotol.textAlignment = NSTextAlignmentCenter;
    lblTotol.font = [UIFont systemFontOfSize:26];;
    [totolView addSubview:lblTotol];
    
    UILabel *lblDataTotol = [[UILabel alloc] initWithFrame:CGRectMake(imgTotol.frame.origin.x, imgTotol.frame.origin.y + 144, imgTotol.frame.size.width, 40)];
    lblDataTotol.textColor = [UIColor colorWithRed:8/255.0 green:250/255.0 blue:205/255.0 alpha:1];
    lblDataTotol.text = @"933010.2";
    lblDataTotol.textAlignment = NSTextAlignmentCenter;
    lblDataTotol.font = [UIFont systemFontOfSize:36];
    [totolView addSubview:lblDataTotol];
    
    UILabel *lblUnit = [[UILabel alloc] initWithFrame:CGRectMake(imgTotol.frame.origin.x, imgTotol.frame.origin.y + 191, imgTotol.frame.size.width, 30)];
    lblUnit.textColor = [UIColor whiteColor];
    lblUnit.text = @"Mwh";
    lblUnit.textAlignment = NSTextAlignmentCenter;
    lblUnit.font = [UIFont systemFontOfSize:26];
    [totolView addSubview:lblUnit];
    
    //
    float width = 45;
    float height = width;
    float gap = (totolView.frame.size.width/4.0 - width)/2.0;
    
    UIButton *btnMonthEnergy = [[UIButton alloc] initWithFrame:CGRectMake(gap + totolView.frame.size.width/4.0 *0, imgTotol.frame.size.height + imgTotol.frame.origin.y + 30, width, height)];
    [btnMonthEnergy setBackgroundImage:[UIImage imageNamed:@"当月发电"] forState:UIControlStateNormal];
    [totolView addSubview:btnMonthEnergy];
    
    UIButton *btnMonthPrice = [[UIButton alloc] initWithFrame:CGRectMake(gap + totolView.frame.size.width/4.0 *1, btnMonthEnergy.frame.origin.y, width, height)];
    [btnMonthPrice setBackgroundImage:[UIImage imageNamed:@"当月电费"] forState:UIControlStateNormal];
    [totolView addSubview:btnMonthPrice];
    
    UIButton *btnMonthGain = [[UIButton alloc] initWithFrame:CGRectMake(gap + totolView.frame.size.width/4.0 *2, btnMonthEnergy.frame.origin.y, width, height)];
    [btnMonthGain setBackgroundImage:[UIImage imageNamed:@"当月收益"] forState:UIControlStateNormal];
    [totolView addSubview:btnMonthGain];
    
    UIButton *btnMonthCoast = [[UIButton alloc] initWithFrame:CGRectMake(gap + totolView.frame.size.width/4.0 * 3, btnMonthEnergy.frame.origin.y, width, height)];
    [btnMonthCoast setBackgroundImage:[UIImage imageNamed:@"当月用电"] forState:UIControlStateNormal];
    [totolView addSubview:btnMonthCoast];
    
    //数据标题
    UILabel *lblDataMonthEnergy = [[UILabel alloc] initWithFrame:CGRectMake(totolView.frame.size.width/4.0 *0, btnMonthEnergy.frame.size.height + btnMonthEnergy.frame.origin.y + 10, totolView.frame.size.width/4.0 , 30)];
    lblDataMonthEnergy.textAlignment = NSTextAlignmentCenter;
    lblDataMonthEnergy.font = [UIFont systemFontOfSize:18];
    lblDataMonthEnergy.textColor = [UIColor whiteColor];
    lblDataMonthEnergy.text = [NSString stringWithFormat:@"%@kwh",@"130.2"];
    [totolView addSubview:lblDataMonthEnergy];
    
    UILabel *lblMonthEnergy = [[UILabel alloc] initWithFrame:CGRectMake(totolView.frame.size.width/4.0 *0, lblDataMonthEnergy.frame.size.height + lblDataMonthEnergy.frame.origin.y, totolView.frame.size.width/4.0 , 30)];
    lblMonthEnergy.textAlignment = NSTextAlignmentCenter;
    lblMonthEnergy.font = [UIFont systemFontOfSize:18];
    lblMonthEnergy.textColor = [UIColor colorWithRed:93/255.0 green:199/255.0 blue:247/255.0 alpha:1];
    lblMonthEnergy.text = @"当月发电";
    [totolView addSubview:lblMonthEnergy];
    
    UILabel *lblDataMonthPrice = [[UILabel alloc] initWithFrame:CGRectMake(totolView.frame.size.width/4.0 *1, lblDataMonthEnergy.frame.origin.y, totolView.frame.size.width/4.0 , 30)];
    lblDataMonthPrice.textAlignment = NSTextAlignmentCenter;
    lblDataMonthPrice.font = [UIFont systemFontOfSize:18];
    lblDataMonthPrice.textColor = [UIColor whiteColor];
    lblDataMonthPrice.text = [NSString stringWithFormat:@"￥%@",@"130.2"];
    [totolView addSubview:lblDataMonthPrice];
    
    UILabel *lblMonthPrince = [[UILabel alloc] initWithFrame:CGRectMake( totolView.frame.size.width/4.0 *1, lblMonthEnergy.frame.origin.y, totolView.frame.size.width/4.0 , 30)];
    lblMonthPrince.textAlignment = NSTextAlignmentCenter;
    lblMonthPrince.font = [UIFont systemFontOfSize:18];
    lblMonthPrince.textColor = [UIColor colorWithRed:93/255.0 green:199/255.0 blue:247/255.0 alpha:1];
    lblMonthPrince.text = @"当月电费";
    [totolView addSubview:lblMonthPrince];
    
    UILabel *lblDataMonthGain = [[UILabel alloc] initWithFrame:CGRectMake(totolView.frame.size.width/4.0 *2, lblDataMonthEnergy.frame.origin.y, totolView.frame.size.width/4.0 , 30)];
    lblDataMonthGain.textAlignment = NSTextAlignmentCenter;
    lblDataMonthGain.font = [UIFont systemFontOfSize:18];
    lblDataMonthGain.textColor = [UIColor whiteColor];
    lblDataMonthGain.text = [NSString stringWithFormat:@"￥%@",@"130.2"];
    [totolView addSubview:lblDataMonthGain];
    
    UILabel *lblMonthGain = [[UILabel alloc] initWithFrame:CGRectMake(totolView.frame.size.width/4.0 *2, lblMonthEnergy.frame.origin.y, totolView.frame.size.width/4.0 , 30)];
    lblMonthGain.textAlignment = NSTextAlignmentCenter;
    lblMonthGain.font = [UIFont systemFontOfSize:18];
    lblMonthGain.textColor = [UIColor colorWithRed:93/255.0 green:199/255.0 blue:247/255.0 alpha:1];
    lblMonthGain.text = @"当月收益";
    [totolView addSubview:lblMonthGain];
    
    UILabel *lblDataMonthCoast = [[UILabel alloc] initWithFrame:CGRectMake(totolView.frame.size.width/4.0 *3, lblDataMonthEnergy.frame.origin.y, totolView.frame.size.width/4.0 , 30)];
    lblDataMonthCoast.textAlignment = NSTextAlignmentCenter;
    lblDataMonthCoast.font = [UIFont systemFontOfSize:18];
    lblDataMonthCoast.textColor = [UIColor whiteColor];
    lblDataMonthCoast.text = [NSString stringWithFormat:@"%@kwh",@"130.2"];
    [totolView addSubview:lblDataMonthCoast];
    
    UILabel *lblMonthCoast = [[UILabel alloc] initWithFrame:CGRectMake(totolView.frame.size.width/4.0 *3, lblMonthEnergy.frame.origin.y, totolView.frame.size.width/4.0 , 30)];
    lblMonthCoast.textAlignment = NSTextAlignmentCenter;
    lblMonthCoast.font = [UIFont systemFontOfSize:18];
    lblMonthCoast.textColor = [UIColor colorWithRed:93/255.0 green:199/255.0 blue:247/255.0 alpha:1];
    lblMonthCoast.text = @"当月用电";
    [totolView addSubview:lblMonthCoast];

}


/**
 系统功率 视图块
 */
- (void)setPowerView{
    
    UILabel *lblPowerBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, powerView.frame.size.width, powerView.frame.size.height)];
    lblPowerBG.layer.masksToBounds = YES;
    lblPowerBG.layer.cornerRadius = 5;
    lblPowerBG.layer.borderWidth = 1;
    lblPowerBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblPowerBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [powerView addSubview:lblPowerBG];
    
    UILabel *lblTitlePower = [[UILabel alloc] initWithFrame:CGRectMake(lblPowerBG.frame.origin.x, lblPowerBG.frame.origin.y, lblPowerBG.frame.size.width, 44)];
    lblTitlePower.font = [UIFont systemFontOfSize:24];
    lblTitlePower.textColor = [UIColor whiteColor];
    lblTitlePower.textAlignment = NSTextAlignmentCenter;
    lblTitlePower.text = @"系统功率";
    [powerView addSubview:lblTitlePower];
    
    ProgressView *progressView0 = [[ProgressView alloc] initWithFrame:CGRectMake(lblPowerBG.frame.origin.x + 15, lblPowerBG.frame.origin.y + 134/2.0, 60, 60)];
    progressView0.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView0.colorTop = [UIColor colorWithRed:94/255.0 green:174/255.0 blue:255/255.0 alpha:1];
    progressView0.progress = 22.124/52.124;
    progressView0.colorButtom = [UIColor colorWithRed:4/255.0 green:67/255.0 blue:175/255.0 alpha:1];
    progressView0.animationTime = 1;
    progressView0.topWidth = 5;
    progressView0.buttomWidth = 5;
    [powerView addSubview:progressView0];
    
    UILabel *progress0 = [[UILabel alloc] initWithFrame:CGRectMake(progressView0.frame.origin.x, progressView0.frame.origin.y, progressView0.frame.size.width, progressView0.frame.size.height)];
    progress0.textAlignment= NSTextAlignmentCenter;
    progress0.textColor = [UIColor whiteColor];
    progress0.text = [NSString stringWithFormat:@"%.0f%%",progressView0.progress*100];
    [powerView addSubview:progress0];
    
    UIImageView *img00 = [[UIImageView alloc] initWithFrame:CGRectMake(progressView0.frame.origin.x + progressView0.frame.size.width + 5, progressView0.frame.origin.y + 10, 10, 10)];
    img00.backgroundColor = [UIColor colorWithRed:62/255.0 green:151/255.0 blue:1 alpha:1];
    img00.layer.masksToBounds = YES;
    img00.layer.cornerRadius = 5;
    [powerView addSubview:img00];
    
    UILabel *lbl00 = [[UILabel alloc] initWithFrame:CGRectMake(img00.frame.origin.x + img00.frame.size.width+2, progressView0.frame.origin.y + 5, 80, 20)];
    lbl00.textColor = [UIColor colorWithRed:85/255.0 green:185/255.0 blue:230/255.0 alpha:1];
    lbl00.textAlignment = NSTextAlignmentLeft;
    lbl00.text = @"运行容量";
    lbl00.font = [UIFont systemFontOfSize:18];
    [powerView addSubview:lbl00];
    
    UILabel *lblData00 = [[UILabel alloc] initWithFrame:CGRectMake(lbl00.frame.size.width + lbl00.frame.origin.x, progressView0.frame.origin.y + 5, 80, 20)];
    lblData00.textAlignment = NSTextAlignmentLeft;
    lblData00.textColor = [UIColor whiteColor];
    lblData00.text = @"22.124 W";
    lblData00.font = [UIFont systemFontOfSize:18];
    [powerView addSubview:lblData00];
    
    UIImageView *img01 = [[UIImageView alloc] initWithFrame:CGRectMake(progressView0.frame.origin.x + progressView0.frame.size.width + 5, progressView0.frame.origin.y + 40, 10, 10)];
    img01.backgroundColor = [UIColor colorWithRed:4/255.0 green:67/255.0 blue:175/255.0 alpha:1];
    img01.layer.masksToBounds = YES;
    img01.layer.cornerRadius = 5;
    [powerView addSubview:img01];
    
    UILabel *lbl01 = [[UILabel alloc] initWithFrame:CGRectMake(img01.frame.origin.x + img01.frame.size.width+2, progressView0.frame.origin.y + 35, 80, 20)];
    lbl01.textColor = [UIColor colorWithRed:85/255.0 green:185/255.0 blue:230/255.0 alpha:1];
    lbl01.textAlignment = NSTextAlignmentLeft;
    lbl01.text = @"装机容量";
    lbl01.font = [UIFont systemFontOfSize:18];
    [powerView addSubview:lbl01];
    
    UILabel * lblData01 = [[UILabel alloc] initWithFrame:CGRectMake(lbl01.frame.size.width + lbl01.frame.origin.x, progressView0.frame.origin.y + 35, 80, 20)];
    lblData01.textAlignment = NSTextAlignmentLeft;
    lblData01.textColor = [UIColor whiteColor];
    lblData01.text = @"52.124 W";
    lblData01.font = [UIFont systemFontOfSize:18];
    [powerView addSubview:lblData01];
    
    ProgressView *progressView1 = [[ProgressView alloc] initWithFrame:CGRectMake(lblPowerBG.frame.origin.x + lblPowerBG.frame.size.width/2.0, lblPowerBG.frame.origin.y + 134/2.0, 60, 60)];
    progressView1.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView1.colorTop = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:168/255.0 alpha:1];
    progressView1.progress = 22.124/52.124;
    progressView1.colorButtom = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:89/255.0 alpha:1];
    progressView1.animationTime = 1;
    progressView1.topWidth = 5;
    progressView1.buttomWidth = 5;
    [powerView addSubview:progressView1];
    
    UILabel *progress1 = [[UILabel alloc] initWithFrame:CGRectMake(progressView1.frame.origin.x, progressView1.frame.origin.y, progressView1.frame.size.width, progressView1.frame.size.height)];
    progress1.textAlignment= NSTextAlignmentCenter;
    progress1.textColor = [UIColor whiteColor];
    progress1.text = [NSString stringWithFormat:@"%.0f%%",progressView1.progress*100];
    [powerView addSubview:progress1];
    
    UIImageView *img10 = [[UIImageView alloc] initWithFrame:CGRectMake(progressView1.frame.origin.x + progressView1.frame.size.width + 5, progressView1.frame.origin.y + 10, 10, 10)];
    img10.backgroundColor = [UIColor colorWithRed:17/255.0 green:214/255.0 blue:147/255.0 alpha:1];
    img10.layer.masksToBounds = YES;
    img10.layer.cornerRadius = 5;
    [powerView addSubview:img10];
    
    UILabel *lbl10 =  [[UILabel alloc] initWithFrame:CGRectMake(img10.frame.origin.x + img10.frame.size.width+2, progressView1.frame.origin.y + 5, 80, 20)];
    lbl10.textColor = [UIColor colorWithRed:85/255.0 green:185/255.0 blue:230/255.0 alpha:1];
    lbl10.textAlignment = NSTextAlignmentLeft;
    lbl10.text = @"发电功率";
    lbl10.font = [UIFont systemFontOfSize:18];
    [powerView addSubview:lbl10];
    
    UILabel *lblData10 = [[UILabel alloc] initWithFrame:CGRectMake(lbl10.frame.size.width + lbl10.frame.origin.x, progressView1.frame.origin.y + 5, 80, 20)];
    lblData10.textAlignment = NSTextAlignmentLeft;
    lblData10.textColor = [UIColor whiteColor];
    lblData10.text = @"22.124 W";
    lblData10.font = [UIFont systemFontOfSize:18];
    [powerView addSubview:lblData10];
    //
    
    UIImageView *img11 = [[UIImageView alloc] initWithFrame:CGRectMake(progressView1.frame.origin.x + progressView1.frame.size.width + 5, progressView1.frame.origin.y + 40, 10, 10)];
    img11.backgroundColor = [UIColor colorWithRed:0/255.0 green:135/255.0 blue:89/255.0 alpha:1];
    img11.layer.masksToBounds = YES;
    img11.layer.cornerRadius = 5;
    [powerView addSubview:img11];
    
    UILabel *lbl11 = [[UILabel alloc] initWithFrame:CGRectMake(img11.frame.origin.x + img11.frame.size.width+2, progressView1.frame.origin.y + 35, 80, 20)];
    lbl11.textColor = [UIColor colorWithRed:85/255.0 green:185/255.0 blue:230/255.0 alpha:1];
    lbl11.textAlignment = NSTextAlignmentLeft;
    lbl11.text = @"总功率";
    lbl11.font =  [UIFont systemFontOfSize:18];
    [powerView addSubview:lbl11];
    
    UILabel * lblData11 = [[UILabel alloc] initWithFrame:CGRectMake(lbl11.frame.size.width + lbl11.frame.origin.x, progressView1.frame.origin.y + 35, 80, 20)];
    lblData11.textAlignment = NSTextAlignmentLeft;
    lblData11.textColor = [UIColor whiteColor];
    lblData11.text = @"52.124 W";
    lblData11.font =  [UIFont systemFontOfSize:18];
    [powerView addSubview:lblData11];
    
    
    ProgressView *progressViewC = [[ProgressView alloc] initWithFrame:CGRectMake(lblPowerBG.frame.origin.x + (lblPowerBG.frame.size.width - 60)/2.0, lblPowerBG.frame.origin.y + 318/2.0, 60, 60)];
    progressViewC.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressViewC.colorTop = [UIColor colorWithRed:255/255.0 green:193/255.0 blue:0/255.0 alpha:1];
    progressViewC.progress = 200/1000.0;
    progressViewC.colorButtom = [UIColor colorWithRed:6/255.0 green:255/255.0 blue:94/255.0 alpha:1];
    progressViewC.animationTime = 1;
    progressViewC.topWidth = 5;
    progressViewC.buttomWidth = 5;
    [powerView addSubview:progressViewC];
    
    imgC = [[UIImageView alloc] initWithFrame:CGRectMake(progressViewC.frame.origin.x + 5,progressViewC.frame.origin.y + 5, 50, 50)];
    imgC.image = [UIImage imageNamed:@"负载功率_bg"];
    [powerView addSubview:imgC];
    
    UILabel *lblPowerLoad = [[UILabel alloc] initWithFrame:CGRectMake(progressViewC.frame.origin.x -20, progressViewC.frame.origin.y + progressViewC.frame.size.height+10, progressViewC.frame.size.width + 40, 20)];
    lblPowerLoad.textColor = [UIColor whiteColor];
    lblPowerLoad.font = [UIFont systemFontOfSize:16];
    lblPowerLoad.textAlignment = NSTextAlignmentCenter;
    lblPowerLoad.textColor = [UIColor colorWithRed:0 green:215/255.0 blue:253/255.0 alpha:1];
    lblPowerLoad.text = @"1000W";
    [powerView addSubview:lblPowerLoad];
    
    UILabel *lblTPowerLoad = [[UILabel alloc] initWithFrame:CGRectMake(progressViewC.frame.origin.x -20, progressViewC.frame.origin.y + progressViewC.frame.size.height+30, progressViewC.frame.size.width + 40, 20)];
    lblTPowerLoad.textColor = [UIColor whiteColor];
    lblTPowerLoad.font = [UIFont systemFontOfSize:16];
    lblTPowerLoad.textAlignment = NSTextAlignmentCenter;
    lblTPowerLoad.textColor = [UIColor colorWithRed:90/255.0 green:190/255.0 blue:242/255.0 alpha:1];
    lblTPowerLoad.text = @"负载功率";
    [powerView addSubview:lblTPowerLoad];
    
    imgAL = [[UIImageView alloc] initWithFrame:CGRectMake(imgC.frame.origin.x - 54-30, imgC.frame.origin.y + (imgC.frame.size.height - 16.5)/2.0, 54, 16.5)];
    imgAL.image = [UIImage imageNamed:@"光伏功率_流动_work1"];
    [powerView addSubview:imgAL];
    [imgC.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    
    imgLAround = [[UIImageView alloc] initWithFrame:CGRectMake(imgC.frame.origin.x - 109 - 60 , imgC.frame.origin.y-5, 60, 60)];
    imgLAround.image = [UIImage imageNamed:@"光伏功率_around"];
    [powerView addSubview:imgLAround];
    [imgLAround.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    
    UIImageView *imgL = [[UIImageView alloc] initWithFrame:CGRectMake(imgC.frame.origin.x - 109 - 55 , imgC.frame.origin.y, 50, 50)];
    imgL.image = [UIImage imageNamed:@"光伏功率_work"];
    [powerView addSubview:imgL];
    
    UILabel *lblPowerPhotovoltaic = [[UILabel alloc] initWithFrame:CGRectMake(imgLAround.frame.origin.x -20, imgLAround.frame.origin.y + imgLAround.frame.size.height+10, imgLAround.frame.size.width + 40, 20)];
    lblPowerPhotovoltaic.textColor = [UIColor whiteColor];
    lblPowerPhotovoltaic.font = [UIFont systemFontOfSize:16];
    lblPowerPhotovoltaic.textAlignment = NSTextAlignmentCenter;
    lblPowerPhotovoltaic.textColor = [UIColor colorWithRed:6/255.0 green:255/255.0 blue:95/255.0 alpha:1];
    lblPowerPhotovoltaic.text = @"800W";
    [powerView addSubview:lblPowerPhotovoltaic];
    
    UILabel *lblTPowerPhotovoltaic = [[UILabel alloc] initWithFrame:CGRectMake(imgLAround.frame.origin.x -20, imgLAround.frame.origin.y + imgLAround.frame.size.height+30, imgLAround.frame.size.width + 40, 20)];
    lblTPowerPhotovoltaic.textColor = [UIColor whiteColor];
    lblTPowerPhotovoltaic.font = [UIFont systemFontOfSize:16];
    lblTPowerPhotovoltaic.textAlignment = NSTextAlignmentCenter;
    lblTPowerPhotovoltaic.textColor = [UIColor colorWithRed:90/255.0 green:190/255.0 blue:242/255.0 alpha:1];
    lblTPowerPhotovoltaic.text = @"光伏功率";
    [powerView addSubview:lblTPowerPhotovoltaic];
    
    imgRL = [[UIImageView alloc] initWithFrame:CGRectMake(imgC.frame.origin.x +imgC.frame.size.width +30, imgC.frame.origin.y + (imgC.frame.size.height - 16.5)/2.0, 54, 16.5)];
    imgRL.image = [UIImage imageNamed:@"电网功率_流动_work1"];
    [powerView addSubview:imgRL];
    
    imgRAround = [[UIImageView alloc] initWithFrame:CGRectMake(imgC.frame.origin.x +imgC.frame.size.width +109, imgC.frame.origin.y-5, 60, 60)];
    imgRAround.image = [UIImage imageNamed:@"电网功率_around"];
    [powerView addSubview:imgRAround];
    [imgRAround.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    
    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(imgC.frame.origin.x +imgC.frame.size.width +109+5, imgC.frame.origin.y, 50, 50)];
    imgR.image = [UIImage imageNamed:@"电网功率_work"];
    [powerView addSubview:imgR];
    
    UILabel *lblPowerGrid = [[UILabel alloc] initWithFrame:CGRectMake(imgRAround.frame.origin.x -20, imgRAround.frame.origin.y + imgLAround.frame.size.height+10, imgLAround.frame.size.width + 40, 20)];
    lblPowerGrid.textColor = [UIColor whiteColor];
    lblPowerGrid.font = [UIFont systemFontOfSize:16];
    lblPowerGrid.textAlignment = NSTextAlignmentCenter;
    lblPowerGrid.textColor = [UIColor colorWithRed:255/255.0 green:202/255.0 blue:0/255.0 alpha:1];
    lblPowerGrid.text = @"200W";
    [powerView addSubview:lblPowerGrid];
    
    UILabel *lblTPowerGrid = [[UILabel alloc] initWithFrame:CGRectMake(imgRAround.frame.origin.x -20, imgRAround.frame.origin.y + imgLAround.frame.size.height+30, imgLAround.frame.size.width + 40, 20)];
    lblTPowerGrid.textColor = [UIColor whiteColor];
    lblTPowerGrid.font = [UIFont systemFontOfSize:16];
    lblTPowerGrid.textAlignment = NSTextAlignmentCenter;
    lblTPowerGrid.textColor = [UIColor colorWithRed:90/255.0 green:190/255.0 blue:242/255.0 alpha:1];
    lblTPowerGrid.text = @"电网功率";
    [powerView addSubview:lblTPowerGrid];

}


/**
 当前设备 视图块
 */
- (void)setDeviceView{
    
    UILabel *lblDeviceBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, deviceView.frame.size.width, deviceView.frame.size.height)];
    lblDeviceBG.layer.masksToBounds = YES;
    lblDeviceBG.layer.cornerRadius = 5;
    lblDeviceBG.layer.borderWidth = 1;
    lblDeviceBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblDeviceBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [deviceView addSubview:lblDeviceBG];
    
    UILabel *lblTitleDevice = [[UILabel alloc] initWithFrame:CGRectMake(lblDeviceBG.frame.origin.x, lblDeviceBG.frame.origin.y, lblDeviceBG.frame.size.width, 44)];
    lblTitleDevice.font = [UIFont systemFontOfSize:24];
    lblTitleDevice.textColor = [UIColor whiteColor];
    lblTitleDevice.textAlignment = NSTextAlignmentCenter;
    lblTitleDevice.text = @"当前设备";
    [deviceView addSubview:lblTitleDevice];
    
    
    float width = lblDeviceBG.frame.size.width/4.0;
    //
    UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(10+lblDeviceBG.frame.origin.x , lblDeviceBG.frame.origin.y + 75, 40, 40)];
    [btn0 setBackgroundImage:[UIImage imageNamed:@"当前设备_逆变器"] forState:UIControlStateNormal];
    [deviceView addSubview:btn0];
    
    UILabel *lblNum0 = [[UILabel alloc] initWithFrame:CGRectMake(btn0.frame.size.width + btn0.frame.origin.x + 10, lblDeviceBG.frame.origin.y + 75, width - btn0.frame.size.width - 5, 20)];
    lblNum0.textAlignment = NSTextAlignmentLeft;
    lblNum0.font = [UIFont systemFontOfSize:20];
    lblNum0.text = @"62";
    lblNum0.textColor = [UIColor whiteColor];
    [deviceView addSubview:lblNum0];
    
    UILabel *lblName0 = [[UILabel alloc] initWithFrame:CGRectMake(btn0.frame.size.width + btn0.frame.origin.x + 10, lblDeviceBG.frame.origin.y + 75 + 20, width - btn0.frame.size.width - 5, 20)];
    lblName0.textAlignment = NSTextAlignmentLeft;
    lblName0.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:232/255.0 alpha:1];
    lblName0.font = [UIFont systemFontOfSize:18];
    lblName0.text = @"逆变器";
    [deviceView addSubview:lblName0];
    //
    UILabel *line0 = [[UILabel alloc] initWithFrame:CGRectMake(lblDeviceBG.frame.origin.x + width, lblDeviceBG.frame.origin.y + 75, 1, 40)];
    line0.backgroundColor = [UIColor colorWithRed:28/255.0 green:57/255.0 blue:66/255.0 alpha:1];
    [deviceView addSubview:line0];
    //
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10+lblDeviceBG.frame.origin.x +width, lblDeviceBG.frame.origin.y + 75, 40, 40)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"当前设备_电表"] forState:UIControlStateNormal];
    [deviceView addSubview:btn1];
    
    UILabel *lblNum1 = [[UILabel alloc] initWithFrame:CGRectMake(btn0.frame.size.width + btn0.frame.origin.x + 10 + width, lblDeviceBG.frame.origin.y + 75, width - btn0.frame.size.width - 5, 20)];
    lblNum1.textAlignment = NSTextAlignmentLeft;
    lblNum1.font = [UIFont systemFontOfSize:20];
    lblNum1.text = @"81";
    lblNum1.textColor = [UIColor whiteColor];
    [deviceView addSubview:lblNum1];
    UILabel *lblName1 = [[UILabel alloc] initWithFrame:CGRectMake(btn0.frame.size.width + btn0.frame.origin.x + 10 + width, lblDeviceBG.frame.origin.y + 75 + 20, width - btn0.frame.size.width - 5, 20)];
    lblName1.textAlignment = NSTextAlignmentLeft;
    lblName1.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:232/255.0 alpha:1];
    lblName1.font = [UIFont systemFontOfSize:18];
    lblName1.text = @"电表";
    [deviceView addSubview:lblName1];
    //
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(lblDeviceBG.frame.origin.x + width*2, lblDeviceBG.frame.origin.y + 75, 1, 40)];
    line1.backgroundColor = [UIColor colorWithRed:28/255.0 green:57/255.0 blue:66/255.0 alpha:1];
    [deviceView addSubview:line1];
    //
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(10+lblDeviceBG.frame.origin.x +width*2, lblDeviceBG.frame.origin.y + 75, 40, 40)];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"当前设备_空调"] forState:UIControlStateNormal];
    [deviceView addSubview:btn2];
    
    UILabel *lblNum2 = [[UILabel alloc] initWithFrame:CGRectMake(btn0.frame.size.width + btn0.frame.origin.x + 10 + width*2, lblDeviceBG.frame.origin.y + 75, width - btn0.frame.size.width - 5, 20)];
    lblNum2.textAlignment = NSTextAlignmentLeft;
    lblNum2.font = [UIFont systemFontOfSize:20];
    lblNum2.text = @"25";
    lblNum2.textColor = [UIColor whiteColor];
    [deviceView addSubview:lblNum2];
    
    UILabel *lblName2 =  [[UILabel alloc] initWithFrame:CGRectMake(btn0.frame.size.width + btn0.frame.origin.x + 10 + width*2, lblDeviceBG.frame.origin.y + 75 + 20, width - btn0.frame.size.width - 5, 20)];
    lblName2.textAlignment = NSTextAlignmentLeft;
    lblName2.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:232/255.0 alpha:1];
    lblName2.font = [UIFont systemFontOfSize:18];
    lblName2.text = @"空调";
    [deviceView addSubview:lblName2];
    //
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(lblDeviceBG.frame.origin.x + width*3, lblDeviceBG.frame.origin.y + 75, 1, 40)];
    line2.backgroundColor = [UIColor colorWithRed:28/255.0 green:57/255.0 blue:66/255.0 alpha:1];
    [deviceView addSubview:line2];
    //
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(10+lblDeviceBG.frame.origin.x +width*3, lblDeviceBG.frame.origin.y + 75, 40, 40)];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"当前设备_插座"] forState:UIControlStateNormal];
    [deviceView addSubview:btn3];
    
    UILabel *lblNum3 = [[UILabel alloc] initWithFrame:CGRectMake(btn0.frame.size.width + btn0.frame.origin.x + 10 + width*3, lblDeviceBG.frame.origin.y + 75, width - btn0.frame.size.width - 5, 20)];
    lblNum3.textAlignment = NSTextAlignmentLeft;
    lblNum3.font = [UIFont systemFontOfSize:20];
    lblNum3.text = @"307";
    lblNum3.textColor = [UIColor whiteColor];
    [deviceView addSubview:lblNum3];
    
    UILabel *lblName3 = [[UILabel alloc] initWithFrame:CGRectMake(btn0.frame.size.width + btn0.frame.origin.x + 10 + width*3, lblDeviceBG.frame.origin.y + 75 + 20, width - btn0.frame.size.width - 5, 20)];
    lblName3.textAlignment = NSTextAlignmentLeft;
    lblName3.textColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:232/255.0 alpha:1];
    lblName3.font = [UIFont systemFontOfSize:18];
    lblName3.text = @"插座";
    [deviceView addSubview:lblName3];
}


/**
 能源趋势 视图块
 */
- (void)setEnergyView{
    
    UILabel *lblTrendBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, energyView.frame.size.width, energyView.frame.size.height)];
    lblTrendBG.layer.masksToBounds = YES;
    lblTrendBG.layer.cornerRadius = 5;
    lblTrendBG.layer.borderWidth = 1;
    lblTrendBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblTrendBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [energyView addSubview:lblTrendBG];
    
    UILabel *lblTitleTrend = [[UILabel alloc] initWithFrame:CGRectMake(lblTrendBG.frame.origin.x, lblTrendBG.frame.origin.y, lblTrendBG.frame.size.width, 44)];
    lblTitleTrend.font = [UIFont systemFontOfSize:24];
    lblTitleTrend.textColor = [UIColor whiteColor];
    lblTitleTrend.textAlignment = NSTextAlignmentCenter;
    lblTitleTrend.text = @"能源趋势";
    [energyView addSubview:lblTitleTrend];
    
    btnDay = [[UIButton alloc] initWithFrame:CGRectMake(lblTrendBG.frame.origin.x + 15, lblTrendBG.frame.origin.y + 62, 100, 27)];
    btnDay.layer.borderWidth = 1;
    btnDay.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnDay.layer.masksToBounds = YES;
    btnDay.layer.cornerRadius = 13.5;
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setTitle:@"日" forState:UIControlStateNormal];
    btnDay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnDay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [btnDay addTarget:self action:@selector(btnDayClickAction) forControlEvents:UIControlEventTouchUpInside];
    [energyView addSubview:btnDay];
    
    btnYear = [[UIButton alloc] initWithFrame:CGRectMake(lblTrendBG.frame.origin.x +15+ 50, lblTrendBG.frame.origin.y + 62, 100, 27)];
    btnYear.layer.borderWidth = 1;
    btnYear.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnYear.layer.masksToBounds = YES;
    btnYear.layer.cornerRadius = 13.5;
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setTitle:@"年" forState:UIControlStateNormal];
    btnYear.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnYear.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [btnYear addTarget:self action:@selector(btnYearClickAction) forControlEvents:UIControlEventTouchUpInside];
    [energyView addSubview:btnYear];
    
    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(lblTrendBG.frame.origin.x +15 +50, lblTrendBG.frame.origin.y + 62, 50, 27)];
    btnMonth.layer.borderWidth = 1;
    [btnMonth setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    btnMonth.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnMonth.layer.masksToBounds = YES;
    [btnMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMonth setTitle:@"月" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(btnMonthClickAction) forControlEvents:UIControlEventTouchUpInside];
    [energyView addSubview:btnMonth];
    
    btnChoose = [[UIButton alloc] initWithFrame:CGRectMake(lblTrendBG.frame.origin.x + lblTrendBG.frame.size.width -15 - 130, lblTrendBG.frame.origin.y + 62, 130, 27)];
    btnChoose.layer.masksToBounds = YES;
    btnChoose.layer.cornerRadius = 13.5;
    btnChoose.layer.borderWidth = 1;
    btnChoose.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    [btnChoose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnChoose setTitle:@"2018" forState:UIControlStateNormal];
    [btnChoose addTarget:self action:@selector(btnChooseClickAction) forControlEvents:UIControlEventTouchUpInside];
    [energyView addSubview:btnChoose];
    
    NSArray *tempDataArrOfY2 = @[@[@"10",@"270",@"300",@"320",@"410",@"420",@"420",@"310",@"350",@"450"],@[@"20",@"290",@"400",@"420",@"510",@"520",@"520",@"410",@"550",@"550"],@[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"],@[@"30",@"470",@"550",@"560",@"630",@"640",@"660",@"620",@"710",@"740"]];
    
    LRSChartView *sChart = [[LRSChartView alloc]initWithFrame:CGRectMake(0, btnDay.frame.origin.y + btnDay.frame.size.height + 30, energyView.bounds.size.width, energyView.frame.size.height -btnDay.frame.origin.y - btnDay.frame.size.height - 30 - 30)];
    
    //是否可以浮动
    sChart.isFloating = YES;
    //设置X轴坐标字体大小
    sChart.x_Font = [UIFont systemFontOfSize:10];
    //设置X轴坐标字体颜色
    sChart.x_Color = [UIColor colorWithHexString:@"0x3D86A6"];
    //设置Y轴坐标字体大小
    sChart.y_Font = [UIFont systemFontOfSize:10];
    //设置Y轴坐标字体颜色
    sChart.y_Color = [UIColor colorWithHexString:@"0x3D86A6"];
    //设置X轴数据间隔
    sChart.Xmargin = 50;
    //设置背景颜色
    sChart.backgroundColor = [UIColor clearColor];
    //是否根据折线数据浮动泡泡
    //_incomeChartLineView.isFloating = YES;
    //折线图数据
    sChart.leftDataArr = tempDataArrOfY2;
    //折线图所有颜色
    sChart.leftColorStrArr = @[@"#01FA73",@"#8763FF",@"#268BF6",@"#FF8AC6"];
    //设置折线样式
    sChart.chartViewStyle = LRSChartViewMoreClickLine;
    //设置图层效果
    sChart.chartLayerStyle = LRSChartNone;
    //设置折现效果
    sChart.lineLayerStyle = LRSLineLayerNone;
    //渐变效果的颜色组
    sChart.colors = @[@[[UIColor colorWithHexString:@"#febf83"],[UIColor greenColor]],@[[UIColor colorWithHexString:@"#53d2f8"],[UIColor blueColor]],@[[UIColor colorWithHexString:@"#7211df"],[UIColor redColor]]];
    //渐变开始比例
    sChart.proportion = 0.5;
    //底部日期
    sChart.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];
    //开始画图
    [sChart show];
    [energyView addSubview:sChart];

    UILabel *mark00 = [[UILabel alloc] initWithFrame:CGRectMake(0, energyView.frame.size.height - 30, energyView.frame.size.width/4.0, 30)];
    mark00.textAlignment = NSTextAlignmentCenter;
    mark00.textColor = [UIColor colorWithHexString:@"#01FA73"];
    mark00.text = @"—— 光伏产出";
    mark00.font = [UIFont systemFontOfSize:12];
    [energyView addSubview:mark00];
    
    UILabel *mark01 = [[UILabel alloc] initWithFrame:CGRectMake(energyView.frame.size.width/4.0, energyView.frame.size.height - 30, energyView.frame.size.width/4.0, 30)];
    mark01.textAlignment = NSTextAlignmentCenter;
    mark01.textColor = [UIColor colorWithHexString:@"#febf83"];
    mark01.text = @"—— 用户消耗";
    mark01.font = [UIFont systemFontOfSize:12];
    [energyView addSubview:mark01];
    
    UILabel *mark02 = [[UILabel alloc] initWithFrame:CGRectMake(energyView.frame.size.width/4.0 * 2, energyView.frame.size.height - 30, energyView.frame.size.width/4.0, 30)];
    mark02.textAlignment = NSTextAlignmentCenter;
    mark02.textColor = [UIColor colorWithHexString:@"#8763FF"];
    mark02.text = @"—— 电网取电";
    mark02.font = [UIFont systemFontOfSize:12];
    [energyView addSubview:mark02];
    
    UILabel *mark03 = [[UILabel alloc] initWithFrame:CGRectMake(energyView.frame.size.width/4.0 * 3, energyView.frame.size.height - 30, energyView.frame.size.width/4.0, 30)];
    mark03.textAlignment = NSTextAlignmentCenter;
    mark03.textColor = [UIColor colorWithHexString:@"#FF8AC6"];
    mark03.text = @"—— 来自电池";
    mark03.font = [UIFont systemFontOfSize:12];
    [energyView addSubview:mark03];
}


/**
 环境贡献 视图块
 */
- (void)setContributeView{

    UILabel *lblContributionBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contributeView.frame.size.width, contributeView.frame.size.height)];
    lblContributionBG.layer.masksToBounds = YES;
    lblContributionBG.layer.cornerRadius = 5;
    lblContributionBG.layer.borderWidth = 1;
    lblContributionBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblContributionBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [contributeView addSubview:lblContributionBG];
    
    UILabel *lblTitleContribute = [[UILabel alloc] initWithFrame:CGRectMake(0, lblContributionBG.frame.origin.y, lblContributionBG.frame.size.width, 44)];
    lblTitleContribute.font = [UIFont systemFontOfSize:24];
    lblTitleContribute.textColor = [UIColor whiteColor];
    lblTitleContribute.textAlignment = NSTextAlignmentCenter;
    lblTitleContribute.text = @"环境贡献";
    [contributeView addSubview:lblTitleContribute];
    
    float width = 40;
    float gap = (lblContributionBG.frame.size.width/3.0 - width)/2.0;
    
    UIButton *btnCo2 = [[UIButton alloc] initWithFrame:CGRectMake(gap + lblContributionBG.frame.size.width/3.0 * 0, lblTitleContribute.frame.origin.y + lblTitleContribute.frame.size.height + 30 ,width,width)];
    [btnCo2 setBackgroundImage:[UIImage imageNamed:@"环保_co2"] forState:UIControlStateNormal];
    [contributeView addSubview:btnCo2];
    
    UILabel *lblCo20 = [[UILabel alloc] initWithFrame:CGRectMake(0 + lblContributionBG.frame.size.width/3.0 *0, btnCo2.frame.size.height + btnCo2.frame.origin.y, lblContributionBG.frame.size.width/3.0, 20)];
    lblCo20.text = @"3079.2kg";
    lblCo20.textAlignment = NSTextAlignmentCenter;
    lblCo20.textColor = [UIColor whiteColor];
    [contributeView addSubview:lblCo20];
    
    UILabel *lblCo21 = [[UILabel alloc] initWithFrame:CGRectMake(0 + lblContributionBG.frame.size.width/3.0 *0, lblCo20.frame.size.height + lblCo20.frame.origin.y, lblContributionBG.frame.size.width/3.0, 20)];
    lblCo21.text = @"二氧化碳减排";
    lblCo21.textAlignment = NSTextAlignmentCenter;
    lblCo21.textColor = [UIColor colorWithRed:85/255.0 green:184/255.0 blue:229/255.0 alpha:1];
    [contributeView addSubview:lblCo21];
    //
    UIButton *btnCoal =  [[UIButton alloc] initWithFrame:CGRectMake(gap + lblContributionBG.frame.size.width/3.0 * 1, lblTitleContribute.frame.origin.y + lblTitleContribute.frame.size.height + 30 ,width,width)];
    [btnCoal setBackgroundImage:[UIImage imageNamed:@"环保_coal"] forState:UIControlStateNormal];
    [contributeView addSubview:btnCoal];
    //
    UILabel *lblCoal0 = [[UILabel alloc] initWithFrame:CGRectMake(0 + lblContributionBG.frame.size.width/3.0 *1, btnCo2.frame.size.height + btnCo2.frame.origin.y, lblContributionBG.frame.size.width/3.0, 20)];
    lblCoal0.text = @"3079.2kg";
    lblCoal0.textAlignment = NSTextAlignmentCenter;
    lblCoal0.textColor = [UIColor whiteColor];
    [contributeView addSubview:lblCoal0];
    
    UILabel *lblCoal1 =  [[UILabel alloc] initWithFrame:CGRectMake(0 + lblContributionBG.frame.size.width/3.0 *1, lblCo20.frame.size.height + lblCo20.frame.origin.y, lblContributionBG.frame.size.width/3.0, 20)];
    lblCoal1.text = @"节约煤";
    lblCoal1.textAlignment = NSTextAlignmentCenter;
    lblCoal1.textColor = [UIColor colorWithRed:85/255.0 green:184/255.0 blue:229/255.0 alpha:1];
    [contributeView addSubview:lblCoal1];
    //
    UIButton *btnTree =  [[UIButton alloc] initWithFrame:CGRectMake(gap + lblContributionBG.frame.size.width/3.0 * 2, lblTitleContribute.frame.origin.y + lblTitleContribute.frame.size.height + 30 ,width,width)];
    [btnTree setBackgroundImage:[UIImage imageNamed:@"环保_tree"] forState:UIControlStateNormal];
    [contributeView addSubview:btnTree];
    //
    UILabel *lblTree0 = [[UILabel alloc] initWithFrame:CGRectMake(0 + lblContributionBG.frame.size.width/3.0 *2, btnCo2.frame.size.height + btnCo2.frame.origin.y, lblContributionBG.frame.size.width/3.0, 20)];
    lblTree0.text = @"3079.2kg";
    lblTree0.textAlignment = NSTextAlignmentCenter;
    lblTree0.textColor = [UIColor whiteColor];
    [contributeView addSubview:lblTree0];
    
    UILabel *lblTree1 = [[UILabel alloc] initWithFrame:CGRectMake(0 + lblContributionBG.frame.size.width/3.0 *2, lblCo20.frame.size.height + lblCo20.frame.origin.y, lblContributionBG.frame.size.width/3.0, 20)];
    lblTree1.text = @"植树";
    lblTree1.textAlignment = NSTextAlignmentCenter;
    lblTree1.textColor = [UIColor colorWithRed:85/255.0 green:184/255.0 blue:229/255.0 alpha:1];
    [contributeView addSubview:lblTree1];
}

#pragma mark - 各种方法
/**
 动画
 */
- (void)changeImage{
    if (t == 0) {
        t = t+1;
        imgAL.image = [UIImage imageNamed:@"光伏功率_流动_work1"];
        imgRL.image = [UIImage imageNamed:@"电网功率_流动_work1"];
    } else if (t == 1) {
        t = t+1;
        imgAL.image = [UIImage imageNamed:@"光伏功率_流动_work2"];
        imgRL.image = [UIImage imageNamed:@"电网功率_流动_work2"];
    } else {
        t=0;
        imgAL.image = [UIImage imageNamed:@"光伏功率_流动_work3"];
        imgRL.image = [UIImage imageNamed:@"电网功率_流动_work3"];
    }
}


/**
 动画
 */
- (void)RotaAnimate{
    [imgC.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    [imgTotol.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    [imgLAround.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
    [imgRAround.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];//开始动画
}

/**
 日月年按钮
 */
- (void)btnDayClickAction{
    [btnDay setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnMonth setBackgroundColor:[UIColor colorWithRed:2/255.0 green:33/255.0 blue:43/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor clearColor]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

/**
 日月年按钮
 */
- (void)btnMonthClickAction{
    [btnDay setBackgroundColor:[UIColor clearColor]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    
    [btnMonth setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor clearColor]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}


/**
 日月年按钮
 */
- (void)btnYearClickAction{
    [btnDay setBackgroundColor:[UIColor clearColor]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    
    [btnMonth setBackgroundColor:[UIColor colorWithRed:2/255.0 green:33/255.0 blue:43/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


/**
 日期选择器
 */
- (void)btnChooseClickAction{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        
        [self->btnChoose setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
        
    }];
}

@end
