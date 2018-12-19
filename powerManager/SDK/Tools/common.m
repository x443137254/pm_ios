//
//  common.m
//  powerManager
//
//  Created by Dong Neil on 2018/8/14.
//  Copyright © 2018 tuolve. All rights reserved.
//

#import "common.h"




@implementation common

+ (BOOL)isPhone{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isPad{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return YES;
    } else {
        return NO;
    }
}

@end
