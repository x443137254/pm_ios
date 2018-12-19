//
//  ConsumptionViewPad.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/8.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "ConsumptionViewPad.h"
#import "common.h"
#import "ClassificationManagementView.h"
#import "TLHeader.h"

@interface ConsumptionViewPad () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    
    UIButton *btnRealTime0;
    UIButton *btnDay0;
    UIButton *btnMonth0;
    UIButton *btnYear0;
    
    UIButton *btnDay1;
    UIButton *btnMonth1;
    UIButton *btnYear1;
    
    UIButton *btnRealTime2;
    UIButton *btnDay2;
    UIButton *btnMonth2;
    UIButton *btnYear2;
    
    UIButton *btnTime0;
    UIButton *btnTime1;
    UIButton *btnTime2;
    UIButton *btnTime3;
    
    NSArray *listCellHeight;
    
    UIView *costView;
    UIView *dataView;
    UIView *managerView;
    UIView *trendView;
}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@end

@implementation ConsumptionViewPad

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (void)loadView{

    
    if (self.frame.size.width < self.frame.size.height) {
        //竖屏
        trendView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 530/2.0)];
        costView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 878/2.0)];
        managerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 858/2.0)];
        dataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 550/2.0)];
        
        [self loadTrendView];
        [self loadCostView];
        [self loadDataView];
        [self loadManagerView];
        
        [self loadViewVertical];
    } else {
        //横屏
        trendView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 750/2.0, 530/2.0)];
        costView = [[UIView alloc] initWithFrame:CGRectMake(0, 560/2.0, 750/2.0, 878/2.0)];
        managerView = [[UIView alloc] initWithFrame:CGRectMake(780/2.0, 0, 1060/2.0, 858/2.0)];
        dataView = [[UIView alloc] initWithFrame:CGRectMake(780/2.0, 888/2.0, 1060/2.0, 550/2.0)];
        
        [self loadTrendView];
        [self loadCostView];
        [self loadDataView];
        [self loadManagerView];
        
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
        return trendView.frame.size.height;
    } else if (indexPath.section == 1) {
        return managerView.frame.size.height;
    } else if (indexPath.section == 2) {
        return dataView.frame.size.height;
    } else if (indexPath.section == 3) {
        return costView.frame.size.height;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	

    if (indexPath.section == 0) {
        [cell addSubview:trendView];
    } else if (indexPath.section == 1) {
        [cell addSubview:managerView];
    } else if (indexPath.section == 2) {
        [cell addSubview:dataView];
    } else if (indexPath.section == 3) {
        [cell addSubview:costView];
    }
    
    return cell;
}



#pragma mark- 横屏
//横屏
- (void)loadViewHorizontal{
    
    [self addSubview:trendView];
    [self addSubview:costView];
    [self addSubview:managerView];
    [self addSubview:dataView];
    
}

#pragma mark - 小块

/**
 电量趋势视图
 */
- (void)loadTrendView{
    //view添加内容
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, trendView.frame.size.width, 44)];
    lblTitle.font = [UIFont systemFontOfSize:20];
    lblTitle.text = @"电量趋势";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [trendView addSubview:lblTitle];
    
    btnRealTime0 = [[UIButton alloc] initWithFrame:CGRectMake(10, 38, 45, 22)];
    btnRealTime0.layer.masksToBounds = YES;
    btnRealTime0.layer.cornerRadius = 11;
    btnRealTime0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnRealTime0.layer.borderWidth = 1;
    [btnRealTime0 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:143/255.0 blue:231/255.0 alpha:1]];
    [btnRealTime0 setTitle:@"实时" forState:UIControlStateNormal];
    btnRealTime0.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnRealTime0 addTarget:self action:@selector(btnRealTime0ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [trendView addSubview:btnRealTime0];
    
    btnDay0 = [[UIButton alloc] initWithFrame:CGRectMake(10 +(45 + 10)*1, 38, 45, 22)];
    btnDay0.layer.masksToBounds = YES;
    btnDay0.layer.cornerRadius = 11;
    btnDay0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnDay0.layer.borderWidth = 1;
    [btnDay0 setBackgroundColor:[UIColor clearColor]];
    [btnDay0 setTitle:@"日" forState:UIControlStateNormal];
    [btnDay0 setTitleColor:[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] forState:UIControlStateNormal];
    btnDay0.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnDay0 addTarget:self action:@selector(btnDay0ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [trendView addSubview:btnDay0];
    
    btnMonth0 = [[UIButton alloc] initWithFrame:CGRectMake(10 +(45 + 10)*2, 38, 45, 22)];
    btnMonth0.layer.masksToBounds = YES;
    btnMonth0.layer.cornerRadius = 11;
    btnMonth0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnMonth0.layer.borderWidth = 1;
    [btnMonth0 setBackgroundColor:[UIColor clearColor]];
    [btnMonth0 setTitle:@"月" forState:UIControlStateNormal];
    [btnMonth0 setTitleColor:[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] forState:UIControlStateNormal];
    btnMonth0.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnMonth0 addTarget:self action:@selector(btnMonth0ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [trendView addSubview:btnMonth0];
    
    btnYear0 = [[UIButton alloc] initWithFrame:CGRectMake(10 +(45 + 10)*3, 38, 45, 22)];
    btnYear0.layer.masksToBounds = YES;
    btnYear0.layer.cornerRadius = 11;
    btnYear0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnYear0.layer.borderWidth = 1;
    [btnYear0 setBackgroundColor:[UIColor clearColor]];
    [btnYear0 setTitle:@"年" forState:UIControlStateNormal];
    [btnYear0 setTitleColor:[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] forState:UIControlStateNormal];
    btnYear0.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnYear0 addTarget:self action:@selector(btnYear0ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [trendView addSubview:btnYear0];
    
    btnTime0 = [[UIButton alloc] initWithFrame:CGRectMake(trendView.frame.size.width - 10 - 110, 38, 110, 22)];
    btnTime0.layer.masksToBounds = YES;
    btnTime0.layer.masksToBounds = YES;
    btnTime0.layer.cornerRadius = 11;
    btnTime0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnTime0.layer.borderWidth = 1;
    [btnTime0 setTitle:@"2018-08-02" forState:UIControlStateNormal];
    btnTime0.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnTime0 addTarget:self action:@selector(btnTime0ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [trendView addSubview:btnTime0];
    
    if (self.frame.size.width < self.frame.size.height) {
        btnRealTime0.frame = CGRectMake(100, 38, 45, 22);
        btnDay0.frame = CGRectMake(100 +(45 + 10)*1, 38, 45, 22);
        btnMonth0.frame = CGRectMake(100 +(45 + 10)*2, 38, 45, 22);
        btnYear0.frame = CGRectMake(100 +(45 + 10)*3, 38, 45, 22);
        btnTime0.frame = CGRectMake(trendView.frame.size.width - 100 - 110, 38, 110, 22);
    }
    
    HomeLineChartView *chart = [[HomeLineChartView alloc] initWithFrame:CGRectMake(0,70, trendView.frame.size.width, trendView.frame.size.height - 40)];
    chart.colorTitleY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart.colorTitleX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart.colorLineX = [UIColor colorWithRed:29/255.0 green:68/255.0 blue:78/255.0 alpha:0.6];
    chart.colorLine = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:1];
    chart.colorTextY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart.colorTextX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    
    chart.colorGradientTop = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0.6];
    chart.colorGradientCenter = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0.3];
    chart.colorGradientButtom = [UIColor colorWithRed:0/255.0 green:248/255.0 blue:111/255.0 alpha:0];
    
    
    chart.lblTitleY.text = @"kW";
    chart.lblTitleX.text = @"";
    chart.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:0];
    chart.dataArrOfY = @[@"800",@"600",@"400",@"200",@"0"];//Y轴坐标
    chart.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];//X轴坐标
    chart.dataArrOfPoint = @[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"];
    
    [chart startDraw];
    [trendView addSubview:chart];
}


/**
 设备消耗排名
 */
- (void)loadCostView{
    
    float ProportionXPad = 1;
    
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, costView.frame.size.width, costView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [costView addSubview:lblBG];
    
    UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, lblBG.frame.size.width / 2.0, 50)];
    [btn0 setTitle:@"分区消耗" forState:UIControlStateNormal];
    [btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [costView addSubview:btn0];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(lblBG.frame.size.width / 2.0, 0, lblBG.frame.size.width / 2.0, 50)];
    [btn1 setTitle:@"设备消耗排名" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:71/255.0 green:158/255.0 blue:198/255.0 alpha:1] forState:UIControlStateNormal];
    [costView addSubview:btn1];
    
    UILabel *lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, btn1.frame.size.height + btn1.frame.origin.y, costView.frame.size.width, 1)];
    lblLine.backgroundColor = [UIColor colorWithRed:2/255.0 green:66/255.0 blue:82/255.0 alpha:1];
    [costView addSubview:lblLine];
    
    UILabel *lblLineA = [[UILabel alloc] initWithFrame:CGRectMake(costView.frame.size.width/6.0, btn1.frame.size.height + btn1.frame.origin.y, costView.frame.size.width/6.0, 1)];
    lblLineA.backgroundColor = [UIColor whiteColor];
    [costView addSubview:lblLineA];
    
    btnRealTime2 = [[UIButton alloc] initWithFrame:CGRectMake(20, lblLine.frame.origin.y + 20, 100, 22)];
    btnRealTime2.layer.borderWidth = 1;
    btnRealTime2.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnRealTime2.layer.masksToBounds = YES;
    btnRealTime2.layer.cornerRadius = 11;
    [btnRealTime2 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRealTime2 setTitle:@"实时" forState:UIControlStateNormal];
    btnRealTime2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnRealTime2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btnRealTime2 addTarget:self action:@selector(btnRealTime2ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [costView addSubview:btnRealTime2];
    
    btnYear2 = [[UIButton alloc] initWithFrame:CGRectMake(20 +50*2, lblLine.frame.origin.y + 20, 100, 22)];
    btnYear2.layer.borderWidth = 1;
    btnYear2.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnYear2.layer.masksToBounds = YES;
    btnYear2.layer.cornerRadius = 11;
    [btnYear2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear2 setTitle:@"年" forState:UIControlStateNormal];
    btnYear2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnYear2.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [btnYear2 addTarget:self action:@selector(btnYear2ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [costView addSubview:btnYear2];
    
    btnDay2 = [[UIButton alloc] initWithFrame:CGRectMake(20 +50, lblLine.frame.origin.y + 20, 50, 22)];
    btnDay2.layer.borderWidth = 1;
    btnDay2.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnDay2.layer.masksToBounds = YES;
    [btnDay2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay2 setTitle:@"日" forState:UIControlStateNormal];
    [btnDay2 addTarget:self action:@selector(btnDay2ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [costView addSubview:btnDay2];
    
    btnMonth2 = [[UIButton alloc] initWithFrame:CGRectMake(20 +50*2, lblLine.frame.origin.y + 20, 50, 22)];
    btnMonth2.layer.borderWidth = 1;
    btnMonth2.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
    btnMonth2.layer.masksToBounds = YES;
    [btnMonth2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth2 setTitle:@"月" forState:UIControlStateNormal];
    [btnMonth2 addTarget:self action:@selector(btnMonth2ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [costView addSubview:btnMonth2];
    
    btnTime3 = [[UIButton alloc] initWithFrame:CGRectMake(costView.frame.size.width - 20*ProportionXPad - 110*ProportionXPad, lblLine.frame.origin.y + 20, 110*ProportionXPad, 22*ProportionXPad)];
    btnTime3.layer.masksToBounds = YES;
    btnTime3.layer.masksToBounds = YES;
    btnTime3.layer.cornerRadius = 11*ProportionXPad;
    btnTime3.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnTime3.layer.borderWidth = 1;
    [btnTime3 setTitle:@"2018-08-02" forState:UIControlStateNormal];
    btnTime3.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnTime3 addTarget:self action:@selector(btnTime3ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [costView addSubview:btnTime3];
    
    UILabel *lblTotol = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionXPad, btnDay2.frame.origin.y + btnDay2.frame.size.height + 20, 57*ProportionXPad, 15*ProportionXPad)];
    lblTotol.textAlignment = NSTextAlignmentLeft;
    lblTotol.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
    lblTotol.text = @"全部";
    [costView addSubview:lblTotol];
    
    UIImageView *imgTotol = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionXPad, lblTotol.frame.origin.y, costView.frame.size.width - 180, 15*ProportionXPad)];
    imgTotol.layer.masksToBounds = YES;
    imgTotol.layer.cornerRadius = 7.5*ProportionXPad;
    imgTotol.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
    [costView addSubview:imgTotol];
    
    UILabel *lblDataTotol = [[UILabel alloc] initWithFrame:CGRectMake(imgTotol.frame.origin.x + imgTotol.frame.size.width + 15*ProportionXPad, lblTotol.frame.origin.y, 70*ProportionXPad, 15*ProportionXPad)];
    lblDataTotol.textAlignment = NSTextAlignmentLeft;
    lblDataTotol.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
    lblDataTotol.text = @"3500kWh";
    lblDataTotol.font = [UIFont systemFontOfSize:14];
    [costView addSubview:lblDataTotol];
    
    UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionXPad, lblTotol.frame.size.height + lblTotol.frame.origin.y + 20, 57*ProportionXPad, 15*ProportionXPad)];
    lbl0.textAlignment = NSTextAlignmentLeft;
    lbl0.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
    lbl0.text = @"A栋";
    [costView addSubview:lbl0];
    
    UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionXPad, lbl0.frame.origin.y, (costView.frame.size.width - 180)*ProportionXPad*(1800/3500.0), 15*ProportionXPad)];
    img0.layer.masksToBounds = YES;
    img0.layer.cornerRadius = 7.5*ProportionXPad;
    img0.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
    [costView addSubview:img0];
    
    UILabel *lblData0 = [[UILabel alloc] initWithFrame:CGRectMake(img0.frame.origin.x + img0.frame.size.width + 15*ProportionXPad, lbl0.frame.origin.y, 70*ProportionXPad, 15*ProportionXPad)];
    lblData0.textAlignment = NSTextAlignmentLeft;
    lblData0.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
    lblData0.text = @"1800kWh";
    lblData0.font = [UIFont systemFontOfSize:14];
    [costView addSubview:lblData0];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionXPad, lbl0.frame.size.height + lbl0.frame.origin.y + 20, 57*ProportionXPad, 15*ProportionXPad)];
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
    lbl1.text = @"展厅";
    [costView addSubview:lbl1];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionXPad, lbl1.frame.origin.y, (costView.frame.size.width - 180)*ProportionXPad*(1000/3500.0), 15*ProportionXPad)];
    img1.layer.masksToBounds = YES;
    img1.layer.cornerRadius = 7.5*ProportionXPad;
    img1.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
    [costView addSubview:img1];
    
    UILabel *lblData1 = [[UILabel alloc] initWithFrame:CGRectMake(img1.frame.origin.x + img1.frame.size.width + 15*ProportionXPad, lbl1.frame.origin.y, 70*ProportionXPad, 15*ProportionXPad)];
    lblData1.textAlignment = NSTextAlignmentLeft;
    lblData1.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
    lblData1.text = @"1000kWh";
    lblData1.font = [UIFont systemFontOfSize:14];
    [costView addSubview:lblData1];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionXPad, lbl1.frame.size.height + lbl1.frame.origin.y + 20, 57*ProportionXPad, 15*ProportionXPad)];
    lbl2.textAlignment = NSTextAlignmentLeft;
    lbl2.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
    lbl2.text = @"B栋";
    [costView addSubview:lbl2];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionXPad, lbl2.frame.origin.y, (costView.frame.size.width - 180)*ProportionXPad*(700.0/3500.0), 15*ProportionXPad)];
    img2.layer.masksToBounds = YES;
    img2.layer.cornerRadius = 7.5*ProportionXPad;
    img2.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
    [costView addSubview:img2];
    
    UILabel *lblData2 = [[UILabel alloc] initWithFrame:CGRectMake(img2.frame.origin.x + img2.frame.size.width + 15*ProportionXPad, lbl2.frame.origin.y, 70*ProportionXPad, 15*ProportionXPad)];
    lblData2.textAlignment = NSTextAlignmentLeft;
    lblData2.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
    lblData2.text = @"700kWh";
    lblData2.font = [UIFont systemFontOfSize:14];
    [costView addSubview:lblData2];
    
    UIButton *btnMore = [[UIButton alloc] initWithFrame:CGRectMake((costView.frame.size.width - 80*ProportionXPad)/2.0, costView.frame.size.height - 50, 80, 40)];
    [btnMore setImage:[UIImage imageNamed:@"swicth"] forState:UIControlStateNormal];
    [btnMore setTitle:@"展开更多" forState:UIControlStateNormal];
    btnMore.titleLabel.font = [UIFont systemFontOfSize:16];
    //调整图片和文字上下显示
    btnMore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btnMore setTitleEdgeInsets:UIEdgeInsetsMake(-btnMore.imageView.frame.size.height ,-btnMore.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnMore setImageEdgeInsets:UIEdgeInsetsMake(+btnMore.imageView.frame.size.height + 10, 0.0,0.0, -btnMore.titleLabel.bounds.size.width)];
    [costView addSubview:btnMore];
    //view添加内容
   
}


/**
 分类管理
 */
- (void)loadManagerView{
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, managerView.frame.size.width, managerView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [managerView addSubview:lblBG];
    //view添加内容
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, managerView.frame.size.width, 44)];
    lblTitle.font = [UIFont systemFontOfSize:20];
    lblTitle.text = @"分类管理";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [managerView addSubview:lblTitle];
    
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(managerView.frame.size.width - 10 - 15 - 30, 15, 15, 15)];
    [btnAdd setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(btnAddClickAction) forControlEvents:UIControlEventTouchUpInside];
    [managerView addSubview:btnAdd];
    
    UIButton *btnDevice = [[UIButton alloc] initWithFrame:CGRectMake(managerView.frame.size.width/2.0 - 60, lblTitle.frame.origin.y + lblTitle.frame.size.height, 60, 30)];
    [btnDevice setTitle:@"设备" forState:UIControlStateNormal];
    [LayerView Button:btnDevice BackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] BorderWidth:1 BorderColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] Cor:0];
    [managerView addSubview:btnDevice];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btnDevice.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(25, 22)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = btnDevice.bounds;
    maskLayer.path = maskPath.CGPath;
    btnDevice.layer.mask = maskLayer;
    
    UIButton *btnCost = [[UIButton alloc] initWithFrame:CGRectMake(managerView.frame.size.width/2.0 , lblTitle.frame.origin.y + lblTitle.frame.size.height, 60, 30)];
    [btnCost setTitle:@"消耗" forState:UIControlStateNormal];
    [btnCost setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [LayerView Button:btnCost BackgroundColor:[UIColor clearColor] BorderWidth:1 BorderColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] Cor:0];
    [managerView addSubview:btnCost];
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:btnCost.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(25, 22)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc]init];
    maskLayer1.frame = btnCost.bounds;
    maskLayer1.path = maskPath1.CGPath;
    btnCost.layer.mask = maskLayer1;
    
    UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 180/2.0, managerView.frame.size.width, 1)];
    lblLine0.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:64/255.0 alpha:1];
    [managerView addSubview:lblLine0];
    
    ClassificationManagementView *CMV0 = [[ClassificationManagementView alloc] initWithFrame:CGRectMake(10, lblLine0.frame.origin.y, managerView.frame.size.width - 20, 226/2.0)];
    CMV0.title = @"空调";
    CMV0.dataTotle = @"20";
    CMV0.num = @"18";
    CMV0.power = @"30";
    [CMV0 loadView];
    [managerView addSubview:CMV0];
    
    UIButton *btnAC = [[UIButton alloc] initWithFrame:CGRectMake(0, CMV0.frame.origin.y, CMV0.frame.size.width, CMV0.frame.size.height)];
    [btnAC addTarget:self action:@selector(btnAClickAction) forControlEvents:UIControlEventTouchUpInside];
    [managerView addSubview:btnAC];
    
    UILabel *lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, lblLine0.frame.origin.y + 226/2.0, managerView.frame.size.width, 1)];
    lblLine1.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:64/255.0 alpha:1];
    [managerView addSubview:lblLine1];
    
    ClassificationManagementView *CMV1 = [[ClassificationManagementView alloc] initWithFrame:CGRectMake(10, lblLine1.frame.origin.y, managerView.frame.size.width - 20, 226/2.0)];
    CMV1.title = @"照明";
    CMV1.dataTotle = @"103";
    CMV1.num = @"62";
    CMV1.power = @"300";
    [CMV1 loadView];
    [managerView addSubview:CMV1];
    
    UILabel *lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, lblLine1.frame.origin.y + 226/2.0, managerView.frame.size.width, 1)];
    lblLine2.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:64/255.0 alpha:1];
    [managerView addSubview:lblLine2];
    
    ClassificationManagementView *CMV2 = [[ClassificationManagementView alloc] initWithFrame:CGRectMake(10, lblLine2.frame.origin.y, managerView.frame.size.width - 20, 226/2.0)];
    CMV2.title = @"充电桩";
    CMV2.dataTotle = @"8";
    CMV2.num = @"8";
    CMV2.power = @"2330.7";
    [CMV2 loadView];
    [managerView addSubview:CMV2];
}


/**
 实时数据
 */
- (void)loadDataView{
    //view添加内容
    
    UILabel *lblBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dataView.frame.size.width, dataView.frame.size.height)];
    lblBG.layer.masksToBounds = YES;
    lblBG.layer.cornerRadius = 5;
    lblBG.layer.borderWidth = 1;
    lblBG.layer.borderColor = [[UIColor colorWithRed: 2/255.0 green:80/255.0 blue:99/255.0 alpha:1] CGColor];
    lblBG.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    [dataView addSubview:lblBG];
    
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dataView.frame.size.width, 44)];
    lblTitle.font = [UIFont systemFontOfSize:20];
    lblTitle.text = @"实时数据";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [dataView addSubview:lblTitle];
    
    UIButton *btnWhole = [[UIButton alloc] initWithFrame:CGRectMake(20, 44, 100, 22)];
    btnWhole.layer.masksToBounds = YES;
    btnWhole.layer.cornerRadius = 11;
    btnWhole.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:142/255.0 blue:240/255.0 alpha:1] CGColor];
    btnWhole.layer.borderWidth = 1;
    [btnWhole setTitle:@"全部区域  " forState:UIControlStateNormal];
    btnWhole.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnWhole setImage:[UIImage imageNamed:@"drop"] forState:UIControlStateNormal];
    [btnWhole setTitleEdgeInsets:UIEdgeInsetsMake(0, -btnWhole.imageView.bounds.size.width, 0, btnWhole.imageView.bounds.size.width)];
    [btnWhole setImageEdgeInsets:UIEdgeInsetsMake(0, btnWhole.titleLabel.bounds.size.width, 0, -btnWhole.titleLabel.bounds.size.width)];
    [dataView addSubview:btnWhole];
    
    btnTime2 = [[UIButton alloc] initWithFrame:CGRectMake(dataView.frame.size.width - 10 - 110 - 40, 44, 110, 22)];
    btnTime2.layer.masksToBounds = YES;
    btnTime2.layer.masksToBounds = YES;
    btnTime2.layer.cornerRadius = 11;
    btnTime2.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
    btnTime2.layer.borderWidth = 1;
    [btnTime2 setTitle:@"2018-08-02" forState:UIControlStateNormal];
    btnTime2.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnTime2 addTarget:self action:@selector(btnTime2ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [dataView addSubview:btnTime2];
    
    UIButton *btnLast = [[UIButton alloc] initWithFrame:CGRectMake(btnTime2.frame.origin.x - 25 - 6, 44, 22, 22)];
    [btnLast setBackgroundImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
    [dataView addSubview:btnLast];
    
    UIButton *btnNext = [[UIButton alloc] initWithFrame:CGRectMake(btnTime2.frame.origin.x + btnTime2.frame.size.width + 6, 44, 22, 22)];
    [btnNext setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [dataView addSubview:btnNext];
    
    HomeLineChartView *chart = [[HomeLineChartView alloc] initWithFrame:CGRectMake(0,70, dataView.frame.size.width, dataView.frame.size.height - 70)];
    chart.colorTitleY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart.colorTitleX = [UIColor colorWithRed:129/255.0 green:107/255.0 blue:255/255.0 alpha:1];
    chart.colorLineX = [UIColor colorWithRed:29/255.0 green:68/255.0 blue:78/255.0 alpha:0.6];
    chart.colorTextY = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    chart.colorTextX = [UIColor colorWithRed:89/255.0 green:192/255.0 blue:239/255.0 alpha:1];
    
    chart.colorLine = [UIColor colorWithRed:129/255.0 green:107/255.0 blue:255/255.0 alpha:1];
    chart.colorGradientTop = [UIColor colorWithRed:129/255.0 green:107/255.0 blue:255/255.0 alpha:0.6];
    chart.colorGradientCenter = [UIColor colorWithRed:129/255.0 green:107/255.0 blue:255/255.0 alpha:0.3];
    chart.colorGradientButtom = [UIColor colorWithRed:129/255.0 green:107/255.0 blue:255/255.0 alpha:0];
    
    
    chart.lblTitleY.text = @"kW";
    chart.lblTitleX.text = @"功率 ——";
    chart.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:0];
    chart.dataArrOfY = @[@"800",@"600",@"400",@"200",@"0"];//Y轴坐标
    chart.dataArrOfX = @[@"6:00",@"6:10",@"6:20",@"6:30",@"6:40",@"6:50",@"7:00",@"7:10",@"7:20",@"7:30"];//X轴坐标
    chart.dataArrOfPoint = @[@"10",@"370",@"500",@"520",@"610",@"620",@"620",@"610",@"750",@"750"];
    
    [chart startDraw];
    [dataView addSubview:chart];
}

#pragma mark - 按钮方法
- (void)btnAClickAction{
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"AirCondition"];
//    }
}

- (void)btnAddClickAction{
//    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
//        [self.customDelegate btnClickWithTag:@"AddDevice"];
//    }
}

//实时、日月年 四个按钮
- (void)btnRealTime0ClickAction{
    
    [btnRealTime0 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDay0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnDay0ClickAction{
    
    [btnRealTime0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay0 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnDay0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMonth0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnMonth0ClickAction{
    
    [btnRealTime0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth0 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnMonth0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnYear0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnYear0ClickAction{
    [btnRealTime0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth0 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth0 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear0 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnYear0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}



- (void)btnDay1ClickAction{
    
    [btnDay1 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnDay1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMonth1 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth1 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear1 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear1 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnMonth1ClickAction{
    
    [btnDay1 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay1 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth1 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnMonth1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnYear1 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear1 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnYear1ClickAction{
    
    [btnDay1 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay1 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth1 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth1 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear1 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnYear1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

//实时、日月年 四个按钮
- (void)btnRealTime2ClickAction{
    
    [btnRealTime2 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnRealTime2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDay2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnDay2ClickAction{
    
    [btnRealTime2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay2 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnDay2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMonth2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnMonth2ClickAction{
    
    [btnRealTime2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth2 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnMonth2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnYear2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnYear2ClickAction{
    [btnRealTime2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnRealTime2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnDay2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear2 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnYear2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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

- (void)btnTime3ClickAction{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        
        [btnTime3 setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
    }];
}





@end
