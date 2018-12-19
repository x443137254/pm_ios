//
//  EnergyReportView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/25.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "EnergyReportView.h"
#import "common.h"

@interface EnergyReportView () {
    CustomPieView *chartView;

    NSMutableArray *segmentDataArray;

    NSMutableArray *segmentTitleArray;

    NSMutableArray *segmentColorArray;

}

@property (weak, nonatomic) IBOutlet UILabel *lblTips0;
@property (weak, nonatomic) IBOutlet UILabel *lblTips1;

@end

@implementation EnergyReportView

- (void)updateView{
    self.lblTips0.layer.masksToBounds = YES;
    self.lblTips0.layer.cornerRadius = 5;

    self.lblTips1.layer.masksToBounds = YES;
    self.lblTips1.layer.cornerRadius = 5;

    [self loadPieData];
    [self loadPieChartView];
}

- (void)loadPieData
{

    segmentDataArray = [@[@"276543", @"600000"] mutableCopy];

    //    segmentTitleArray = [NSMutableArray arrayWithObjects:@"上网电量",@"自消耗", nil];

    segmentColorArray = [@[RGB_HEX(0x0fffc4, 1), RGB_HEX(0x1975f2, 1)] mutableCopy];

    self.backgroundColor = [UIColor clearColor];
}

- (void)loadPieChartView
{
    //包含文本的视图frame
    chartView = [[CustomPieView alloc]initWithFrame:CGRectMake(10, 53, 80, 80)];


    //数据源
    chartView.segmentDataArray = segmentDataArray;

    //颜色数组，若不传入，则为随即色
    chartView.segmentColorArray = segmentColorArray;

    //标题，若不传入，则为“其他”
    chartView.segmentTitleArray = segmentTitleArray;

    //动画时间
    chartView.animateTime = 1.0;

    //内圆的颜色
    chartView.innerColor = [UIColor clearColor];

    //内圆的半径
    chartView.innerCircleR = 0;

    //大圆的半径
    chartView.pieRadius = 40;

    //整体饼状图的背景色
    chartView.backgroundColor = RGB_HEX(0xffffff, 0);

    //圆心位置，此属性会被centerXPosition、centerYPosition覆盖，圆心优先使用centerXPosition、centerYPosition
    chartView.centerType = PieCenterTypeTopMiddle;

    //是否动画
//    chartView.needAnimation = YES;

    //动画类型，全部只有一个动画；各个部分都有动画
    chartView.type = PieAnimationTypeTogether;

    //圆心，相对于饼状图的位置
    chartView.centerXPosition = 40;

    //隐藏右侧的文本
    chartView.hideText = YES;

    //点击触发的block，index与数据源对应
    [chartView clickPieView:^(NSInteger index) {
        NSLog(@"Click Index:%li",(long)index);
    }];

    //添加到视图上
    [chartView showCustomViewInSuperView:self];

    //设置默认选中的index，如不需要该属性，可注释
    //    [chartView setSelectedIndex:15];

}

@end
