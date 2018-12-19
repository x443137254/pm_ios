//
//  ThirdBindingView.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "UserInfoModel.h"

@interface ThirdBindingView : UIView

@property (nonatomic, weak) id<LoginViewControllerDelegate> customDelegate;

@property (nonatomic, strong) UserInfoModel *model;

- (void)loadView;

@end
