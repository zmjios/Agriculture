//
//  TCDefine.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/1.
//  Copyright (c) 2015年 zmj. All rights reserved.
//


#import "NSMutableDictionary+NoNil.h"

#ifndef Agriculture_TCDefine_h
#define Agriculture_TCDefine_h

//====================================================================
//颜色

#define RGB_A(r, g, b, a) ([UIColor colorWithRed:(r)/255.0f \
green:(g)/255.0f \
blue:(b)/255.0f \
alpha:(a)/255.0f])

#define RGB(r, g, b) RGB_A(r, g, b, 255)

#define ColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//-------------------------------------------------------------------
//是否为空
#define IS_OBJ_AVAILABLE(obj)       (nil != (obj) && [NSNull null] != (NSNull *)(obj))
#define Empty_Collection(param)     (nil == param || param.count < 1)
#define Empty_Str(param)            (nil == param || param.length < 1)


//-------------------------------------------------------------------
//内存警告
#define kSHOULD_DEAL_MEM_WARNING    (self.isViewLoaded && nil == self.view.window)

//-------------------------------------------------------------------
//生成单例
#define SINGLETON_GCD(classname)                        \
\
__strong static classname * shared##Instance = nil;\
+ (classname *)shared##Instance {                      \
\
static dispatch_once_t pred;                        \
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}


//-------------------------------------------------------------------
//屏幕尺寸
#define kSCREEN_WIDTH   min([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)
#define kSCREEN_HEIGHT  max([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width)
#define KIPHONE5_SIZE   ((kSCREEN_HEIGHT>480)?YES:NO)



//-----------------------------------------------------------------------
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)




//--------------------------------------------------------------------
//真机与模拟器
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

//--------------------------------------------------------------------
//字典简写
#define OBJC_STRINGIFY(x) @#x
#define encodeObject(x) [aCoder encodeObject:x forKey:OBJC_STRINGIFY(x)]
#define decodeObject(x) x = [aDecoder decodeObjectForKey:OBJC_STRINGIFY(x)]

#define setNoNilObject(x) [data setNoNilObject:x forKey:OBJC_STRINGIFY(x)]
#define setNoNilIntObject(x) [data setNoNilObject:[NSNumber numberWithInteger:x] forKey:OBJC_STRINGIFY(x)]

#define DicSetNoNilObject(dic,x) [dic setNoNilObject:x forKey:OBJC_STRINGIFY(x)]


#define objectForKey(dic,x)     [dic objectForKey:OBJC_STRINGIFY(x)]
#define KeyIntNoNull(dic,x)  [[dic objectForKey:OBJC_STRINGIFY(x)] intValue]

//--------------------------------------------------------------------
//G－C－D
#define GlobalQueue  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MainQueue    dispatch_get_main_queue()

#define BACKGROUND(block) dispatch_async(GlobalQueue,block)
#define MAIN(block)       dispatch_async(MainQueue,block)


#endif
