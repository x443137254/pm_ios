//
//  DNTableViewCell.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/23.
//  Copyright © 2018年 tuolve. All rights reserved.
//

/**
   登陆界面中用到的cell
 */

#import <UIKit/UIKit.h>

@interface DNTableViewCell : UIView

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UITextField *textContent;
@property (nonatomic, strong) UILabel *lblMark;

@end
