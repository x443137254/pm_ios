//
//  BindingRegistViewController.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@protocol BindingViewControllerDelegate <NSObject>

/*! @brief 登陆中心控制器核心代理 用于控制控制器与界面之间的交互  */
- (void)btnClickWithTag:(NSString *)tag info:(UserInfoModel *)model;

@end

@interface BindingRegistViewController : UIViewController

@property (nonatomic, strong) UserInfoModel *model;

@end
