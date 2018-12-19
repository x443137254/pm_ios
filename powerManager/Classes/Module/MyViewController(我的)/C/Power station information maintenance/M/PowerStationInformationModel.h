//
//  PowerStationInformationModel.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/24.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PowerStationInformationModel : UIView

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *power;

@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *timeZone;
@property (nonatomic, copy) NSString *LAL;
@property (nonatomic, copy) NSString *subsidy;

@end
