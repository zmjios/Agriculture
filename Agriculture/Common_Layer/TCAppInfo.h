//
//  TCAppInfo.h
//  DragonWell
//
//  Created by ChenQi on 13-4-15.
//  Copyright (c) 2013年 TCGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCAppInfo : NSObject

+ (NSString *)appVersion;
+ (NSString *)shortAppVersion;

+ (NSString *)bundleName;
+ (NSString *)displayName;

+ (UIDevice *)currentDevice;

+ (unsigned long)memoryUsage;

@end
