//
//  ClassificationManagementView.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/28.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassificationManagementView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *dataTotle;
@property (nonatomic, copy) NSString *progress;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *power;

- (void)loadView;

@end
