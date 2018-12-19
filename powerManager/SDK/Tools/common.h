//
//  common.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Adapt.h"
#import "ProgressView.h"
#import "ProgressLineView.h"
#import "Toast+UIView.h"
#import "LRSChartView.h"
#import "CustomPieView.h"
#import "UIColor+Expanded.h"
#import "HomeLineChartView.h"
#import "LayerView.h"
#import <UMShare/UMShare.h>

//#import "YYKit.h"
#import "YYModel.h"

#import "stringColor.h"
#import "CFGradientLabel.h"
#import "String.h"
#import "Time.h"
#import "ArrToJSON.h"



#define iPhone4 (([[UIScreen mainScreen] bounds].size.height == 480) ? YES : NO)
#define iPhone5 (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)
#define iPhone6 (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define iPhone6Plus (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define iPhoneX (812 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)


//#define ProportionX ((float)[[UIScreen mainScreen] bounds].size.width / 375.0)
#define ProportionX ([common isPhone] ? ((float)[[UIScreen mainScreen] bounds].size.width / 375.0) : 1)

#define ProportionY ((float)[[UIScreen mainScreen] bounds].size.height / 667.0)



#define TOKEN  @"token"
#define USERINFO  @"userinfo"

/// RGB颜色(16进制)
#define RGB_HEX(rgbValue, a) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:(a)]

#define ColorContent [UIColor colorWithRed:124/255.0 green:183/255.0 blue:224/255.0 alpha:1]
#define ColorCustom [UIColor colorWithRed:90/255.0 green:193/255.0 blue:241/255.0 alpha:1];

@interface common : NSObject

+ (BOOL)isPhone;
+ (BOOL)isPad;

@end
