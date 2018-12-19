//
//  EnergyReportView.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/25.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnergyReportView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblPower;
@property (weak, nonatomic) IBOutlet UILabel *lblCost;
@property (weak, nonatomic) IBOutlet UILabel *lblSubsidy;

- (void)updateView;

@end

NS_ASSUME_NONNULL_END
