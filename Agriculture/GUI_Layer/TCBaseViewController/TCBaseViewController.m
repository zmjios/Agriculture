//
//  TCBaseViewController.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/2.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "TCBaseViewController.h"
#import "MBProgressHUD.h"


@interface TCBaseViewController ()

@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) NSInteger stackId;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation TCBaseViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark -  page set


- (void)setPageParams:(NSDictionary *)params
{
    _params = params;
}

- (NSDictionary *)getParams
{
    return _params;
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


//设置属于的栈id
- (void)setStackId:(NSInteger)nStackId
{
    _stackId  = nStackId;
}
//得到属于的栈id
- (NSInteger)getStackId
{
    return _stackId;
}



#pragma mark -

- (void)showLoadView:(NSString *)tip
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"正在加载...";
}



- (void)dismissLoadView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(self.navigationController != nil)
    {
        NSArray* ary = self.navigationController.viewControllers;
        if(ary != nil && [ary count] > 1)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

@end
