//
//  TotolReportView.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/25.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "TotolReportView.h"

@interface TotolReportView ()
@property (weak, nonatomic) IBOutlet UIButton *btnLJFD;
@property (weak, nonatomic) IBOutlet UIButton *btnLJYD;
@property (weak, nonatomic) IBOutlet UILabel *lblDLJFD;
@property (weak, nonatomic) IBOutlet UILabel *lblDLJYD;
@property (weak, nonatomic) IBOutlet UILabel *lblLJFD;
@property (weak, nonatomic) IBOutlet UILabel *lblLJYD;

@end

@implementation TotolReportView

- (void)updateView{
    self.btnLJFD.center = CGPointMake(self.frame.size.width/4.0, 68);
    self.btnLJYD.center = CGPointMake(self.frame.size.width/4.0 * 3, 68);
    self.lblDLJFD.center = CGPointMake(self.frame.size.width/4.0, 68 + 40);
    self.lblDLJYD.center = CGPointMake(self.frame.size.width/4.0 * 3, 68+40);
    self.lblLJFD.center = CGPointMake(self.frame.size.width/4.0, 68+40+30);
    self.lblLJYD.center = CGPointMake(self.frame.size.width/4.0 * 3, 68+40+30);
}

@end
