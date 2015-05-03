//
//  TCControllerManager.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/3.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCBaseViewController.h"

/**
 *  控制器创建和页面跳转基类
 */





typedef NS_ENUM(NSUInteger, TCControllerManagerConfigFileType) {
    TCControllerManagerConfigFileTypeJSON,
    TCControllerManagerConfigFileTypePlist
};

@interface TCControllerManager : NSObject


+ (instancetype)sharedInstance;


/**
 Load the configuration file
 
 The configuration file must be a JSON file or a plist file.
 
 Note that this method will override all configured classes.
 
 A typical JSON config file example:
 
 {
 
 "100":{
 "ClassName":"TCNaviagtionController",
 "Description":"导航栏1",
 "PageId":"100",
 "StackLevel":"10",
 "PageList":"1000,1001,1002-1004"
 }
 
 "1001":{
 "ClassName":"HomePageViewController",
 "Description":"导航栏1",
 "PageId":"1001",
 "StackLevel":"10",
 "PageList":"1000,1001,1002-1004"
 }
 
 "1000":{
 "ClassName":"Test1ViewController",
 "Description":"hahahahahhahaha",
 "PageId":"1000",
 },
 "1001":"Test2ViewController"
 }
 
 @param path  The path of the configuration file.
 @param type  The type of the configuration file. There are two possible values.
 @param error If an error occured (e.g. file not exist or parsing JSON failed), the detailed error information will pass throungh this parameter.
 
 @return Return YES, if there's no problem. Return NO, if some problems occured during loading.
 */
- (BOOL)loadConfigFileOfPath:(NSString *)path
                    fileType:(TCControllerManagerConfigFileType)type
                       error:(NSError **)error;


- (TCBaseViewController *)createViewControllerPageId:(NSInteger)pageId;


- (BOOL)gotoPageWithPageId:(int)pageId;


- (BOOL)gotoPageWithPageId:(int)pageId andParams:(NSDictionary *)params;






@end
