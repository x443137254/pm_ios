//
//  BindingRegistView.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BindingRegistViewController.h"
#import "UserInfoModel.h"

@interface BindingRegistView : UIView

@property (nonatomic, weak) id<BindingViewControllerDelegate> customDelegate;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UserInfoModel *model;

@end
