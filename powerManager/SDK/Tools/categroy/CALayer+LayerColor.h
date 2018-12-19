//
//  CALayer+LayerColor.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/27.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (LayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
