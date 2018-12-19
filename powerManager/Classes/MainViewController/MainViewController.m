//
//  MainViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "MainViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SettingTabBar];

    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 加载手机底部tabbar （实际效果并没有用这个 是在每个控制器里面的footview 和leftview）
 */

-(void)SettingTabBar
{
//    // 添加通知监听见键盘弹出/退出
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];

//    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBG"]];
    UITabBarItem *tabbaritem1 = self.tabBar.items[0];
    UITabBarItem *tabbaritem2 = self.tabBar.items[1];
    UITabBarItem *tabbaritem3 = self.tabBar.items[2];
    UITabBarItem *tabbaritem4 = self.tabBar.items[3];
    UITabBarItem *tabbaritem5 = self.tabBar.items[4];

    tabbaritem1.selectedImage = [[UIImage imageNamed:@"总览_click"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbaritem1.image = [UIImage imageNamed:@"总览"];
    tabbaritem1.title = @"总览";

    tabbaritem2.selectedImage = [[UIImage imageNamed:@"发电_click"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbaritem2.image = [UIImage imageNamed:@"发电"];
    tabbaritem2.title = @"发电";


    tabbaritem3.selectedImage = [[UIImage imageNamed:@"能耗_click"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbaritem3.image = [UIImage imageNamed:@"能耗"];

    tabbaritem3.title = @"能耗";

    tabbaritem4.selectedImage = [[UIImage imageNamed:@"分析_click"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbaritem4.image = [UIImage imageNamed:@"分析"];
    tabbaritem4.title = @"分析";

    tabbaritem5.selectedImage = [[UIImage imageNamed:@"分析_click"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbaritem4.image = [UIImage imageNamed:@"分析"];
    tabbaritem4.title = @"我的";

    //    //设置选中字体颜色
    UIColor *Titlecolor = [UIColor blackColor];
    //[[UIColor alloc]initWithRed:0/255 green:156.0/255 blue:255.0/255 alpha:1];
    [tabbaritem1 setTitleTextAttributes:@{NSForegroundColorAttributeName :Titlecolor}
                               forState:UIControlStateSelected];
    [tabbaritem2 setTitleTextAttributes:@{NSForegroundColorAttributeName :Titlecolor}
                               forState:UIControlStateSelected];
    [tabbaritem3 setTitleTextAttributes:@{NSForegroundColorAttributeName :Titlecolor}
                               forState:UIControlStateSelected];
    [tabbaritem4  setTitleTextAttributes:@{NSForegroundColorAttributeName :Titlecolor}
                                forState:UIControlStateSelected];
    [tabbaritem5  setTitleTextAttributes:@{NSForegroundColorAttributeName :Titlecolor}
                                forState:UIControlStateSelected];

}


//// 键盘监听事件
//- (void)keyboardAction:(NSNotification*)sender{
//
//    // 通过通知对象获取键盘frame: [value CGRectValue]
//    NSDictionary *useInfo = [sender userInfo];
//    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    NSString *keyboardHeight = [NSString stringWithFormat:@"%f",[value CGRectValue].size.height];
//
//    [[NSUserDefaults standardUserDefaults] setObject:keyboardHeight forKey:@"KeyboardHeight"];
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"KeyboardHeight"]);
//
//}


@end
