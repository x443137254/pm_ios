//
//  ConsumptionView.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "ConsumptionView.h"
#import "common.h"
#import "ClassificationManagementView.h"
#import "TLHeader.h"

@interface ConsumptionView ()  <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    
    UIButton *btnRealTime0;
    UIButton *btnDay0;
    UIButton *btnMonth0;
    UIButton *btnYear0;
    
    UIButton *btnDay1;
    UIButton *btnMonth1;
    UIButton *btnYear1;
    
    UIButton *btnDay2;
    UIButton *btnMonth2;
    UIButton *btnYear2;
    
    UIButton *btnTime0;
    UIButton *btnTime1;
    UIButton *btnTime2;
    UIButton *btnTime3;
    
    NSArray *listCellHeight;

}

/** 出生年月 */
@property (nonatomic, strong) BRTextField *birthdayTF;

@end


@implementation ConsumptionView

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
    listCellHeight = @[@"250",@"270",@"270",@"370",@"270"];
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
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38*ProportionX)];
        lblTitle.font = FontL;
        lblTitle.text = @"电量趋势";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lblTitle];
        
        btnRealTime0 = [[UIButton alloc] initWithFrame:CGRectMake(10*ProportionX, 38*ProportionX, 45*ProportionX, 22*ProportionX)];
        btnRealTime0.layer.masksToBounds = YES;
        btnRealTime0.layer.cornerRadius = 11*ProportionX;
        btnRealTime0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnRealTime0.layer.borderWidth = 1;
        [btnRealTime0 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:143/255.0 blue:231/255.0 alpha:1]];
        [btnRealTime0 setTitle:@"实时" forState:UIControlStateNormal];
        btnRealTime0.titleLabel.font = Font12;
        [btnRealTime0 addTarget:self action:@selector(btnRealTime0ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnRealTime0];
        
        btnDay0 = [[UIButton alloc] initWithFrame:CGRectMake(10*ProportionX +(45 + 10)*ProportionX*1, 38*ProportionX, 45*ProportionX, 22*ProportionX)];
        btnDay0.layer.masksToBounds = YES;
        btnDay0.layer.cornerRadius = 11*ProportionX;
        btnDay0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnDay0.layer.borderWidth = 1;
        [btnDay0 setBackgroundColor:[UIColor clearColor]];
        [btnDay0 setTitle:@"日" forState:UIControlStateNormal];
        [btnDay0 setTitleColor:[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] forState:UIControlStateNormal];
        btnDay0.titleLabel.font = Font12;
        [btnDay0 addTarget:self action:@selector(btnDay0ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnDay0];
        
        btnMonth0 = [[UIButton alloc] initWithFrame:CGRectMake(10*ProportionX +(45 + 10)*ProportionX*2, 38*ProportionX, 45*ProportionX, 22*ProportionX)];
        btnMonth0.layer.masksToBounds = YES;
        btnMonth0.layer.cornerRadius = 11*ProportionX;
        btnMonth0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnMonth0.layer.borderWidth = 1;
        [btnMonth0 setBackgroundColor:[UIColor clearColor]];
        [btnMonth0 setTitle:@"月" forState:UIControlStateNormal];
        [btnMonth0 setTitleColor:[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] forState:UIControlStateNormal];
        btnMonth0.titleLabel.font = Font12;
        [btnMonth0 addTarget:self action:@selector(btnMonth0ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnMonth0];
        
        btnYear0 = [[UIButton alloc] initWithFrame:CGRectMake(10*ProportionX +(45 + 10)*ProportionX*3, 38*ProportionX, 45*ProportionX, 22*ProportionX)];
        btnYear0.layer.masksToBounds = YES;
        btnYear0.layer.cornerRadius = 11*ProportionX;
        btnYear0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnYear0.layer.borderWidth = 1;
        [btnYear0 setBackgroundColor:[UIColor clearColor]];
        [btnYear0 setTitle:@"年" forState:UIControlStateNormal];
        [btnYear0 setTitleColor:[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] forState:UIControlStateNormal];
        btnYear0.titleLabel.font = Font12;
        [btnYear0 addTarget:self action:@selector(btnYear0ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnYear0];
        
        btnTime0 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10*ProportionX - 90*ProportionX, 38*ProportionX, 90*ProportionX, 22*ProportionX)];
        btnTime0.layer.masksToBounds = YES;
        btnTime0.layer.masksToBounds = YES;
        btnTime0.layer.cornerRadius = 11*ProportionX;
        btnTime0.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnTime0.layer.borderWidth = 1;
        [btnTime0 setTitle:@"2018-08-02" forState:UIControlStateNormal];
        btnTime0.titleLabel.font = Font12;
        [btnTime0 addTarget:self action:@selector(btnTime0ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnTime0];
        
        HomeLineChartView *chart = [[HomeLineChartView alloc] initWithFrame:CGRectMake(10,btnDay0.frame.origin.y + btnDay0.frame.size.height + 10, self.frame.size.width - 20, 200*ProportionX)];
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
        [cell addSubview:chart];
        
    } else if (indexPath.section == 1) {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38*ProportionX)];
        lblTitle.font = FontL;
        lblTitle.text = @"分区消耗";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lblTitle];
        
        btnDay1 = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX, 38*ProportionX, 100*ProportionX, 22*ProportionX)];
        btnDay1.layer.borderWidth = 1;
        btnDay1.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnDay1.layer.masksToBounds = YES;
        btnDay1.layer.cornerRadius = 11*ProportionX;
        btnDay1.titleLabel.font = Font12;
        [btnDay1 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [btnDay1 setTitle:@"日" forState:UIControlStateNormal];
        btnDay1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnDay1.titleEdgeInsets = UIEdgeInsetsMake(0, 20*ProportionX, 0, 0);
        [btnDay1 addTarget:self action:@selector(btnDay1ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnDay1];
        
        btnYear1 = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX + 50*ProportionX, 38*ProportionX, 100*ProportionX, 22*ProportionX)];
        btnYear1.layer.borderWidth = 1;
        btnYear1.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnYear1.layer.masksToBounds = YES;
        btnYear1.layer.cornerRadius = 11*ProportionX;
        btnYear1.titleLabel.font = Font12;
        [btnYear1 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [btnYear1 setTitle:@"年" forState:UIControlStateNormal];
        btnYear1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btnYear1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20*ProportionX);
        [btnYear1 addTarget:self action:@selector(btnYear1ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnYear1];
        
        btnMonth1 = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX +50*ProportionX, 38*ProportionX, 50*ProportionX, 22*ProportionX)];
        btnMonth1.layer.borderWidth = 1;
        [btnMonth1 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
        btnMonth1.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnMonth1.layer.masksToBounds = YES;
        btnMonth1.titleLabel.font = Font12;
        [btnMonth1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnMonth1 setTitle:@"月" forState:UIControlStateNormal];
        [btnMonth1 addTarget:self action:@selector(btnMonth1ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnMonth1];
        
        btnTime1 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20*ProportionX - 90*ProportionX, 38*ProportionX, 90*ProportionX, 22*ProportionX)];
        btnTime1.layer.masksToBounds = YES;
        btnTime1.layer.masksToBounds = YES;
        btnTime1.layer.cornerRadius = 11*ProportionX;
        btnTime1.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnTime1.layer.borderWidth = 1;
        [btnTime1 setTitle:@"2018-08-02" forState:UIControlStateNormal];
        btnTime1.titleLabel.font = Font12;
        [btnTime1 addTarget:self action:@selector(btnTime1ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnTime1];
        
        UILabel *lblTotol = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionX, 86*ProportionX, 57*ProportionX, 15*ProportionX)];
        lblTotol.textAlignment = NSTextAlignmentLeft;
        lblTotol.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblTotol.text = @"全部";
        [cell addSubview:lblTotol];
        
        UIImageView *imgTotol = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionX, 86*ProportionX, 221*ProportionX, 15*ProportionX)];
        imgTotol.layer.masksToBounds = YES;
        imgTotol.layer.cornerRadius = 7.5*ProportionX;
        imgTotol.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
        [cell addSubview:imgTotol];
        
        UILabel *lblDataTotol = [[UILabel alloc] initWithFrame:CGRectMake(imgTotol.frame.origin.x + imgTotol.frame.size.width + 15*ProportionX, 86*ProportionX, 70*ProportionX, 15*ProportionX)];
        lblDataTotol.textAlignment = NSTextAlignmentLeft;
        lblDataTotol.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblDataTotol.text = @"3500kWh";
        lblDataTotol.font = Font12;
        [cell addSubview:lblDataTotol];
        
        UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionX, 86*ProportionX + 34*ProportionX, 57*ProportionX, 15*ProportionX)];
        lbl0.textAlignment = NSTextAlignmentLeft;
        lbl0.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lbl0.text = @"A栋";
        [cell addSubview:lbl0];
        
        UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionX, 86*ProportionX + 34*ProportionX, 221*ProportionX*(1800/3500.0), 15*ProportionX)];
        img0.layer.masksToBounds = YES;
        img0.layer.cornerRadius = 7.5*ProportionX;
        img0.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
        [cell addSubview:img0];
        
        UILabel *lblData0 = [[UILabel alloc] initWithFrame:CGRectMake(img0.frame.origin.x + img0.frame.size.width + 15*ProportionX, 86*ProportionX + 34*ProportionX, 70*ProportionX, 15*ProportionX)];
        lblData0.textAlignment = NSTextAlignmentLeft;
        lblData0.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblData0.text = @"1800kWh";
        lblData0.font = Font12;
        [cell addSubview:lblData0];
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionX, 86*ProportionX +34*ProportionX*2, 57*ProportionX, 15*ProportionX)];
        lbl1.textAlignment = NSTextAlignmentLeft;
        lbl1.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lbl1.text = @"展厅";
        [cell addSubview:lbl1];
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionX, 86*ProportionX+34*ProportionX*2, 221*ProportionX*(1000/3500.0), 15*ProportionX)];
        img1.layer.masksToBounds = YES;
        img1.layer.cornerRadius = 7.5*ProportionX;
        img1.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
        [cell addSubview:img1];
        
        UILabel *lblData1 = [[UILabel alloc] initWithFrame:CGRectMake(img1.frame.origin.x + img1.frame.size.width + 15*ProportionX, 86*ProportionX +34*ProportionX*2, 70*ProportionX, 15*ProportionX)];
        lblData1.textAlignment = NSTextAlignmentLeft;
        lblData1.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblData1.text = @"1000kWh";
        lblData1.font = Font12;
        [cell addSubview:lblData1];
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionX, 86*ProportionX+34*ProportionX*3, 57*ProportionX, 15*ProportionX)];
        lbl2.textAlignment = NSTextAlignmentLeft;
        lbl2.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lbl2.text = @"B栋";
        [cell addSubview:lbl2];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionX, 86*ProportionX+34*ProportionX*3, 221*ProportionX*(700.0/3500.0), 15*ProportionX)];
        img2.layer.masksToBounds = YES;
        img2.layer.cornerRadius = 7.5*ProportionX;
        img2.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
        [cell addSubview:img2];
        
        UILabel *lblData2 = [[UILabel alloc] initWithFrame:CGRectMake(img2.frame.origin.x + img2.frame.size.width + 15*ProportionX, 86*ProportionX+34*ProportionX*3, 70*ProportionX, 15*ProportionX)];
        lblData2.textAlignment = NSTextAlignmentLeft;
        lblData2.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblData2.text = @"700kWh";
        lblData2.font = Font12;
        [cell addSubview:lblData2];
        
        UIButton *btnMore = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 80*ProportionX)/2.0, 86*ProportionX+34*ProportionX*4, 80*ProportionX, 40*ProportionX)];
        [btnMore setImage:[UIImage imageNamed:@"swicth"] forState:UIControlStateNormal];
        [btnMore setTitle:@"展开更多" forState:UIControlStateNormal];
        btnMore.titleLabel.font = Font14;
        //调整图片和文字上下显示
        btnMore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btnMore setTitleEdgeInsets:UIEdgeInsetsMake(-btnMore.imageView.frame.size.height ,-btnMore.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnMore setImageEdgeInsets:UIEdgeInsetsMake(+btnMore.imageView.frame.size.height + 10, 0.0,0.0, -btnMore.titleLabel.bounds.size.width)];
        [cell addSubview:btnMore];

    } else if (indexPath.section == 2) {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38*ProportionX)];
        lblTitle.font = FontL;
        lblTitle.text = @"实时数据";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lblTitle];
        
        UIButton *btnWhole = [[UIButton alloc] initWithFrame:CGRectMake(20*ProportionX, 40*ProportionX, 89*ProportionX, 25*ProportionX)];
        btnWhole.layer.masksToBounds = YES;
        btnWhole.layer.cornerRadius = 12.5*ProportionX;
        btnWhole.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:142/255.0 blue:240/255.0 alpha:1] CGColor];
        btnWhole.layer.borderWidth = 1;
        [btnWhole setTitle:@"全部区域  " forState:UIControlStateNormal];
        btnWhole.titleLabel.font = FontS;
        [btnWhole setImage:[UIImage imageNamed:@"drop"] forState:UIControlStateNormal];
        [btnWhole setTitleEdgeInsets:UIEdgeInsetsMake(0, -btnWhole.imageView.bounds.size.width, 0, btnWhole.imageView.bounds.size.width)];
        [btnWhole setImageEdgeInsets:UIEdgeInsetsMake(0, btnWhole.titleLabel.bounds.size.width, 0, -btnWhole.titleLabel.bounds.size.width)];
        [cell addSubview:btnWhole];
        
        btnTime2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10*ProportionX - 90*ProportionX - 40*ProportionX, 38*ProportionX, 90*ProportionX, 25*ProportionX)];
        btnTime2.layer.masksToBounds = YES;
        btnTime2.layer.masksToBounds = YES;
        btnTime2.layer.cornerRadius = 12.5*ProportionX;
        btnTime2.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnTime2.layer.borderWidth = 1;
        [btnTime2 setTitle:@"2018-08-02" forState:UIControlStateNormal];
        btnTime2.titleLabel.font = Font12;
        [btnTime2 addTarget:self action:@selector(btnTime2ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnTime2];
        
        UIButton *btnLast = [[UIButton alloc] initWithFrame:CGRectMake(btnTime2.frame.origin.x - 25*ProportionX - 6*ProportionX, 38*ProportionX, 25*ProportionX, 25*ProportionX)];
        [btnLast setBackgroundImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
        [cell addSubview:btnLast];
        
        UIButton *btnNext = [[UIButton alloc] initWithFrame:CGRectMake(btnTime2.frame.origin.x + btnTime2.frame.size.width + 6*ProportionX, 38*ProportionX, 25*ProportionX, 25*ProportionX)];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [cell addSubview:btnNext];
        
        HomeLineChartView *chart = [[HomeLineChartView alloc] initWithFrame:CGRectMake(10,btnTime2.frame.size.height + btnTime2.frame.origin.y + 10, self.frame.size.width - 20, 200*ProportionX)];
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
        [cell addSubview:chart];
        
    } else if (indexPath.section == 3) {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45*ProportionX)];
        lblTitle.font = FontL;
        lblTitle.text = @"分类管理";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lblTitle];
        
        UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 - 15*ProportionX - 30*ProportionX, 15*ProportionX, 15*ProportionX, 15*ProportionX)];
        [btnAdd setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [btnAdd addTarget:self action:@selector(btnAddClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnAdd];
        
        UILabel *lblLine0 = [[UILabel alloc] initWithFrame:CGRectMake(10, 45*ProportionX, self.frame.size.width - 20, 1)];
        lblLine0.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:64/255.0 alpha:1];
        [cell addSubview:lblLine0];
        
        ClassificationManagementView *CMV0 = [[ClassificationManagementView alloc] initWithFrame:CGRectMake(10, 45*ProportionX, self.frame.size.width - 20, 105*ProportionX)];
        CMV0.title = @"空调";
        CMV0.dataTotle = @"20";
        CMV0.num = @"18";
        CMV0.power = @"30";
        [CMV0 loadView];
        [cell addSubview:CMV0];
        
        UIButton *btnAC = [[UIButton alloc] initWithFrame:CGRectMake(10, 45*ProportionX, self.frame.size.width - 20, 105*ProportionX)];
        [btnAC addTarget:self action:@selector(btnAClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnAC];
        
        ClassificationManagementView *CMV1 = [[ClassificationManagementView alloc] initWithFrame:CGRectMake(10, 45*ProportionX + 105*ProportionX, self.frame.size.width - 20, 105*ProportionX)];
        CMV1.title = @"照明";
        CMV1.dataTotle = @"103";
        CMV1.num = @"62";
        CMV1.power = @"300";
        [CMV1 loadView];
        [cell addSubview:CMV1];
        
        ClassificationManagementView *CMV2 = [[ClassificationManagementView alloc] initWithFrame:CGRectMake(10, 45*ProportionX + 105*ProportionX*2, self.frame.size.width - 20, 105*ProportionX)];
        CMV2.title = @"充电桩";
        CMV2.dataTotle = @"8";
        CMV2.num = @"8";
        CMV2.power = @"2330.7";
        [CMV2 loadView];
        [cell addSubview:CMV2];
        
        UILabel *lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 45*ProportionX +105*ProportionX, self.frame.size.width - 20, 1)];
        lblLine1.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:64/255.0 alpha:1];
        [cell addSubview:lblLine1];
        
        UILabel *lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 45*ProportionX+210*ProportionX, self.frame.size.width - 20, 1)];
        lblLine2.backgroundColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:64/255.0 alpha:1];
        [cell addSubview:lblLine2];
        
        
    } else if (indexPath.section == 4) {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38*ProportionX)];
        lblTitle.font = FontL;
        lblTitle.text = @"设备消耗排名";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lblTitle];
        
        btnDay2 = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX, 38*ProportionX, 100*ProportionX, 22*ProportionX)];
        btnDay2.layer.borderWidth = 1;
        btnDay2.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnDay2.layer.masksToBounds = YES;
        btnDay2.layer.cornerRadius = 11*ProportionX;
        btnDay2.titleLabel.font = Font12;
        [btnDay2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [btnDay2 setTitle:@"日" forState:UIControlStateNormal];
        btnDay2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnDay2.titleEdgeInsets = UIEdgeInsetsMake(0, 20*ProportionX, 0, 0);
        [btnDay2 addTarget:self action:@selector(btnDay2ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnDay2];
        
        btnYear2 = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX + 50*ProportionX, 38*ProportionX, 100*ProportionX, 22*ProportionX)];
        btnYear2.layer.borderWidth = 1;
        btnYear2.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnYear2.layer.masksToBounds = YES;
        btnYear2.layer.cornerRadius = 11*ProportionX;
        btnYear2.titleLabel.font = Font12;
        [btnYear2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [btnYear2 setTitle:@"年" forState:UIControlStateNormal];
        btnYear2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btnYear2.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20*ProportionX);
        [btnYear2 addTarget:self action:@selector(btnYear2ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnYear2];
        
        btnMonth2 = [[UIButton alloc] initWithFrame:CGRectMake(10 +6*ProportionX +50*ProportionX, 38*ProportionX, 50*ProportionX, 22*ProportionX)];
        btnMonth2.layer.borderWidth = 1;
        [btnMonth2 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
        btnMonth2.layer.borderColor = [[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] CGColor];
        btnMonth2.layer.masksToBounds = YES;
        btnMonth2.titleLabel.font = Font12;
        [btnMonth2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnMonth2 setTitle:@"月" forState:UIControlStateNormal];
        [btnMonth2 addTarget:self action:@selector(btnMonth2ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnMonth2];
        
        btnTime3 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20*ProportionX - 90*ProportionX, 38*ProportionX, 90*ProportionX, 22*ProportionX)];
        btnTime3.layer.masksToBounds = YES;
        btnTime3.layer.masksToBounds = YES;
        btnTime3.layer.cornerRadius = 11*ProportionX;
        btnTime3.layer.borderColor = [[UIColor colorWithRed:5/255.0 green:135/255.0 blue:229/255.0 alpha:1] CGColor];
        btnTime3.layer.borderWidth = 1;
        [btnTime3 setTitle:@"2018-08-02" forState:UIControlStateNormal];
        btnTime3.titleLabel.font = Font12;
        [btnTime3 addTarget:self action:@selector(btnTime3ClickAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnTime3];
        
        UILabel *lblTotol = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionX, 86*ProportionX, 57*ProportionX, 15*ProportionX)];
        lblTotol.textAlignment = NSTextAlignmentLeft;
        lblTotol.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblTotol.text = @"全部";
        [cell addSubview:lblTotol];
        
        UIImageView *imgTotol = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionX, 86*ProportionX, 221*ProportionX, 15*ProportionX)];
        imgTotol.layer.masksToBounds = YES;
        imgTotol.layer.cornerRadius = 7.5*ProportionX;
        imgTotol.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
        [cell addSubview:imgTotol];
        
        UILabel *lblDataTotol = [[UILabel alloc] initWithFrame:CGRectMake(imgTotol.frame.origin.x + imgTotol.frame.size.width + 15*ProportionX, 86*ProportionX, 70*ProportionX, 15*ProportionX)];
        lblDataTotol.textAlignment = NSTextAlignmentLeft;
        lblDataTotol.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblDataTotol.text = @"3500kWh";
        lblDataTotol.font = Font12;
        [cell addSubview:lblDataTotol];
        
        UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionX, 86*ProportionX + 34*ProportionX, 57*ProportionX, 15*ProportionX)];
        lbl0.textAlignment = NSTextAlignmentLeft;
        lbl0.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lbl0.text = @"A栋";
        [cell addSubview:lbl0];
        
        UIImageView *img0 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionX, 86*ProportionX + 34*ProportionX, 221*ProportionX*(1800/3500.0), 15*ProportionX)];
        img0.layer.masksToBounds = YES;
        img0.layer.cornerRadius = 7.5*ProportionX;
        img0.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
        [cell addSubview:img0];
        
        UILabel *lblData0 = [[UILabel alloc] initWithFrame:CGRectMake(img0.frame.origin.x + img0.frame.size.width + 15*ProportionX, 86*ProportionX + 34*ProportionX, 70*ProportionX, 15*ProportionX)];
        lblData0.textAlignment = NSTextAlignmentLeft;
        lblData0.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblData0.text = @"1800kWh";
        lblData0.font = Font12;
        [cell addSubview:lblData0];
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionX, 86*ProportionX +34*ProportionX*2, 57*ProportionX, 15*ProportionX)];
        lbl1.textAlignment = NSTextAlignmentLeft;
        lbl1.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lbl1.text = @"展厅";
        [cell addSubview:lbl1];
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionX, 86*ProportionX+34*ProportionX*2, 221*ProportionX*(1000/3500.0), 15*ProportionX)];
        img1.layer.masksToBounds = YES;
        img1.layer.cornerRadius = 7.5*ProportionX;
        img1.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
        [cell addSubview:img1];
        
        UILabel *lblData1 = [[UILabel alloc] initWithFrame:CGRectMake(img1.frame.origin.x + img1.frame.size.width + 15*ProportionX, 86*ProportionX +34*ProportionX*2, 70*ProportionX, 15*ProportionX)];
        lblData1.textAlignment = NSTextAlignmentLeft;
        lblData1.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblData1.text = @"1000kWh";
        lblData1.font = Font12;
        [cell addSubview:lblData1];
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 10*ProportionX, 86*ProportionX+34*ProportionX*3, 57*ProportionX, 15*ProportionX)];
        lbl2.textAlignment = NSTextAlignmentLeft;
        lbl2.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lbl2.text = @"B栋";
        [cell addSubview:lbl2];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10+63*ProportionX, 86*ProportionX+34*ProportionX*3, 221*ProportionX*(700.0/3500.0), 15*ProportionX)];
        img2.layer.masksToBounds = YES;
        img2.layer.cornerRadius = 7.5*ProportionX;
        img2.backgroundColor = [UIColor colorWithRed:197/255.0 green:110/255.0 blue:11/255.0 alpha:1];
        [cell addSubview:img2];
        
        UILabel *lblData2 = [[UILabel alloc] initWithFrame:CGRectMake(img2.frame.origin.x + img2.frame.size.width + 15*ProportionX, 86*ProportionX+34*ProportionX*3, 70*ProportionX, 15*ProportionX)];
        lblData2.textAlignment = NSTextAlignmentLeft;
        lblData2.textColor = [UIColor colorWithRed:87/255.0 green:187/255.0 blue:234/255.0 alpha:1];
        lblData2.text = @"700kWh";
        lblData2.font = Font12;
        [cell addSubview:lblData2];
        
        UIButton *btnMore = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 80*ProportionX)/2.0, 86*ProportionX+34*ProportionX*4, 80*ProportionX, 40*ProportionX)];
        [btnMore setImage:[UIImage imageNamed:@"swicth"] forState:UIControlStateNormal];
        [btnMore setTitle:@"展开更多" forState:UIControlStateNormal];
        btnMore.titleLabel.font = Font14;
        //调整图片和文字上下显示
        btnMore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btnMore setTitleEdgeInsets:UIEdgeInsetsMake(-btnMore.imageView.frame.size.height ,-btnMore.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnMore setImageEdgeInsets:UIEdgeInsetsMake(+btnMore.imageView.frame.size.height + 10, 0.0,0.0, -btnMore.titleLabel.bounds.size.width)];
        [cell addSubview:btnMore];
    }
    
    
    
    return cell;
}

- (void)btnAClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"AirCondition"];
    }
}

- (void)btnAddClickAction{
    if ([self.customDelegate respondsToSelector:@selector(btnClickWithTag:)]) {
        [self.customDelegate btnClickWithTag:@"AddDevice"];
    }
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

- (void)btnDay2ClickAction{
    
    [btnDay2 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnDay2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMonth2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnMonth2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnYear2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnMonth2ClickAction{
    
    [btnDay2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnDay2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnMonth2 setBackgroundColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1]];
    [btnMonth2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnYear2 setBackgroundColor:[UIColor colorWithRed:1/255.0 green:34/255.0 blue:44/255.0 alpha:1]];
    [btnYear2 setTitleColor:[UIColor colorWithRed:4/255.0 green:120/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)btnYear2ClickAction{
    
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
