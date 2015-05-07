//
//  ATControllerManager.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/3.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "ATControllerManager.h"
#import "TCNavigationController.h"
#import "LoginViewController.h"
#import "TCBaseViewController.h"
#import "AppDelegate.h"
#import "TCAppInfo.h"
#import "TCControllerManager.h"
#import "UIImage+SizeColor.h"


@interface ATControllerManager ()

@property (nonatomic, strong) TCNavigationController  *loginNavi;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation ATControllerManager


+ (instancetype)sharedInstance
{
    static ATControllerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}



- (instancetype)init
{
    if (self = [super init]) {
        
        [self setNaviagtionBar];
        
        NSError *error;
        NSString *path = [NSString stringWithFormat:@"%@/UISetting.json",[[NSBundle mainBundle] resourcePath]];
        [[TCControllerManager sharedInstance] loadConfigFileOfPath:path fileType:TCControllerManagerConfigFileTypeJSON error:&error];
    }
    
    return self;
}



- (void)switchToLoginPage
{
    self.loginNavi = nil;
    
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    _loginNavi = [[TCNavigationController alloc] initWithRootViewController:loginVc];
    
    [AppDelegate sharedAppDelegate].window.rootViewController = _loginNavi;
}



- (void)switchToHomePage
{
    [self setUpTabController];
    [AppDelegate sharedAppDelegate].window.rootViewController = self.tabBarController;
}


- (void)setUpTabController
{
    TCControllerManager *manager = [TCControllerManager sharedInstance];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    TCBaseViewController *homePageVC = [manager createViewControllerPageId:PAGE_HOME];
    TCNavigationController *homeNavi = [[TCNavigationController alloc] initWithRootViewController:homePageVC];
    [homeNavi setNavigationPageList:[manager getPageListByPageId:PAGE_HOME]];
    [viewControllers addObject:homeNavi];
    
    TCBaseViewController *searchPageVc = [manager createViewControllerPageId:PAGE_SEARCH];
    TCNavigationController *searchNavi = [[TCNavigationController alloc] initWithRootViewController:searchPageVc];
    [searchNavi setNavigationPageList:[manager getPageListByPageId:PAGE_SEARCH]];
    [viewControllers addObject:searchNavi];
    
    TCBaseViewController *recentPageVc = [manager createViewControllerPageId:PAGE_RECENT];
    TCNavigationController *rectentNavi = [[TCNavigationController alloc] initWithRootViewController:recentPageVc];
    [rectentNavi setNavigationPageList:[manager getPageListByPageId:PAGE_RECENT]];
    [viewControllers addObject:rectentNavi];
    
    TCBaseViewController *personPageVc = [manager createViewControllerPageId:PAGE_PERSON];
    TCNavigationController *personNavi = [[TCNavigationController alloc] initWithRootViewController:personPageVc];
    [personNavi setNavigationPageList:[manager getPageListByPageId:PAGE_PERSON]];
    [viewControllers addObject:personNavi];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = viewControllers;
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbarbackground"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    [self setTabBarItem];
    
}


- (void)setTabBarItem
{
    NSArray *controllers = self.tabBarController.viewControllers;
    NSArray *titleArry = [NSArray arrayWithObjects:@"主页",@"搜索",@"最近",@"会员中心",nil];
    NSArray *imageArry = [NSArray arrayWithObjects:@"home", @"info",@"sort",@"center",nil];
    for (int i = 0; i < controllers.count; i++)
    {
        NSString *selectImageName = [NSString stringWithFormat:@"%@_press",[imageArry objectAtIndex:i]];
        UITabBarItem *item = [[UITabBarItem alloc] init];
        item.title = [titleArry objectAtIndex:i];
        UIImage *normal = [UIImage imageNamed:[imageArry objectAtIndex:i]];
        UIImage *selected = [UIImage imageNamed:selectImageName];
        if ([item respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
            [item setFinishedSelectedImage:selected withFinishedUnselectedImage:normal];
        }else
        {
            item.image = normal;
            item.selectedImage = selected;
        }
        UINavigationController *nav = (UINavigationController *)[controllers objectAtIndex:i];
        nav.tabBarItem = item;
    }
    
    UIColor *titleHighlightedColor = RGB(29, 173, 235);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateHighlighted];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];

    
}


- (void)setNaviagtionBar
{
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [[UINavigationBar appearance] setBarTintColor:RGB(41, 135, 121)];
    }else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:RGB(41, 135, 121)] forBarMetrics:UIBarMetricsDefault];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



@end
