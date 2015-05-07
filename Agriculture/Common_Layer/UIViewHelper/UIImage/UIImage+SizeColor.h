//
//  UIImage+SizeColor.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/6.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SizeColor)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)screenshot;


- (UIImage*)blurredImage:(CGFloat)blurAmount;


-(UIImage*)resizedImageToSize:(CGSize)dstSize;
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

@end
