//
//  UIView+Extends.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/2.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extends)


/**
 *  @brief 获取view所在的控制器
 *
 *  @return controller
 */
- (UIViewController*)viewController;



/**
 *	@brief	获取view的截图
 *
 *	@return	图片
 */
- (UIImage *)screenshot_Ext;


/**
 *	@brief	得到当前的第一响应者
 *
 *	@return	返回第一响应者，没有返回nil
 */
- (UIView *)currentFirstResponderView_Ext;

@end
