//
//  AnalysisViewPad.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/10.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "AnalysisViewPad.h"
#import "TLHeader.h"
#import "common.h"

@interface AnalysisViewPad () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    
    UIView *bateryView;
    UIView *alertView;
    UIView *energyView;
    UIView *powerView;
    
    UIButton *btnRealTime;
    UIButton *btnDay;
    UIButton *btnMonth;
    UIButton *btnYear;
    UIButton *btnTime0;
    UIButton *btnTime1;
    UIButton *btnTime2;
    
}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@end

@implementation AnalysisViewPad

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (void)loadView{
    if (self.frame.size.width < self.frame.size.height) {
        //竖屏
        bateryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 964/2.0)];
        alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 430/2.0)];
        energyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 590/2.0)];
        powerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 804/2.0)];
        
        [self loadBateryView];
        [self loadAlertView];
        [self loadEnergyView];
        [self loadPowerView];
      
        [self loadViewVertical];
    } else {
        //横屏
        bateryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 750/2.0, 964/2.0)];
        alertView = [[UIView alloc] initWithFrame:CGRectMake(0, bateryView.frame.origin.y + bateryView.frame.size.height+15, 750/2.0, 430/2.0)];
        energyView = [[UIView alloc] initWithFrame:CGRectMake(780/2.0, 0, 1060/2.0, 590/2.0)];
        powerView = [[UIView alloc] initWithFrame:CGRectMake(780/2.0, 620/2.0, 1060/2.0, 804/2.0)];
        
        [self loadBateryView];
        [self loadAlertView];
        [self loadEnergyView];
        [self loadPowerView];
        
        [self loadViewHorizontal];
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
        return bateryView.frame.size.height;
    } else if (indexPath.section == 1) {
        return alertView.frame.size.height;
    } else if (indexPath.section == 2) {
        return energyView.frame.size.height;
    } else if (indexPath.section == 3) {
        return powerView.frame.size.height;
    } else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if (indexPath.section == 0) {
        [cell addSubview:bateryView];
    } else if (indexPath.section == 1) {
        [cell addSubview:alertView];
    } else if (indexPath.section == 2) {
        [cell addSubview:energyView];
    } else if (indexPath.section == 3) {
        [cell addSubview:powerView];
    }
    
    return cell;
}

#pragma mark- 横屏
//横屏
- (void)loadViewHorizontal{
    
    [self addSubview:bateryView];
    [self addSubview:alertView];
    [self addSubview:energyView];
    [self addSubview:powerView];
    
}

#pragma mark - 小块
//电能质量
- (void)loadBateryView{
    
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bateryView.frame.size.width, bateryView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [bateryView addSubview:lblBG];
    
    //view添加内容
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, bateryView.frame.size.width, 40)];
    lblTitle.font = [UIFont systemFontOfSize:24];
    lblTitle.text = @"电能质量";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [bateryView addSubview:lblTitle];
    
    btnTime1 = [[UIButton alloc] initWithFrame:CGRectMake((bateryView.frame.size.width - 110)/2.0, 60, 110, 30)];
    
    btnTime1.layer.masksToBounds = YES;
    btnTime1.layer.masksToBounds = YES;
    btnTime1.layer.cornerRadius = 15;
    btnTime1.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnTime1.layer.borderWidth = 1;
    [btnTime1 setTitle:@"2018-08-02" forState:UIControlStateNormal];
    btnTime1.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnTime1 addTarget:self action:@selector(btnTime1ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [bateryView addSubview:btnTime1];
    
    UIButton *btnLast = [[UIButton alloc] initWithFrame:CGRectMake(btnTime1.frame.origin.x - 30 - 6, btnTime1.frame.origin.y, 30, 30)];
    [btnLast setBackgroundImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
    [bateryView addSubview:btnLast];
    
    UIButton *btnNext = [[UIButton alloc] initWithFrame:CGRectMake(btnTime1.frame.origin.x + btnTime1.frame.size.width + 6, btnTime1.frame.origin.y, 30, 30)];
    [btnNext setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [bateryView addSubview:btnNext];
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, bateryView.frame.size.width, 1)];
    lblLine0.backgroundColor = [UIColor colorWithRed:52/255.0 green:79/255.0 blue:88/255.0 alpha:1];
    [bateryView addSubview:lblLine0];
    
    UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, bateryView.frame.size.width/4.0, 50)];
    [btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn0 setTitle:@"电表1(A栋)" forState:UIControlStateNormal];
//    [btn0 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
    btn0.titleLabel.font = [UIFont systemFontOfSize:14];
    [bateryView addSubview:btn0];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(bateryView.frame.size.width/4.0, btn0.frame.origin.y, bateryView.frame.size.width/4.0, btn0.frame.size.height)];
    [btn1 setTitleColor:[UIColor colorWithRed:5/255.0 green:144/255.0 blue:244/255.0 alpha:1] forState:UIControlStateNormal];
    [btn1 setTitle:@"电表2(B栋)" forState:UIControlStateNormal];
//    [btn1 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [bateryView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(bateryView.frame.size.width/4.0 *2,  btn0.frame.origin.y, bateryView.frame.size.width/4.0, btn0.frame.size.height)];
    [btn2 setTitleColor:[UIColor colorWithRed:5/255.0 green:144/255.0 blue:244/255.0 alpha:1] forState:UIControlStateNormal];
    [btn2 setTitle:@"电表3(展厅)" forState:UIControlStateNormal];
//    [btn2 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [bateryView addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(bateryView.frame.size.width/4.0 *3,  btn0.frame.origin.y, bateryView.frame.size.width/4.0, btn0.frame.size.height)];
    [btn3 setTitleColor:[UIColor colorWithRed:5/255.0 green:144/255.0 blue:244/255.0 alpha:1] forState:UIControlStateNormal];
    [btn3 setTitle:@"电表4(停车场)" forState:UIControlStateNormal];
//    [btn3 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    [bateryView addSubview:btn3];
    
    UILabel *lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 + btn0.frame.size.height, bateryView.frame.size.width, 1)];
    lblLine1.backgroundColor = [UIColor colorWithRed:52/255.0 green:79/255.0 blue:88/255.0 alpha:1];
    [bateryView addSubview:lblLine1];
    
    UILabel *lblSelect = [[UILabel alloc] initWithFrame:CGRectMake(bateryView.frame.size.width/12.0 + bateryView.frame.size.width/4.0 * 0, lblLine1.frame.origin.y - 0.5, bateryView.frame.size.width/12.0, 2)];
    lblSelect.backgroundColor = [UIColor whiteColor];
    [bateryView addSubview:lblSelect];
    
    UIButton *btnA = [[UIButton alloc] initWithFrame:CGRectMake(5, lblLine1.frame.origin.y + 30, bateryView.frame.size.width / 3.0 - 10, 30)];
    [btnA setTitle:@"三相电流不平衡度" forState:UIControlStateNormal];
    btnA.titleLabel.textColor = [UIColor lightGrayColor];
    btnA.titleLabel.font = [UIFont systemFontOfSize:14];
    [LayerView Button:btnA BackgroundColor:[UIColor grayColor] BorderWidth:1 BorderColor:[UIColor grayColor] Cor:15];
    [bateryView addSubview:btnA];
//
    UIButton *btnB = [[UIButton alloc] initWithFrame:CGRectMake(5 + bateryView.frame.size.width / 3.0 , btnA.frame.origin.y, bateryView.frame.size.width / 3.0 - 10, 30)];
    [btnB setTitle:@"三相电压不平衡度" forState:UIControlStateNormal];
    [btnB setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnB.titleLabel.font = [UIFont systemFontOfSize:14];
    [LayerView Button:btnB BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:[UIColor clearColor] Cor:15];
    [bateryView addSubview:btnB];
    
    UIButton *btnC = [[UIButton alloc] initWithFrame:CGRectMake(5 + bateryView.frame.size.width / 3.0 * 2, btnA.frame.origin.y, bateryView.frame.size.width / 3.0 - 10, 30)];
    [btnC setTitle:@"功率因素" forState:UIControlStateNormal];
    [btnC setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btnC.titleLabel.font = [UIFont systemFontOfSize:14];
    [LayerView Button:btnC BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:[UIColor clearColor] Cor:15];
    [bateryView addSubview:btnC];
    
    HomeLineChartView *chart0 = [[HomeLineChartView alloc] initWithFrame:CGRectMake(0, lblLine1.frame.origin.y + 132/2.0, bateryView.frame.size.width, 100 * 4/2.0)];
    chart0.colorTitleY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart0.colorTitleX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart0.colorLineX = [UIColor colorWithRed:29/255.0 green:68/255.0 blue:78/255.0 alpha:0.6];
    chart0.colorTextY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart0.colorTextX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];

    chart0.colorLine = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:1];
    chart0.colorGradientTop = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0.6];
    chart0.colorGradientCenter = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0.3];
    chart0.colorGradientButtom = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0];


    chart0.lblTitleY.text = @"";
    chart0.lblTitleX.text = @"";
    chart0.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:0];
    chart0.dataArrOfY = @[@"900",@"600",@"300",@"0"];//Y轴坐标
    chart0.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];//X轴坐标
    chart0.dataArrOfPoint = @[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"];

    [chart0 startDraw];
    [bateryView addSubview:chart0];

    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, chart0.frame.origin.y + chart0.frame.size.height - 20, bateryView.frame.size.width/2.0, 20)];
    lbl1.textColor = [UIColor greenColor];
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.text = @"—— 当前值";
    [bateryView addSubview:lbl1];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(bateryView.frame.size.width/2.0, chart0.frame.origin.y + chart0.frame.size.height - 20, bateryView.frame.size.width/2.0, 20)];
    lbl2.textColor = [UIColor redColor];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.text = @"—— 报警值";
    [bateryView addSubview:lbl2];
    
}

//分类告警
- (void)loadAlertView{
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, alertView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [alertView addSubview:lblBG];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, 50)];
    lblTitle.text = @"分类告警";
    lblTitle.textColor= [UIColor whiteColor];
    lblTitle.font = [UIFont systemFontOfSize:20];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:lblTitle];
    
    UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(alertView.frame.size.width - 30, 20, 20, 20)];
    imgR.image = [UIImage imageNamed:@"more"];
    [alertView addSubview:imgR];
    
    for (int i = 1 ; i < 4 ; i++){
    
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25+50*i, 20, 20)];
        img.image = [UIImage imageNamed:@"告警"];
        [alertView addSubview:img];
        
        UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(45, 15+50*i, alertView.frame.size.width - 60, 40)];
        lbltitle.textAlignment = NSTextAlignmentLeft;
        lbltitle.text = @" 逆变器告警";
        lbltitle.textColor = [UIColor whiteColor];
        lbltitle.font = [UIFont systemFontOfSize:20];
        [alertView addSubview:lbltitle];
        
        UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0,10+ 50*i, alertView.frame.size.width, 1)];
        lblLine.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.05];
        [alertView addSubview:lblLine];
        
    }
    
    
}

//节能数据
- (void)loadEnergyView{
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, energyView.frame.size.width, energyView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [energyView addSubview:lblBG];
    
    //view添加内容
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, energyView.frame.size.width, 40)];
    lblTitle.font = [UIFont systemFontOfSize:24];
    lblTitle.text = @"节能数据";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [energyView addSubview:lblTitle];
    
    UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(45, 55, 40, 40)];
    img0.image = [UIImage imageNamed:@"当月用电"];
    [energyView addSubview:img0];
    
    UILabel *lblDataTotol = [[UILabel alloc] initWithFrame:CGRectMake(img0.frame.origin.x +img0.frame.size.width + 10, img0.frame.origin.y, energyView.frame.size.width/2.0 - 85, 20)];
    lblDataTotol.textAlignment = NSTextAlignmentLeft;
    lblDataTotol.textColor = [UIColor whiteColor];
    lblDataTotol.text = @"100.6kwh";
    [energyView addSubview:lblDataTotol];
    
    UILabel *lblTotol =  [[UILabel alloc] initWithFrame:CGRectMake(img0.frame.origin.x +img0.frame.size.width + 10, lblDataTotol.frame.origin.y + lblDataTotol.frame.size.height, energyView.frame.size.width/2.0 - 85, 20)];
    lblTotol.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblTotol.textAlignment = NSTextAlignmentLeft;
    lblTotol.text = @"累计节约电量";
    [energyView addSubview:lblTotol];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(45 + energyView.frame.size.width/2.0, 55, 40, 40)];
    img1.image = [UIImage imageNamed:@"当月收益"];
    [energyView addSubview:img1];
    
    UILabel *lblDataPrice = [[UILabel alloc] initWithFrame:CGRectMake(img1.frame.origin.x +img1.frame.size.width + 10, img0.frame.origin.y, energyView.frame.size.width/2.0 - 85, 20)];
    lblDataPrice.textAlignment = NSTextAlignmentLeft;
    lblDataPrice.textColor = [UIColor whiteColor];
    lblDataPrice.text = @"￥5130.2";
    [energyView addSubview:lblDataPrice];
    
    UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(img1.frame.origin.x +img1.frame.size.width + 10, lblDataPrice.frame.origin.y + lblDataPrice.frame.size.height, energyView.frame.size.width/2.0 - 85, 20)];
    lblPrice.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lblPrice.textAlignment = NSTextAlignmentLeft;
    lblPrice.text = @"累计节约电量";
    [energyView addSubview:lblPrice];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 112, energyView.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:23/255.0 green:52/255.0 blue:62/255.0 alpha:1];
    [energyView addSubview:lblLine];
    
    UILabel *lblCompare = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, energyView.frame.size.width, 40)];
    lblCompare.textAlignment = NSTextAlignmentCenter;
    lblCompare.textColor = [UIColor colorWithRed:82/255.0 green:180/255.0 blue:224/255.0 alpha:1];
    lblCompare.text = @"同比上月用电量及百分比";
    lblCompare.font = [UIFont systemFontOfSize:20];
    [energyView addSubview:lblCompare];
    
    UILabel *lblDataCompare = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, energyView.frame.size.width, 20)];
    lblDataCompare.textAlignment = NSTextAlignmentCenter;
    lblDataCompare.textColor = [UIColor whiteColor];
    lblDataCompare.text = @"- 30kWh";
    [energyView addSubview:lblDataCompare];
    
    ProgressView *progressView0 = [[ProgressView alloc] initWithFrame:CGRectMake((energyView.frame.size.width - 80)/2.0, 187 , 80, 80)];
    progressView0.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    progressView0.colorTop = [UIColor colorWithRed:23/255.0 green:245/255.0 blue:250/255.0 alpha:1];
    progressView0.progress = 0.81;
    progressView0.colorButtom = [UIColor colorWithRed:0/255.0 green:121/255.0 blue:129/255.0 alpha:1];
    progressView0.animationTime = 1;
    progressView0.topWidth = 5;
    progressView0.buttomWidth = 5;
    [energyView addSubview:progressView0];
    
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake((energyView.frame.size.width - 96)/2.0, progressView0.frame.origin.y - 8 , 96, 96)];
    imgBG.image = [UIImage imageNamed:@"节能_上月同比bg"];
    [energyView addSubview:imgBG];
    
    UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, progressView0.frame.origin.y + 20, energyView.frame.size.width, 20)];
    lblB.textColor = [UIColor colorWithRed:4/255.0 green:232/255.0 blue:223/255.0 alpha:1];
    lblB.textAlignment = NSTextAlignmentCenter;
    lblB.text = @"81%";
    lblB.font = [UIFont systemFontOfSize:20];
    [energyView addSubview:lblB];
    
    UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake((energyView.frame.size.width - 20)/2.0, progressView0.frame.origin.y + 45, 20, 20)];
    imgC.image = [UIImage imageNamed:@"节能_上月同比_减少"];
    [energyView addSubview:imgC];
    
    UILabel *lbl00 = [[UILabel alloc] initWithFrame:CGRectMake(progressView0.frame.origin.x - 200, lblB.frame.origin.y, 80, 20)];
    lbl00.textColor = [UIColor colorWithRed:94/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl00.textAlignment = NSTextAlignmentLeft;
    lbl00.text = @"本月用电";
    [energyView addSubview:lbl00];
    
    UILabel *lbl01 = [[UILabel alloc] initWithFrame:CGRectMake(lbl00.frame.origin.x, lblB.frame.origin.y +25, 80, 20)];
    lbl01.textColor = [UIColor colorWithRed:94/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl01.textAlignment = NSTextAlignmentLeft;
    lbl01.text = @"上月用电";
    [energyView addSubview:lbl01];
    
    UILabel *lblData00 = [[UILabel alloc] initWithFrame:CGRectMake(lbl00.frame.origin.x + lbl00.frame.size.width, lbl00.frame.origin.y, 100, 20)];
    lblData00.textColor = [UIColor whiteColor];
    lblData00.textAlignment = NSTextAlignmentLeft;
    lblData00.text = @"100.6 kwh";
    [energyView addSubview:lblData00];
    
    UILabel *lblData01 = [[UILabel alloc] initWithFrame:CGRectMake(lbl01.frame.origin.x + lbl01.frame.size.width, lbl01.frame.origin.y, 100, 20)];
    lblData01.textColor = [UIColor whiteColor];
    lblData01.textAlignment = NSTextAlignmentLeft;
    lblData01.text = @"130.2 kwh";
    [energyView addSubview:lblData01];
    
    UILabel *lbl10 = [[UILabel alloc] initWithFrame:CGRectMake(progressView0.frame.origin.x + progressView0.frame.size.width + 40, lblB.frame.origin.y, 80, 20)];
    lbl10.textColor = [UIColor colorWithRed:94/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl10.textAlignment = NSTextAlignmentLeft;
    lbl10.text = @"本月电费";
    [energyView addSubview:lbl10];
    
    UILabel *lbl11 = [[UILabel alloc] initWithFrame:CGRectMake(lbl10.frame.origin.x, lblB.frame.origin.y +25, 80, 20)];
    lbl11.textColor = [UIColor colorWithRed:94/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    lbl11.textAlignment = NSTextAlignmentLeft;
    lbl11.text = @"上月电费";
    [energyView addSubview:lbl11];
    
    UILabel *lblData10 = [[UILabel alloc] initWithFrame:CGRectMake(lbl10.frame.origin.x + lbl10.frame.size.width, lbl10.frame.origin.y, 100, 20)];
    lblData10.textColor = [UIColor whiteColor];
    lblData10.textAlignment = NSTextAlignmentLeft;
    lblData10.text = @"￥130.2";
    [energyView addSubview:lblData10];
    
    UILabel *lblData11 = [[UILabel alloc] initWithFrame:CGRectMake(lbl11.frame.origin.x + lbl11.frame.size.width, lbl11.frame.origin.y, 100, 20)];
    lblData11.textColor = [UIColor whiteColor];
    lblData11.textAlignment = NSTextAlignmentLeft;
    lblData11.text = @"￥130.2";
    [energyView addSubview:lblData11];
}

//功率曲线图
- (void)loadPowerView{
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, powerView.frame.size.width,powerView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [powerView addSubview:lblBG];
    
    //view添加内容
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, powerView.frame.size.width, 40)];
    lblTitle.font = [UIFont systemFontOfSize:24];
    lblTitle.text = @"功率曲线图";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [powerView addSubview:lblTitle];
    
    btnRealTime = [[UIButton alloc] initWithFrame:CGRectMake(20, 55, 100, 30)];
    btnRealTime.layer.borderWidth = 1;
    btnRealTime.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnRealTime.layer.masksToBounds = YES;
    btnRealTime.layer.cornerRadius = 15;
    [btnRealTime setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRealTime setTitle:@"实时" forState:UIControlStateNormal];
    btnRealTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnRealTime.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btnRealTime addTarget:self action:@selector(btnRealTimeClickAction) forControlEvents:UIControlEventTouchUpInside];
    [powerView addSubview:btnRealTime];
    
    btnYear = [[UIButton alloc] initWithFrame:CGRectMake(20 +50*2, 55, 100, 30)];
    btnYear.layer.borderWidth = 1;
    btnYear.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnYear.layer.masksToBounds = YES;
    btnYear.layer.cornerRadius = 15;
    [btnYear setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear setTitle:@"年" forState:UIControlStateNormal];
    btnYear.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnYear.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [btnYear addTarget:self action:@selector(btnYearClickAction) forControlEvents:UIControlEventTouchUpInside];
    [powerView addSubview:btnYear];
    
    btnDay = [[UIButton alloc] initWithFrame:CGRectMake(20 +50, 55, 50, 30)];
    btnDay.layer.borderWidth = 1;
    btnDay.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnDay.layer.masksToBounds = YES;
    [btnDay setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay setTitle:@"日" forState:UIControlStateNormal];
    [btnDay addTarget:self action:@selector(btnDayClickAction) forControlEvents:UIControlEventTouchUpInside];
    [powerView addSubview:btnDay];
    
    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(20 +50*2, 55, 50, 30)];
    btnMonth.layer.borderWidth = 1;
    btnMonth.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnMonth.layer.masksToBounds = YES;
    [btnMonth setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth setTitle:@"月" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(btnMonthClickAction) forControlEvents:UIControlEventTouchUpInside];
    [powerView addSubview:btnMonth];
    
    btnTime2 = [[UIButton alloc] initWithFrame:CGRectMake(powerView.frame.size.width - 20 - 110, 55, 110, 30)];
    btnTime2.layer.masksToBounds = YES;
    btnTime2.layer.masksToBounds = YES;
    btnTime2.layer.cornerRadius = 15;
    btnTime2.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnTime2.layer.borderWidth = 1;
    [btnTime2 setTitle:@"2018-08-02" forState:UIControlStateNormal];
    btnTime2.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnTime2 addTarget:self action:@selector(btnTime2ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [powerView addSubview:btnTime2];
    
    NSArray *tempDataArrOfY2 = @[@[@"10",@"270",@"300",@"320",@"410",@"420",@"420",@"310",@"350",@"450"],@[@"20",@"290",@"400",@"420",@"510",@"520",@"520",@"410",@"550",@"550"],@[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"]];
    
    LRSChartView *sChart = [[LRSChartView alloc]initWithFrame:CGRectMake(0, btnDay.frame.origin.y + btnDay.frame.size.height + 30, powerView.bounds.size.width, powerView.frame.size.height - 90 - btnDay.frame.origin.y - btnDay.frame.size.height - 30)];
    
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
    sChart.leftColorStrArr = @[@"#01FA73",@"#8763FF",@"#268BF6"];
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
    [powerView addSubview:sChart];
    
    
    ProgressLineView *progressLine = [[ProgressLineView alloc] initWithFrame:CGRectMake(60, powerView.frame.size.height - 70, powerView.frame.size.width - 120, 15)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, progressLine.frame.size.width, progressLine.frame.size.height)];
    label.textColor = [UIColor whiteColor];
    progressLine.progressValue = (20)/(20.0+180.0);
    progressLine.progressBackGroundColor = [UIColor colorWithRed:242/255.0 green:95/255.0 blue:50/255.0 alpha:1];
    progressLine.progressTintColor = [UIColor colorWithRed:235/255.0 green:192/255.0 blue:62/255.0 alpha:1];
    progressLine.progressCornerRadius = 0;
    progressLine.backgroundColor = [UIColor redColor];
    progressLine.layer.masksToBounds = YES;
    progressLine.layer.cornerRadius = 7.5;
    [progressLine insertSubview:label atIndex:0];//将label移动到最上面
    [powerView addSubview:progressLine];
}


#pragma mark - 按钮功能
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



- (void)btnTime0ClickAction{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        
        [btnTime0 setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
        
    }];
}

- (void)btnTime1ClickAction{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        
        [btnTime1 setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
        
    }];
}

- (void)btnTime2ClickAction{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        
        [btnTime2 setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
        
    }];
}



@end
