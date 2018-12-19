//
//  RegisterViewPad.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/26.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistterViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewPad : UIView

@property (nonatomic, weak) id<RegisterViewControllerDelegate> customDelegate;

@end

NS_ASSUME_NONNULL_END
