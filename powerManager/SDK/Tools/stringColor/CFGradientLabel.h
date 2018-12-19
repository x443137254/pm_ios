//
//  CFGradientLabel.h
//  text
//
//  Created by Dong Neil on 2018/9/14.
//  Copyright © 2018 neal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFGradientLabel : UILabel

@property(nonatomic, strong) NSArray* colors;


+ (CFGradientLabel *)addGradientLabelWithFrame:(CGPoint)point
                                  gradientText:(NSString *)text
                                      infoText:(NSString *)infoText
                                        colors:(NSArray *)colors
                                          font:(UIFont *)font;

@end
