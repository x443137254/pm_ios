//
//  HomeView.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "UserInfoModel.h"
#import "HomeViewModel.h"

@interface HomeView : UIView

@property (nonatomic, weak) id<HomeViewControllerDelegate> customDelegate;


- (instancetype)initWithFrame:(CGRect)frame;



/**
 通过模型数据刷新视图

 @param model 登录获取的模型数据
 */
- (void)loadViewWithModel:(UserInfoModel *)model;

@property (nonatomic, strong) UITableView *tableView;

@end
