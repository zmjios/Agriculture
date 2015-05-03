//
//  TCNavigationController.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/3.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "TCNavigationController.h"
#import "NSString+SearchKeyword.h"

@interface TCNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, strong) NSMutableArray *pageList;
@property (nonatomic, strong) NSString *pageListStr;

@end

@implementation TCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设置页面id
- (void)setPageId:(NSInteger)pageId
{
    _pageId = pageId;
}
//获取页面id
- (NSInteger)getPageId
{
    return _pageId;
}

- (void)setNavigationPageList:(NSString *)aPageList
{
    _pageListStr = aPageList;
    NSArray *pageArry = [aPageList componentsSeparatedByString:@","];
    if (_pageList == nil) {
        _pageList = [NSMutableArray array];
    }
    for (NSString *pageStr in pageArry) {
        NSRange range = [pageStr rangeOfString:@"-"];
        if (range.location == NSNotFound) {
            [_pageList addObject:[NSNumber numberWithInteger:[pageStr integerValue]]];
        }else if(range.location > 0 && range.location+1<pageStr.length)
        {
            NSString *startPage = [pageStr substringToIndex:range.location];
            NSString *endPage = [pageStr substringFromIndex:range.location+1];
            if ([startPage isNumber] && [endPage isNumber]) {
                for (int i= 0; i < [endPage integerValue] - [startPage integerValue]; i ++) {
                    NSNumber *number = [NSNumber numberWithInteger:[startPage integerValue] + i];
                    [_pageList addObject:number];
                }
            }
        }
    }
}


- (NSArray *)getPageList
{
    if (_pageList == nil) {
        return nil;
    }
    
    return [NSArray arrayWithArray:_pageList];
}


- (NSString *)getPageListString
{
    return _pageListStr;
}


// Hijack the push method to disable the gesture

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}

@end
