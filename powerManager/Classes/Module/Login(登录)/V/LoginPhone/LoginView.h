//
//  LoginView.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/22.
//  Copyright © 2018年 tuolve. All rights reserved.
//

/**
    登陆界面view视图层
 */

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface LoginView : UIView

@property (nonatomic, weak) id<LoginViewControllerDelegate> customDelegate;

@end
