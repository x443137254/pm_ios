//
//  AnalysisView.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/15.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalysisViewController.h"


@interface AnalysisView : UIView

@property (nonatomic, weak) id<AnalysisViewControllerDelegate> customDelegate;

@end
