//
//  TCNavigationController.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/3.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCBaseViewControllerProtcol.h"

@interface TCNavigationController : UINavigationController<TCBaseViewControllerProtcol>


- (void)setNavigationPageList:(NSString *)pageList;
- (NSString *)getPageListString;
- (NSArray *)getPageList;


@end
