//
//  RegistterViewController.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/22.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@protocol RegisterViewControllerDelegate <NSObject>


/**
 注册中心控制器核心代理 用于控制控制器与界面之间的交互

 @param tag 标签 传递操作类型
 @param model 用户数据模型
 */
- (void)btnClickWithTag:(NSString *)tag info:(UserInfoModel *)model;

@end


/**
 注册界面控制器
 */
@interface RegistterViewController : UIViewController

@end
