//
//  ReportDetailsView.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/21.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ReportDetailsView : UIView

@property (nonatomic, strong) UITableView *tableView;

- (void)loadView;

@end

NS_ASSUME_NONNULL_END
