//
//  GenerationViewController.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GenerationViewControllerDelegate <NSObject>

- (void)btnClickWithTag:(NSString *)tag;

@end

@interface GenerationViewController : UIViewController

@end
