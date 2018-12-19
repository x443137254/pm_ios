//
//  GenerationModel.h
//  powerManager
//
//  Created by Dong Neil on 2018/9/11.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenerationModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *power;
@property (nonatomic, copy) NSString *dailyEnergy;
@property (nonatomic, copy) NSString *totolEnergy;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *installData;

@end
