//
//  AnalysisView.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "AnalysisView.h"
#import "common.h"
#import "TLHeader.h"

@interface AnalysisView ()  <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    
    UIButton *btnRealTime;
    UIButton *btnDay;
    UIButton *btnMonth;
    UIButton *btnYear;
    UIButton *btnTime0;
    UIButton *btnTime1;
    UIButton *btnTime2;
    
    NSArray *listCellHeight;
}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@end

@implementation AnalysisView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self pretreatment];
    }
    return self;
}

- (void)pretreatment{
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
    }
    listCellHeight = @[@"445",@"70",@"340",@"340"];
    [self addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return listCellHeight.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.000000001)];
    headView.backgroundColor = [UIColor colorWithRed:156/255.0 green:137255.0 blue:124255.0 alpha:0.2];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.0000001)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i<listCellHeight.count; i++) {
        if (indexPath.section == i) {
            return [[listCellHeight objectAtIndex:i] floatValue] *ProportionX;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0) {
        
    } else {
        UIImageView *cellBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 50*ProportionX)];
        cellBG.backgroundColor = [UIColor colorWithRed:0 green:31/255.0 blue:40/255.0 alpha:0.8];
        cellBG.layer.masksToBounds = YES;
        cellBG.layer.cornerRadius = 10;
        [cell addSubview:cellBG];
        
        UIImageView *cellFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 10)];
        cellFrame.image = [UIImage imageNamed:@"高光"];
        [cell addSubview:cellFrame];
        for (int i = 0; i < listCellHeight.count; i++) {
            if (indexPath.section == i) {
                cellBG.frame = CGRectMake(10, 0, self.frame.size.width - 20,[[listCellHeight objectAtIndex:i] floatValue]*ProportionX);
            }
        }
    }
    
    if (indexPath.section == 0) {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width , 45*ProportionX)];
        lblTitle.textAlignment = NSTextAlignmentLeft;
        lblTitle.font = FontL;
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = @"电能质量";
        [cell addSubview:lblTitle];
        
        btnTime1 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10*ProportionX - 90*ProportionX - 40*ProportionX, 10*ProportionX, 90*ProportionX, 25*ProportionX)];
        btnTime1.layer.masksToBounds = YES;
        btnTime1.layer.masksToBounds = YES;
        btnTime1.layer.cornerRadius = 12.5*ProportionX;
        btnTime1.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnTime1.layer.borderWidth = 1;
        [btnTime1 setTitle:@"2018-08-02" forState:UIControlStateNormal];
        btnTime1.titleLabel.font = Font12;
        [btnTime1 addTarget:self action:@selector(btnTime1ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnTime1];
        
        UIButton *btnLast = [[UIButton alloc] initWithFrame:CGRectMake(btnTime1.frame.origin.x - 25*ProportionX - 6*ProportionX, 10*ProportionX, 25*ProportionX, 25*ProportionX)];
        [btnLast setBackgroundImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
        [cell addSubview:btnLast];
        
        UIButton *btnNext = [[UIButton alloc] initWithFrame:CGRectMake(btnTime1.frame.origin.x + btnTime1.frame.size.width + 6*ProportionX, 10*ProportionX, 25*ProportionX, 25*ProportionX)];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [cell addSubview:btnNext];
        
        UIButton *btnA = [[UIButton alloc] initWithFrame:CGRectMake(0, 45*ProportionX, self.frame.size.width/4.0, 38*ProportionX)];
        [btnA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnA setTitle:@"电表1(A栋)" forState:UIControlStateNormal];
        [btnA setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
        btnA.titleLabel.font = Font14;
        [cell addSubview:btnA];
        
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/4.0, 45*ProportionX, self.frame.size.width/4.0, 38*ProportionX)];
        [btn1 setTitleColor:[UIColor colorWithRed:5/255.0 green:144/255.0 blue:244/255.0 alpha:1] forState:UIControlStateNormal];
        [btn1 setTitle:@"电表2(B栋)" forState:UIControlStateNormal];
        [btn1 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
        btn1.titleLabel.font = Font14;
        [cell addSubview:btn1];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/4.0 *2, 45*ProportionX, self.frame.size.width/4.0, 38*ProportionX)];
        [btn2 setTitleColor:[UIColor colorWithRed:5/255.0 green:144/255.0 blue:244/255.0 alpha:1] forState:UIControlStateNormal];
        [btn2 setTitle:@"电表3(展厅)" forState:UIControlStateNormal];
        [btn2 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
        btn2.titleLabel.font = Font14;
        [cell addSubview:btn2];
        
        UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/4.0 *3, 45*ProportionX, self.frame.size.width/4.0, 38*ProportionX)];
        [btn3 setTitleColor:[UIColor colorWithRed:5/255.0 green:144/255.0 blue:244/255.0 alpha:1] forState:UIControlStateNormal];
        [btn3 setTitle:@"电表4(停车场)" forState:UIControlStateNormal];
        [btn3 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
        btn3.titleLabel.font = Font14;
        [cell addSubview:btn3];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, (45+38)*ProportionX, self.frame.size.width, 362*ProportionX)];
        img.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
        img.image = [UIImage imageNamed:@"img002"];
        [cell addSubview:img];
        
        HomeLineChartView *chart0 = [[HomeLineChartView alloc] initWithFrame:CGRectMake(0,btn1.frame.origin.y+btn1.frame.size.height + 10, self.frame.size.width, 190*ProportionX)];
        chart0.colorTitleY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
        chart0.colorTitleX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
        chart0.colorLineX = [UIColor colorWithRed:29/255.0 green:68/255.0 blue:78/255.0 alpha:0.6];
        chart0.colorTextY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
        chart0.colorTextX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
        
        chart0.colorLine = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:1];
        chart0.colorGradientTop = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0.6];
        chart0.colorGradientCenter = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0.3];
        chart0.colorGradientButtom = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0];
        
        
        chart0.lblTitleY.text = @"三相电压不平衡度";
        chart0.lblTitleX.text = @"";
        chart0.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:0];
        chart0.dataArrOfY = @[@"800",@"600",@"400",@"200",@"0"];//Y轴坐标
        chart0.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];//X轴坐标
        chart0.dataArrOfPoint = @[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"];
        
        [chart0 startDraw];
        [cell addSubview:chart0];
        
        HomeLineChartView *chart1 = [[HomeLineChartView alloc] initWithFrame:CGRectMake(0,chart0.frame.origin.y +chart0.frame.size.height - 20*ProportionX, self.frame.size.width, 190*ProportionX)];
        chart1.colorTitleY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
        chart1.colorTitleX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
        chart1.colorLineX = [UIColor colorWithRed:29/255.0 green:68/255.0 blue:78/255.0 alpha:0.6];
        chart1.colorTextY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
        chart1.colorTextX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
        
        chart1.colorLine = [UIColor colorWithRed:255/255.0 green:214/255.0 blue:0/255.0 alpha:1];
        chart1.colorGradientTop = [UIColor colorWithRed:255/255.0 green:214/255.0 blue:0/255.0 alpha:0.6];
        chart1.colorGradientCenter = [UIColor colorWithRed:255/255.0 green:214/255.0 blue:0/255.0 alpha:0.3];
        chart1.colorGradientButtom = [UIColor colorWithRed:255/255.0 green:214/255.0 blue:0/255.0 alpha:0];
        
        
        chart1.lblTitleY.text = @"三相电压不平衡度";
        chart1.lblTitleX.text = @"";
        chart1.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:0];
        chart1.dataArrOfY = @[@"800",@"600",@"400",@"200",@"0"];//Y轴坐标
        chart1.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];//X轴坐标
        chart1.dataArrOfPoint = @[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"];
        
        [chart1 startDraw];
        [cell addSubview:chart1];
        
        
    } else if (indexPath.section == 1) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20*ProportionX, 25*ProportionX, 20*ProportionX, 20*ProportionX)];
        img.image = [UIImage imageNamed:@"告警"];
        [cell addSubview:img];
        
        UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(45*ProportionX, 20*ProportionX, self.frame.size.width - 60*ProportionX, 30*ProportionX)];
        lbltitle.textAlignment = NSTextAlignmentLeft;
        lbltitle.text = @"告警";
        lbltitle.textColor = [UIColor whiteColor];
        lbltitle.font = FontTitle;
        [cell addSubview:lbltitle];
        
        UIImageView *imgR = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30*ProportionX, 25*ProportionX, 20*ProportionX, 20*ProportionX)];
        imgR.image = [UIImage imageNamed:@"more"];
        [cell addSubview:imgR];
        
        UILabel *lblNum = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 30*ProportionX - 80*ProportionX, 20*ProportionX, 80*ProportionX, 30*ProportionX)];
        lblNum.textColor = [UIColor redColor];
        lblNum.textAlignment = NSTextAlignmentRight;
        lblNum.text = @"4";
        [cell addSubview:lblNum];
    } else if (indexPath.section == 2) {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
        lblTitle.font = FontL;
        lblTitle.text = @"节能数据";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lblTitle];
        
        UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(35*ProportionX, 53*ProportionX, 35*ProportionX, 35*ProportionX)];
        img0.image = [UIImage imageNamed:@"当月用电"];
        [cell addSubview:img0];
        
        UILabel *lblDataTotol = [[UILabel alloc] initWithFrame:CGRectMake(img0.frame.origin.x +img0.frame.size.width + 10*ProportionX, 50*ProportionX, self.frame.size.width/2.0 - 65*ProportionX, 20*ProportionX)];
        lblDataTotol.textAlignment = NSTextAlignmentLeft;
        lblDataTotol.textColor = [UIColor whiteColor];
        lblDataTotol.text = @"100.6kwh";
        [cell addSubview:lblDataTotol];
        
        UILabel *lblTotol = [[UILabel alloc] initWithFrame:CGRectMake(img0.frame.origin.x +img0.frame.size.width + 10*ProportionX, 70*ProportionX, self.frame.size.width/2.0 - 65*ProportionX, 20*ProportionX)];
        lblTotol.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
        lblTotol.textAlignment = NSTextAlignmentLeft;
        lblTotol.text = @"累计节约电量";
        [cell addSubview:lblTotol];
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(209*ProportionX, 53*ProportionX, 35*ProportionX, 35*ProportionX)];
        img1.image = [UIImage imageNamed:@"当月收益"];
        [cell addSubview:img1];
        
        UILabel *lblDataPrice = [[UILabel alloc] initWithFrame:CGRectMake(img1.frame.origin.x +img1.frame.size.width + 10*ProportionX, 50*ProportionX, self.frame.size.width/2.0 - 65*ProportionX, 20*ProportionX)];
        lblDataPrice.textAlignment = NSTextAlignmentLeft;
        lblDataPrice.textColor = [UIColor whiteColor];
        lblDataPrice.text = @"￥5130.2";
        [cell addSubview:lblDataPrice];
        
        UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(img1.frame.origin.x +img1.frame.size.width + 10*ProportionX, 70*ProportionX, self.frame.size.width/2.0 - 65*ProportionX, 20*ProportionX)];
        lblPrice.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:255/255.0 alpha:1];
        lblPrice.textAlignment = NSTextAlignmentLeft;
        lblPrice.text = @"累计节约电量";
        [cell addSubview:lblPrice];
        
        UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 106*ProportionX, self.frame.size.width - 20, 1)];
        lblLine.backgroundColor = [UIColor colorWithRed:28/255.0 green:57/255.0 blue:66/255.0 alpha:1];
        [cell addSubview:lblLine];
        
        UILabel *lblCompare = [[UILabel alloc] initWithFrame:CGRectMake(0, 122*ProportionX, self.frame.size.width, 20*ProportionX)];
        lblCompare.textAlignment = NSTextAlignmentCenter;
        lblCompare.textColor = [UIColor colorWithRed:82/255.0 green:180/255.0 blue:224/255.0 alpha:1];
        lblCompare.text = @"同比上月用电量及百分比";
        [cell addSubview:lblCompare];
        
        UILabel *lblDataCompare = [[UILabel alloc] initWithFrame:CGRectMake(0, 142*ProportionX, self.frame.size.width, 20*ProportionX)];
        lblDataCompare.textAlignment = NSTextAlignmentCenter;
        lblDataCompare.textColor = [UIColor whiteColor];
        lblDataCompare.text = @"-30kWh";
        [cell addSubview:lblDataCompare];
        
        ProgressView *progressView0 = [[ProgressView alloc] initWithFrame:CGRectMake((self.frame.size.width - 80*ProportionX)/2.0, 165*ProportionX , 85*ProportionX, 85*ProportionX)];
        progressView0.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        progressView0.colorTop = [UIColor colorWithRed:23/255.0 green:245/255.0 blue:250/255.0 alpha:1];
        progressView0.progress = 0.81;
        progressView0.colorButtom = [UIColor colorWithRed:0/255.0 green:121/255.0 blue:129/255.0 alpha:1];
        progressView0.animationTime = 1;
        progressView0.topWidth = 5*ProportionX;
        progressView0.buttomWidth = 5*ProportionX;
        [cell addSubview:progressView0];
        
        UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 103*ProportionX)/2.0 + 3*ProportionX, 165*ProportionX - 12.5*ProportionX + 4*ProportionX, 103*ProportionX, 103*ProportionX)];
        imgBG.image = [UIImage imageNamed:@"节能_上月同比bg"];
        [cell addSubview:imgBG];
        
        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(0, progressView0.frame.origin.y + 17*ProportionX, self.frame.size.width, 30*ProportionX)];
        lblB.textColor = [UIColor colorWithRed:4/255.0 green:232/255.0 blue:223/255.0 alpha:1];
        lblB.textAlignment = NSTextAlignmentCenter;
        lblB.text = @"  81%";
        lblB.font = FontTitle;
        [cell addSubview:lblB];
        
        UIImageView *imgC = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 20*ProportionX)/2.0, progressView0.frame.origin.y + 50*ProportionX, 20*ProportionX, 20*ProportionX)];
        imgC.image = [UIImage imageNamed:@"节能_上月同比_减少"];
        [cell addSubview:imgC];
        
        UILabel *lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2.0, progressView0.frame.origin.y + progressView0.frame.size.width + 20*ProportionX, 1, 50*ProportionX)];
        lblLine2.backgroundColor = [UIColor colorWithRed:27/255.0 green:58/255.0 blue:68/255.0 alpha:1];
        [cell addSubview:lblLine2];
        
        UILabel *lbl00 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + 10*ProportionX, lblLine2.frame.origin.y, self.frame.size.width - 20*ProportionX - 10, 20*ProportionX)];
        lbl00.textColor = [UIColor colorWithRed:94/255.0 green:205/255.0 blue:255/255.0 alpha:1];
        lbl00.textAlignment = NSTextAlignmentLeft;
        lbl00.text = @"本月用电";
        [cell addSubview:lbl00];
        
        UILabel *lbl01 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + 10*ProportionX, lblLine2.frame.origin.y +25*ProportionX, self.frame.size.width - 20*ProportionX - 10, 20*ProportionX)];
        lbl01.textColor = [UIColor colorWithRed:94/255.0 green:205/255.0 blue:255/255.0 alpha:1];
        lbl01.textAlignment = NSTextAlignmentLeft;
        lbl01.text = @"上月用电";
        [cell addSubview:lbl01];
        
        UILabel *lblData00 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + 10*ProportionX + 70*ProportionX, lblLine2.frame.origin.y, self.frame.size.width - 20*ProportionX - 10, 20*ProportionX)];
        lblData00.textColor = [UIColor whiteColor];
        lblData00.textAlignment = NSTextAlignmentLeft;
        lblData00.text = @"100.6 kwh";
        [cell addSubview:lblData00];
        
        UILabel *lblData01 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + 10*ProportionX + 70*ProportionX, lblLine2.frame.origin.y +25*ProportionX, self.frame.size.width - 20*ProportionX - 10, 20*ProportionX)];
        lblData01.textColor = [UIColor whiteColor];
        lblData01.textAlignment = NSTextAlignmentLeft;
        lblData01.text = @"130.2 kwh";
        [cell addSubview:lblData01];
        
        
        UILabel *lbl10 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + 10*ProportionX + self.frame.size.width/2.0, lblLine2.frame.origin.y, self.frame.size.width - 20*ProportionX - 10, 20*ProportionX)];
        lbl10.textColor = [UIColor colorWithRed:94/255.0 green:205/255.0 blue:255/255.0 alpha:1];
        lbl10.textAlignment = NSTextAlignmentLeft;
        lbl10.text = @"本月电费";
        [cell addSubview:lbl10];
        
        UILabel *lbl11 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + 10*ProportionX + self.frame.size.width/2.0, lblLine2.frame.origin.y +25*ProportionX, self.frame.size.width - 20*ProportionX - 10, 20*ProportionX)];
        lbl11.textColor = [UIColor colorWithRed:94/255.0 green:205/255.0 blue:255/255.0 alpha:1];
        lbl11.textAlignment = NSTextAlignmentLeft;
        lbl11.text = @"上月电费";
        [cell addSubview:lbl11];
        
        UILabel *lblData10 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + 10*ProportionX + 70*ProportionX+ self.frame.size.width/2.0, lblLine2.frame.origin.y, self.frame.size.width - 20*ProportionX - 10, 20*ProportionX)];
        lblData10.textColor = [UIColor whiteColor];
        lblData10.textAlignment = NSTextAlignmentLeft;
        lblData10.text = @"￥130.2";
        [cell addSubview:lblData10];
        
        UILabel *lblData11 = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX + 10*ProportionX + 70*ProportionX+ self.frame.size.width/2.0, lblLine2.frame.origin.y +25*ProportionX, self.frame.size.width - 20*ProportionX - 10, 20*ProportionX)];
        lblData11.textColor = [UIColor whiteColor];
        lblData11.textAlignment = NSTextAlignmentLeft;
        lblData11.text = @"￥130.2";
        [cell addSubview:lblData11];
        
    } else if (indexPath.section == 3) {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
        lblTitle.font = FontL;
        lblTitle.text = @"功率曲线图";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lblTitle];
        
        btnRealTime = [[UIButton alloc] initWithFrame:CGRectMake(20*ProportionX, 48*ProportionX, 100*ProportionX, 22*ProportionX)];
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
        [cell addSubview:btnRealTime];
        
        btnYear = [[UIButton alloc] initWithFrame:CGRectMake(20*ProportionX +50*ProportionX*2, 48*ProportionX, 100*ProportionX, 22*ProportionX)];
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
        [cell addSubview:btnYear];
        
        btnDay = [[UIButton alloc] initWithFrame:CGRectMake(20*ProportionX +50*ProportionX*1, 48*ProportionX, 50*ProportionX, 22*ProportionX)];
        btnDay.layer.borderWidth = 1;
        btnDay.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnDay.layer.masksToBounds = YES;
        [btnDay setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
        [btnDay setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [btnDay setTitle:@"日" forState:UIControlStateNormal];
        [btnDay addTarget:self action:@selector(btnDayClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnDay];
        
        btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(20*ProportionX +50*ProportionX*2, 48*ProportionX, 50*ProportionX, 22*ProportionX)];
        btnMonth.layer.borderWidth = 1;
        btnMonth.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnMonth.layer.masksToBounds = YES;
        [btnMonth setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
        [btnMonth setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [btnMonth setTitle:@"月" forState:UIControlStateNormal];
        [btnMonth addTarget:self action:@selector(btnMonthClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnMonth];
        
        btnTime2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20*ProportionX - 90*ProportionX, 48*ProportionX, 90*ProportionX, 22*ProportionX)];
        btnTime2.layer.masksToBounds = YES;
        btnTime2.layer.masksToBounds = YES;
        btnTime2.layer.cornerRadius = 11*ProportionX;
        btnTime2.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnTime2.layer.borderWidth = 1;
        [btnTime2 setTitle:@"2018-08-02" forState:UIControlStateNormal];
        btnTime2.titleLabel.font = Font12;
        [btnTime2 addTarget:self action:@selector(btnTime2ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnTime2];
        
        NSArray *tempDataArrOfY2 = @[@[@"10",@"270",@"300",@"320",@"410",@"420",@"420",@"310",@"350",@"450"],@[@"20",@"290",@"400",@"420",@"510",@"520",@"520",@"410",@"550",@"550"],@[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"],@[@"30",@"470",@"550",@"560",@"630",@"640",@"660",@"620",@"710",@"740"]];
        
        LRSChartView *sChart = [[LRSChartView alloc]initWithFrame:CGRectMake(0, btnDay.frame.origin.y + btnDay.frame.size.height + 30, self.frame.size.width, 160*ProportionX)];
        
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
        [cell addSubview:sChart];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80*ProportionX, self.frame.size.width - 20, 160*ProportionX)];
        img2.image = [UIImage imageNamed:@"img001"];
        [cell addSubview:img2];
        
        UILabel *lblDataB = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX, 250*ProportionX, 50*ProportionX, 20*ProportionX)];
        lblDataB.textAlignment = NSTextAlignmentLeft;
        lblDataB.text = @"20kwh";
        lblDataB.textColor = [UIColor whiteColor];
        [cell addSubview:lblDataB];
        
        UILabel *lblDataG = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 20*ProportionX - 80*ProportionX, 250*ProportionX, 80*ProportionX, 20*ProportionX)];
        lblDataG.textAlignment = NSTextAlignmentRight;
        lblDataG.text = @"180kwh";
        lblDataG.textColor = [UIColor whiteColor];
        [cell addSubview:lblDataG];
        
        
        ProgressLineView *progressLine = [[ProgressLineView alloc] initWithFrame:CGRectMake(20*ProportionX, 280*ProportionX, self.frame.size.width - 40*ProportionX, 15*ProportionX)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, progressLine.frame.size.width, progressLine.frame.size.height)];
        label.textColor = [UIColor whiteColor];
        progressLine.progressValue = (20)/(20.0+180.0);
        progressLine.progressBackGroundColor = [UIColor colorWithRed:242/255.0 green:95/255.0 blue:50/255.0 alpha:1];
        progressLine.progressTintColor = [UIColor colorWithRed:235/255.0 green:192/255.0 blue:62/255.0 alpha:1];
        progressLine.progressCornerRadius = 0;
        progressLine.backgroundColor = [UIColor redColor];
        progressLine.layer.masksToBounds = YES;
        progressLine.layer.cornerRadius = 7.5*ProportionX;
        [progressLine insertSubview:label atIndex:0];//将label移动到最上面
        [cell addSubview:progressLine];
        
        UILabel *lblB = [[UILabel alloc] initWithFrame:CGRectMake(20*ProportionX, 305*ProportionX, 150*ProportionX, 20*ProportionX)];
        lblB.textAlignment = NSTextAlignmentLeft;
        lblB.text = @"来自电池(10%)";
        lblB.textColor = [UIColor colorWithRed:235/255.0 green:192/255.0 blue:62/255.0 alpha:1];;
        [cell addSubview:lblB];
        
        UILabel *lblG = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 20*ProportionX - 150*ProportionX, 305*ProportionX, 150*ProportionX, 20*ProportionX)];
        lblG.textAlignment = NSTextAlignmentRight;
        lblG.text = @"来自电网(90%)";
        lblG.textColor = [UIColor colorWithRed:242/255.0 green:95/255.0 blue:50/255.0 alpha:1];
        [cell addSubview:lblG];
    }
    
    return cell;
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

