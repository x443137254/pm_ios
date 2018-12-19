//
//  HomeLineChartView.h
//  CCLineChart
//
//  Created by CC on 2018/5/6.
//  Copyright © 2018年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLineChartView : UIView

//Y轴标题
@property (nonatomic, strong) UILabel *lblTitleY;
//Y轴标题颜色颜色
@property (nonatomic, strong) UIColor *colorTitleY;
//X轴标题
@property (nonatomic, strong) UILabel *lblTitleX;
//X轴标题颜色
@property (nonatomic, strong) UIColor *colorTitleX;
//文字颜色X
@property (nonatomic, strong) UIColor *colorTextX;
//文字颜色Y
@property (nonatomic, strong) UIColor *colorTextY;
/** 点数据 */
@property (nonatomic,strong) NSArray *dataArrOfPoint;
/** Y轴坐标数据 */
@property (nonatomic, strong) NSArray *dataArrOfY;
/** X轴坐标数据 */
@property (nonatomic, strong) NSArray *dataArrOfX;
/** X轴线颜色 */
@property (nonatomic, strong) UIColor *colorLineX;
/** Y轴线颜色 */
@property (nonatomic, strong) UIColor *colorLineY;
/** 曲线颜色 */
@property (nonatomic, strong) UIColor *colorLine;
/** 渐变颜色top */
@property (nonatomic, strong) UIColor *colorGradientTop;
/** 渐变颜色center */
@property (nonatomic, strong) UIColor *colorGradientCenter;
/** 渐变颜色buttom */
@property (nonatomic, strong) UIColor *colorGradientButtom;

- (void)startDraw;

@end
