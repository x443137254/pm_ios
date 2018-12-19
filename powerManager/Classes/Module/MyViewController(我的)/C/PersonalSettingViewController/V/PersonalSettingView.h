//
//  PersonalSettingView.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/5.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Home_MyViewController.h"

@interface PersonalSettingView : UIView

@property (nonatomic, strong) id<Home_MyViewControllerDelegate> customDelegate;

@property (nonatomic, strong) UITableView *tableView;

@end
