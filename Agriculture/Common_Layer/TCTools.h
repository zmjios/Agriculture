//
//  TCTools.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/6.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_OPTIONS(NSUInteger, FRAME_TYPE) {
    FRAME_ORIGIN_X           = 1 << 0,
    FRAME_ORIGIN_Y           = 1 << 1,
    FRAME_SIZE_WIDTH         = 1 << 2,
    FRAME_SIZE_HEIGHT        = 1 << 3
};


/**
 *  手动调整尺寸
 */

@interface TCTools : NSObject


//获得屏幕分辨率
+ (CGSize) getScreenResolution;

//获得Iphone6的等比例放大Size
+ (CGRect) getRealSize:(CGRect)frame;

//获得Iphone6的仅宽度放大的Size
+ (CGRect) getwidthSize:(CGRect)frame;

+ (CGRect)getRealFrame:(CGRect)frame;

//有时候调整坐标等比放大，需要去除某些元素，例如高度
+ (CGRect)getRealFrame:(CGRect)frame Except:(FRAME_TYPE)frame_type;

+ (CGRect)getRealFrame:(CGRect)frame Only:(FRAME_TYPE)frame_type;

+ (UIEdgeInsets)getRealEdgeInset:(UIEdgeInsets)edge;

//获得Iphone6的值
+ (float) getRealFloat:(float)number;

//等比缩小
+ (CGFloat)getProportionReducedFloat:(CGFloat)number;

//获得Iphone6上字体的大小
+ (float) getRealFontSize:(float)number;


//+ (float) getFloatForIPhone:(float)IPhoneNum ForIPhone6:(float)IPhone6Num ForIPhone6plus:(float)IPhone6plusNum;



@end
