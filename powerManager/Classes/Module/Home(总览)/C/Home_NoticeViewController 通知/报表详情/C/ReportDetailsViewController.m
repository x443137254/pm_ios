//
//  ReportDetailsViewController.m
//  powerManager
//
//  Created by Dong Neil on 2018/9/19.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "ReportDetailsViewController.h"
#import "common.h"
#import "NoticeInfo.h"

@interface ReportDetailsViewController ()

@property (nonatomic, strong) ReportDetailsView *RDV;

@end

@implementation ReportDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [NoticeInfo getNoticeInfo:@{@"noticeType":@"warning"} Success:^(id data) {
//        NSLog(@"======%@===== ",data);
//    }];
    if ([common isPhone])
    {
        self.title = @"报表详情";
        NSLog(@"isphone");
        UIImageView *imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imgBG.image = [UIImage imageNamed:@"bg"];
        [self.view addSubview:imgBG];

        if (!self.RDV) {
            self.RDV = [[ReportDetailsView alloc] init];
        }
        self.RDV.frame = CGRectMake(10, 64, self.view.frame.size.width -20, self.view.frame.size.height - 64);
        self.RDV.backgroundColor = RGB_HEX(0xffffff, 0);
        [self.RDV loadView];
        
        [self.view addSubview:self.RDV];

    }
    else if ([common isPad])
    {
        NSLog(@"isphone");
    }

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
