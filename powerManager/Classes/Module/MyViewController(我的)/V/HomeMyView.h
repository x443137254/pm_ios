//
//  HomeMyView.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/4.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home_MyViewController.h"

@interface HomeMyView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) id<Home_MyViewControllerDelegate> customDelegate;

@end
