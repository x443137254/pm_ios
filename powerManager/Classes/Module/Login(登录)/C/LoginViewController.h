//
//  LoginViewController.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/22.
//  Copyright © 2018年 tuolve. All rights reserved.
//

/**
   登陆中心控制器 控制登陆 注册 忘记密码相关的所有控制器
 */

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@protocol LoginViewControllerDelegate <NSObject>

/*! @brief 登陆中心控制器核心代理 用于控制控制器与界面之间的交互  */
- (void)btnClickWithTag:(NSString *)tag info:(UserInfoModel *)model;

@end

@interface LoginViewController : UIViewController

@end
