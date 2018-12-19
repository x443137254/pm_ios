//
//  LoginViewPad.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/26.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewPad : UIView

@property (nonatomic, weak) id<LoginViewControllerDelegate> customDelegate;

@end

NS_ASSUME_NONNULL_END
