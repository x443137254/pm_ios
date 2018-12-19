//
//  AppDelegate.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "AppDelegate.h"
#import "common.h"

#import "MainViewController.h"

#import "HomeViewController.h"
#import "GenerationViewController.h"
#import "ConsumptionViewController.h"
#import "AnalysisViewController.h"
#import "Home_MyViewController.h"
#import "IQKeyboardManager.h"

#import <UMCommon/UMCommon.h>




@interface AppDelegate () {
    Home_MyViewController *HMVC;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UMConfigure initWithAppkey:@"5b9a0fcf8f4a9d6c31000194" channel:@"pugongying"];

    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [self confitUShareSettings];
    [self configUSharePlatforms];
    
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
#pragma clang diagnostic pop
    [self SetRootViewController];
    return YES;
}

#pragma mark - UMSetting
- (void)confitUShareSettings{
    
    
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if ([common isPhone]) {
        return UIInterfaceOrientationMaskPortrait;
    } else if ([common isPad]) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

//设置主页面
-(void)SetRootViewController{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainViewController" bundle:nil];
    MainViewController *MVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    HomeViewController *TabBarItem1 = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    GenerationViewController *TabBarItem2 = [[GenerationViewController alloc]initWithNibName:@"GenerationViewController" bundle:nil];
    ConsumptionViewController *TabBarItem3 = [[ConsumptionViewController alloc]initWithNibName:@"ConsumptionViewController" bundle:nil];
    AnalysisViewController *TabBarItem4 = [[AnalysisViewController alloc]initWithNibName:@"AnalysisViewController" bundle:nil];
    
    UINavigationController * TabBarItem1Controller = [[UINavigationController alloc]initWithRootViewController:TabBarItem1];
    [TabBarItem1Controller.navigationBar setTintColor:[UIColor blackColor]];
    
    UINavigationController * TabBarItem2Controller = [[UINavigationController alloc]initWithRootViewController:TabBarItem2];
    [TabBarItem2Controller.navigationBar setTintColor:[UIColor blackColor]];
    
    UINavigationController * TabBarItem3Controller = [[UINavigationController alloc]initWithRootViewController:TabBarItem3];
    [TabBarItem3Controller.navigationBar setTintColor:[UIColor blackColor]];
    
    UINavigationController * TabBarItem4Controller = [[UINavigationController alloc]initWithRootViewController:TabBarItem4];
    [TabBarItem4Controller.navigationBar setTintColor:[UIColor blackColor]];

    HMVC = [[Home_MyViewController alloc] init];
    
    Home_MyViewController *TabBarItem5 = [[Home_MyViewController alloc] initWithNibName:@"Home_MyViewController" bundle:nil];
    UINavigationController * TabBarItem5Controller = [[UINavigationController alloc]initWithRootViewController:TabBarItem5];
    [TabBarItem5Controller.navigationBar setTintColor:[UIColor blackColor]];

    [MVC setViewControllers:@[TabBarItem1Controller, TabBarItem2Controller, TabBarItem3Controller, TabBarItem4Controller, TabBarItem5Controller]];
    
    if ([common isPhone]) {

        CKLeftSlideViewController *root = [[CKLeftSlideViewController alloc]initWithLeftVc:HMVC mainVc:MVC];
        self.leftSlideVc = root;
        self.window.rootViewController = root;
        [self.window makeKeyAndVisible];
    } else if ([common isPad]) {
      
        self.window.rootViewController = MVC;
        self.window.backgroundColor = [UIColor colorWithRed:(CGFloat) (4 / 255.0) green:(CGFloat) (43 / 255.0) blue:(CGFloat) (57 / 255.0) alpha:1];
        [self.window makeKeyAndVisible];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
