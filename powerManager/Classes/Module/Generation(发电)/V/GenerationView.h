//
//  GenerationView.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenerationViewController.h"

@interface GenerationView : UIView

@property (nonatomic, weak) id<GenerationViewControllerDelegate> customDelegate;

@end
