//
//  ATControllerManager.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/3.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATControllerManager : NSObject


+(instancetype)sharedInstance;


- (void)switchToLoginPage;


- (void)switchToHomePage;


@end
