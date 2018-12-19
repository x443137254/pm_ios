//
//  ConsumptionViewController.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConsumptionViewControllerDelegate <NSObject>

- (void)btnClickWithTag:(NSString *)tag;

@end

@interface ConsumptionViewController : UIViewController

@end
