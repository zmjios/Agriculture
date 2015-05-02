//
//  NSMutableDictionary+NoNil.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/2.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "NSMutableDictionary+NoNil.h"

@implementation NSMutableDictionary (NoNil)

- (void)setNoNilObject:(id)object forKey:(NSString *)key
{
    if (object) {
        [self setObject:object forKey:key];
    }else
    {
        [self setObject:@"" forKey:key];
    }
}

@end
