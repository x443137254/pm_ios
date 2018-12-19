//
//  CALayer+LayerColor.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/27.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
