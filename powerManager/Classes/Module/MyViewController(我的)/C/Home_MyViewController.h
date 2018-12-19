//
//  Home_MyViewController.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol Home_MyViewControllerDelegate <NSObject>

- (void)btnClickWithTag:(NSString *)tag;

@end

@interface Home_MyViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;


@end
