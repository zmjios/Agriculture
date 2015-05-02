//
//  TCDebug.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/2.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#ifndef Agriculture_TCDebug_h
#define Agriculture_TCDebug_h


#if defined(DEBUG) || defined(_DEBUG) || defined(__DEBUG)
#define TC_IOS_DEBUG
#endif


#ifdef TC_IOS_DEBUG

#define DLog(fmt, ...) \
NSLog(@"%@(%d)\n%s: "fmt, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__PRETTY_FUNCTION__,## __VA_ARGS__);

#else

#define DLog(...);

#endif


#endif
