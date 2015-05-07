//
//  TCControllerManager.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/3.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "TCControllerManager.h"
#import "TCNavigationController.h"

static NSString *kTCControllerConfigKeyClassName    = @"ClassName";
static NSString *kTCControllerConfigKeyDescription  = @"Description";
static NSString *kTCControllerConfigKeyPageId       = @"pageId";
static NSString *kTCControllerConfigKeyParams       = @"params";
static NSString *kTCControllerConfigKeyStackLevel   = @"StackLevel";
static NSString *kTCControllerConfigKeyPageList     = @"PageList";

static NSString *errorDomain = @"TCControllerManagerErrorDomain";


@interface TCControllerConfigItem : NSObject

@property (nonatomic, unsafe_unretained) Class controllerClass;
@property (nonatomic, copy) NSString *controllerClassName;   //控制器名
@property (nonatomic, copy) NSString *classDescription;      //控制器描述
@property (nonatomic, copy) NSString *stackLevel;            //压栈级别
@property (nonatomic, copy) NSString *pageList;              //是否是导航栏控制器的rootViewcontroller
@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, assign) NSInteger pageId;              //页面id

@end

@implementation TCControllerConfigItem



@end

@interface TCControllerManager ()

@property (nonatomic, strong) NSMutableDictionary *controllerConfigMap;

@end

@implementation TCControllerManager


+ (instancetype)sharedInstance
{
    static TCControllerManager  *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _controllerConfigMap = [[NSMutableDictionary alloc]init];
    }
    return self;
}


- (BOOL)loadConfigFileOfPath:(NSString *)path
                   fileType:(TCControllerManagerConfigFileType)type
                      error:(NSError **)error {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        if (error != NULL) {
            NSError *e = [NSError errorWithDomain:errorDomain code:-1 userInfo:@{@"message":@"config file doesn't exist"}];
            *error = e;
        }
        return NO;
    }
    
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *configMapping = nil;
    
    switch (type) {
        case TCControllerManagerConfigFileTypeJSON:{
            NSError *jsonError = nil;
            configMapping = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:&jsonError];
            if (jsonError) {
                if (error != NULL) {
                    *error = jsonError;
                }
                return NO;
            } else if(![configMapping isKindOfClass:[NSDictionary class]]) {
                if (error != NULL) {
                    NSError *e = [NSError errorWithDomain:errorDomain code:-1 userInfo:@{@"message":@"JSON file cannot be parsed to a dictionary"}];
                    *error = e;
                }
                return NO;
            }
        }
            break;
        case TCControllerManagerConfigFileTypePlist:{
            configMapping = [NSDictionary dictionaryWithContentsOfFile:path];
            if (![configMapping isKindOfClass: [NSDictionary class]]) {
                if (error != NULL) {
                    NSError *e = [NSError errorWithDomain:errorDomain code:-1 userInfo:@{@"message":@"Plist file cannot be parsed to a dictionary"}];
                    *error = e;
                }
                return NO;
            }
        }
            break;
            
        default: {
            if (error != NULL) {
                NSError *e = [NSError errorWithDomain:errorDomain code:-1 userInfo:@{@"message":@"Unsupported file type"}];
                *error = e;
            }
            
            return NO;
        }
            break;
    }
    
    if (configMapping) {
        
        // validate keys and values
        [configMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            if (![key isKindOfClass:[NSString class]]) {
                [self notifyInvalidConfigAtKey:[key description]];
                return;
            }
            
            if ([obj isKindOfClass:[NSString class]]) {
                Class aControllerClass = NSClassFromString((NSString *)obj);
                if (aControllerClass == nil) {
                    // The class doesn't exist.
                    [self notifyInvalidConfigAtKey:key];
                    return;
                }
                TCControllerConfigItem *anItem = [[TCControllerConfigItem alloc] init];
                anItem.controllerClass = aControllerClass;
                anItem.controllerClassName = (NSString *)obj;
                anItem.classDescription = (NSString *)obj;
                anItem.pageId = [key integerValue];
                [self.controllerConfigMap setObject:anItem forKey:key];
                
            }else if([obj isKindOfClass:[NSDictionary class]]){
                NSDictionary *dict = (NSDictionary *)obj;
                NSString *className = dict[kTCControllerConfigKeyClassName];
                Class aControllerClass = nil;
                if (className.length > 0) {
                    aControllerClass = NSClassFromString(className);
                }
                if (aControllerClass == nil) {
                    // The class doesn't exist.
                    [self notifyInvalidConfigAtKey:key];
                    return;
                }
                TCControllerConfigItem *anItem = [[TCControllerConfigItem alloc] init];
                anItem.controllerClass = aControllerClass;
                anItem.classDescription = dict[kTCControllerConfigKeyDescription];
                if (anItem.classDescription.length == 0) {
                    anItem.classDescription = className; // To ensure that it has a value.
                }
                anItem.params = dict[kTCControllerConfigKeyParams];
                anItem.controllerClassName = dict[kTCControllerConfigKeyClassName];
                anItem.pageId = [dict[kTCControllerConfigKeyPageId] integerValue];
                anItem.stackLevel = dict[kTCControllerConfigKeyStackLevel];
                anItem.pageList = dict[kTCControllerConfigKeyPageList];
                [self.controllerConfigMap setObject:anItem forKey:key];
            }else {
                [self notifyInvalidConfigAtKey:key];
            }
        }];
    }
    if (error != NULL) {
        *error = nil;
    }
    return YES;
    
}

- (TCBaseViewController *)createViewControllerPageId:(NSInteger)pageId{
    
    NSString *pageIdString = [NSString stringWithFormat:@"%ld",pageId];
    TCControllerConfigItem *configItem = self.controllerConfigMap[pageIdString];
    Class aClass = configItem.controllerClass;
    if (aClass == nil && configItem.controllerClassName.length > 0) {
        aClass = NSClassFromString(configItem.controllerClassName);
        configItem.controllerClass = aClass; // Cache the class
    }
    TCBaseViewController *controller= [[aClass alloc] init];
    [controller setPageId:configItem.pageId];
    [controller setStackId:[configItem.stackLevel integerValue]];
    
    return controller;
}



- (TCControllerConfigItem *)getContrllerItem:(NSInteger)pageId
{
    NSString *pageIdString = [NSString stringWithFormat:@"%ld",pageId];
    TCControllerConfigItem *configItem = self.controllerConfigMap[pageIdString];
    
    return configItem;
}



- (NSString *)getPageListByPageId:(NSInteger)pageId
{
    TCControllerConfigItem  *item = [self getContrllerItem:pageId];
    return item.pageList;
}


- (void)notifyInvalidConfigAtKey:(NSString *)key {
    NSLog(@"EMControllerManager warning: the key \"%@\" is not valid!",key);
}



- (BOOL)gotoPageWithPageId:(int)pageId
{
    return [self gotoPageWithPageId:pageId andParams:nil];
}


- (BOOL)gotoPageWithPageId:(int)pageId andParams:(NSDictionary *)params
{
    BOOL canGoto = NO;
    //获取跟控制器
    UITabBarController *rootViewContoller = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //由于本项目是采用tabbarcontroller，其他架构可根据跟控制器适当获取不同的当导航栏
    TCControllerConfigItem *item = [self getContrllerItem:pageId];
    if (item) {
        //如果需要创建的控制器就在同一个导航栏控制器,todo：暂时不考虑在导航栏弹出的导航栏控制器
        
        //获取item所在的导航栏控制器
        BOOL isExsit = NO;
        for (TCNavigationController *naviController in rootViewContoller.viewControllers) {
            for (NSNumber *pageId in [naviController getPageList]) {
                if ([pageId integerValue] == item.pageId) {
                    isExsit = YES;
                    NSInteger selectedIndex = [rootViewContoller.viewControllers indexOfObject:naviController];
                    [rootViewContoller setSelectedIndex:selectedIndex];
                }
            }
        }
        
        if (isExsit) {
            DLog(@"请到配置文件中重新配置控制器");
            return canGoto;
        }
        
        TCNavigationController *selectedController = (TCNavigationController *)rootViewContoller.selectedViewController;
        NSInteger currentStackLevel = [(TCBaseViewController *)selectedController.topViewController getStackId];
        NSInteger newStackLevel = [item.stackLevel integerValue];
        TCBaseViewController *currentViewController = (TCBaseViewController *)selectedController.topViewController;
        if (pageId == [currentViewController getPageId]) {
            
            //刷新页面
            NSInteger index = [selectedController.viewControllers indexOfObject:selectedController.topViewController];
            NSMutableArray *controllerList = [NSMutableArray arrayWithObject:selectedController.viewControllers];
            TCBaseViewController *viewController = [self createViewControllerPageId:item.pageId];
            [viewController setPageParams:params];
            [controllerList replaceObjectAtIndex:index withObject:viewController];
            [selectedController setViewControllers:controllerList];
            canGoto = YES;
            
        }else if (newStackLevel > currentStackLevel) {
            //新的controller比原先栈级别大
            TCBaseViewController *viewController = [self createViewControllerPageId:item.pageId];
            if (viewController) {
                canGoto = YES;
                [selectedController pushViewController:viewController animated:YES];
            }else
            {
                canGoto = NO;
                DLog(@"!!!配置错误");
            }
        }else if (newStackLevel < currentStackLevel)
        {
            //小于的话，需要做弹栈操作，需要判断是否弹到栈底
            NSInteger nStackSize = [selectedController.viewControllers count];
            
            if(nStackSize == 1)
            {
                //刷新页面
                [self refreshCurrentPage:pageId withParams:params];
                
            }
            
            for(NSInteger i=nStackSize-2;i>=0;i--)
            {
                TCBaseViewController *pControllerInStack = [selectedController.viewControllers objectAtIndex:i];
                NSInteger theStackLevel  =[pControllerInStack getStackId];
                
                if(theStackLevel < newStackLevel && i >= 0)
                {
                    //如果  theStackLevel 比 newStackLevel 小，说明 i+1 需要被替换
                    TCBaseViewController* pObjInStack = (TCBaseViewController*)[selectedController.viewControllers objectAtIndex:i+1];
                    if(pObjInStack == currentViewController)
                    {
                        NSMutableArray *controllerList = [NSMutableArray arrayWithObject:selectedController.viewControllers];
                        TCBaseViewController *viewController = [self createViewControllerPageId:item.pageId];
                        [viewController setPageParams:params];
                        [controllerList replaceObjectAtIndex:i+1 withObject:viewController];
                        [selectedController setViewControllers:controllerList];
                    }
                    else
                    {
                        [pObjInStack setPageId:pageId];
                        [pObjInStack setPageParams:params];
                        [selectedController popToViewController:pObjInStack animated:YES];
                    }
                    
                    break;
                }
                
                if(i==0 && theStackLevel >= newStackLevel)
                {
                    //如果到栈底了，新的栈级别数值还是那么小，那就替换
                    TCBaseViewController * pObjInStack = (TCBaseViewController*)[selectedController.viewControllers objectAtIndex:i];
                    [pObjInStack setPageId:pageId];
                    [pObjInStack setPageParams:params];
                    [selectedController popToViewController:pObjInStack animated:YES];
                    
                }
            }
            
            canGoto = YES;
        }else if (newStackLevel == currentStackLevel)
        {
            canGoto = YES;
            [self refreshCurrentPage:pageId withParams:params];
        }
    }
    
    return canGoto;
}


- (void)refreshCurrentPage:(NSInteger)pageId withParams:(NSDictionary *)params
{
    UITabBarController *rootViewContoller = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    TCNavigationController *selectedController = (TCNavigationController *)rootViewContoller.selectedViewController;
    NSInteger index = [selectedController.viewControllers indexOfObject:selectedController.topViewController];
    NSMutableArray *controllerList = [NSMutableArray arrayWithObject:selectedController.viewControllers];
    TCBaseViewController *viewController = [self createViewControllerPageId:pageId];
    [viewController setPageParams:params];
    [controllerList replaceObjectAtIndex:index withObject:viewController];
    [selectedController setViewControllers:controllerList];
}



@end
