//
//  TCAppInfo.m
//  DragonWell
//
//  Created by ChenQi on 13-4-15.
//  Copyright (c) 2013年 TCGROUP. All rights reserved.
//

#import "TCAppInfo.h"
#import <mach/mach.h>
#import <mach/mach_time.h>


#define DEFAULT_PLIST_FOR_KEY(key)      [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)(key)]


@implementation TCAppInfo


+ (NSString *)appVersion
{
    return DEFAULT_PLIST_FOR_KEY(kCFBundleVersionKey);
}

+ (NSString *)shortAppVersion
{
    return DEFAULT_PLIST_FOR_KEY(@"CFBundleShortVersionString");
}

+ (NSString *)bundleName
{
    return DEFAULT_PLIST_FOR_KEY(kCFBundleNameKey);
}

+ (NSString *)displayName
{
    return DEFAULT_PLIST_FOR_KEY(@"CFBundleDisplayName");
}


+ (UIDevice *)currentDevice
{
    return [UIDevice currentDevice];
}

+ (unsigned long)memoryUsage
{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    
    unsigned long memSize = 0;
    if (kerr == KERN_SUCCESS) {
        memSize = info.resident_size / 1024 / 1024;
    }
    else {
        NSLog(@"error: task_info(): %s", mach_error_string(kerr));
    }
    
    return memSize;
}

@end
