//
//  TCBaseViewController.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/2.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCBaseViewControllerProtcol.h"

/**
 *  基类控制器
 */

@interface TCBaseViewController : UIViewController


/**
 *  不同页面跳转传的参数
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)getParams;
- (void)setPageParams:(NSDictionary *)params;


//设置页面id
- (void)setPageId:(NSInteger)pageId;
//获取页面id
- (NSInteger)getPageId;


//设置属于的栈id
- (void)setStackId:(NSInteger)nStackId;
//得到属于的栈id
- (NSInteger)getStackId;



- (void)showLoadView:(NSString *)tip;
- (void)dismissLoadView;





@end
