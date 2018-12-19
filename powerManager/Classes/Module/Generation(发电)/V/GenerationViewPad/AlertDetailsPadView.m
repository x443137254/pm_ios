//
//  AlertDetailsPadView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/11.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "AlertDetailsPadView.h"

@implementation AlertDetailsPadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:31/255.0 blue:40/255.0 alpha:1];
    }
    return self;
}

+ (void)loadViewWithModel:(GenerationModel *)model{
    
}

@end
