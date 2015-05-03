//
//  TCBseViewControllerProtcol.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/3.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#ifndef Agriculture_TCBseViewControllerProtcol_h
#define Agriculture_TCBseViewControllerProtcol_h

@protocol TCBaseViewControllerProtcol <NSObject>

@optional
//设置页面id
- (void)setPageId:(NSInteger)pageId;
//获取页面id
- (NSInteger)getPageId;


//设置属于的栈id
- (void)setStackId:(NSInteger)nStackId;
//得到属于的栈id
- (NSInteger)getStackId;

@end



#endif
