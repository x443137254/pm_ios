//
//  PersonalCenterModel.h
//  powerManager
//
//  Created by Dong Neil on 2018/8/24.
//  Copyright © 2018年 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PersonalCenterModel : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *accountType;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *registeredDate;
@property (nonatomic, copy) NSString *changePassword;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *email;

@end
