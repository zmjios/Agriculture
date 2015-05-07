//
//  TCTools.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/6.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "TCTools.h"
#import "TCDefine.h"
#import "UIDevice+ExtensionExt.h"

#define Frame_Times    kSCREEN_WIDTH/320

@implementation TCTools

//获得屏幕分辨率
+ (CGSize) getScreenResolution
{
    CGFloat widthPoints = [UIScreen mainScreen].bounds.size.width;//获取屏幕横向点数
    CGFloat heightPoints = [UIScreen mainScreen].bounds.size.height;//获取屏幕纵向点数
    CGFloat scale = [UIScreen mainScreen].scale;//获取scale
    CGSize screenSize = CGSizeMake(scale*widthPoints,scale*heightPoints);//得到最终的分辨率
    return screenSize;
}

//获得Iphone6的Size
+ (CGRect) getRealSize:(CGRect)frame
{
    CGFloat times = Frame_Times;
    frame.size.height = frame.size.height * times;
    frame.size.width = frame.size.width * times;
    return frame;
}

//获得Iphone6的仅宽度放大的Size
+ (CGRect) getwidthSize:(CGRect)frame
{
    frame.size.width = frame.size.width * Frame_Times;
    return frame;
}

//获得Iphone6的值
+ (float) getRealFloat:(float)number
{
    return number * Frame_Times;
}


+ (CGRect)getRealFrame:(CGRect)frame
{
    frame.origin.x = frame.origin.x * Frame_Times;
    frame.origin.y = frame.origin.y * Frame_Times;
    frame.size.height = frame.size.height * Frame_Times;
    frame.size.width = frame.size.width * Frame_Times;
    return frame;
}


+ (UIEdgeInsets)getRealEdgeInset:(UIEdgeInsets)edge
{
    edge.top = edge.top*Frame_Times;
    edge.left = edge.left*Frame_Times;
    edge.bottom = edge.bottom*Frame_Times;
    edge.right  =edge.right*Frame_Times;
    return edge;
}


+ (CGRect)getRealFrame:(CGRect)frame Except:(FRAME_TYPE)frame_type
{
    frame.origin.x = frame_type & FRAME_ORIGIN_X ? frame.origin.x : frame.origin.x * Frame_Times;
    frame.origin.y = frame_type & FRAME_ORIGIN_Y ? frame.origin.y : frame.origin.y * Frame_Times;
    frame.size.width = frame_type & FRAME_SIZE_WIDTH ? frame.size.width : frame.size.width * Frame_Times;
    frame.size.height = frame_type & FRAME_SIZE_HEIGHT ? frame.size.height : frame.size.height * Frame_Times;
    return frame;
}

+ (CGRect)getRealFrame:(CGRect)frame Only:(FRAME_TYPE)frame_type
{
    if (frame_type & FRAME_ORIGIN_X) {
        
        frame.origin.x = frame.origin.x * Frame_Times;
        
    }else if (frame_type & FRAME_ORIGIN_Y)
    {
        frame.origin.y = frame.origin.y * Frame_Times;
        
    }else if (frame_type & FRAME_SIZE_WIDTH)
    {
        frame.size.width = frame.size.width * Frame_Times;
        
    }else
    {
        frame.size.height = frame.size.height * Frame_Times;
    }
    
    
    return frame;
}


//获得Iphone6上字体的大小
+ (float) getRealFontSize:(float)number
{
    return number * ((Frame_Times - 1)/2 + 1);
}

+ (float) getFloatForIPhone:(float)IPhoneNum ForIPhone6:(float)IPhone6Num ForIPhone6plus:(float)IPhone6plusNum
{
    if ([[UIDevice currentDevice] is5_5Inch_Ext]) {
        return IPhone6plusNum;
    }
    else if ([[UIDevice currentDevice] is4_7Inch_Ext]) {
        return IPhone6Num;
    }
    else if ([[UIDevice currentDevice] is4Inch_Ext]) {
        return IPhoneNum;
    }
    else {
        return IPhoneNum * Frame_Times;
    }
}


//等比缩小
+ (CGFloat)getProportionReducedFloat:(CGFloat)number
{
    return number / Frame_Times;
}


@end
