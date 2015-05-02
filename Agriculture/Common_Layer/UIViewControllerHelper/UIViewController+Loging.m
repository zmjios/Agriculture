//
//  UIViewController+Loging.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/2.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "UIViewController+Loging.h"
#import "Aspects.h"

@implementation UIViewController (Loging)


+ (void)load
{
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo){
        
        DLog(@"%@ viewWillAppear:",NSStringFromClass([[aspectInfo instance] class]));
        
    } error:NULL];
    
    
    [UIViewController aspect_hookSelector:@selector(dealloc)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                
                                   DLog(@"==========%@ will dealloc=========",NSStringFromClass([[aspectInfo instance] class]));
                                   
                               } error:NULL];
}





@end
