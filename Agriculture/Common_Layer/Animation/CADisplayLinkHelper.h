//
//  CADisplayLinkHelper.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/7.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^CADisplayLinkHelperBlock)(CGFloat progress);

@interface CADisplayLinkHelper : NSObject


+ (void)runCADisplayLinkwithDuration:(NSTimeInterval)duration block:(CADisplayLinkHelperBlock)block;

@end
