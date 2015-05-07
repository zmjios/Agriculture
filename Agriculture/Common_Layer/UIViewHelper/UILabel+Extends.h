//
//  UILabel+Extends.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/7.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extends)

/**
 * 适应字数高度的大小，宽度固定，高度根据字数得到
 *
 * @return 大小
 */
- (CGSize)fitTextHeight_Ext;

/**
 * 适应字数的宽度的大小，高度不变，宽度根据字数长度
 *
 * @return 大小
 */
- (CGSize)fitTextWidth_Ext;

@end
