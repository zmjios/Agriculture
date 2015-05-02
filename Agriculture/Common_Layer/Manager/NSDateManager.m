//
//  NSDateManager.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/2.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "NSDateManager.h"

@implementation NSDateManager


+ (NSDateFormatter *)sharedIntance;
{
    static NSDateFormatter *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NSDateFormatter alloc] init];
    });
    
    return manager;
}



/**
 *  //获取date的时间字符串
 *
 *  @param date   <#date description#>
 *  @param format <#format description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)getTimeStrFromDate:(NSDate *)date format:(NSString *)format
{
    
    return [self getTimeStrFromDate:date format:format timeZone:nil local:nil];
}


+ (NSString *)getTimeStrFromDate:(NSDate *)date format:(NSString *)format timeZone:(NSTimeZone *)timeZone local:(NSLocale *)local
{
    NSDateFormatter *formatter = [self sharedIntance];
    if(date == nil)
    {
        date = [NSDate date];
    }
    if (format) {
        [formatter setDateFormat:format];
    }
    if(timeZone)
    {
        [formatter setTimeZone:timeZone];
    }
    if(local != nil)
    {
        [formatter setLocale:local];
    }
    NSString *nowTime = [formatter stringFromDate:date];
    
    return nowTime;
}



+ (NSDate *)timeFromString:(NSString *)timeStrig format:(NSString *)format
{
    return [self timeFromString:timeStrig format:format timeZone:nil local:nil];
}


+ (NSDate *)timeFromString:(NSString *)timeString format:(NSString *)format timeZone:(NSTimeZone *)timeZone local:(NSLocale *)local
{
    NSDateFormatter *formatter = [self sharedIntance];
    
    if(timeZone != nil)
        [formatter setTimeZone:timeZone];
    if (format !=nil) {
        [formatter setDateFormat: format];
    }
    
    if( timeString == nil)
    {
        timeString = [formatter stringFromDate:[NSDate date]];
    }
    if (local!=nil) {
        [formatter setLocale:local];
    }
    
    NSDate *destTime= [formatter dateFromString:timeString];
    
    return destTime;
}




+ (NSString *)getTimeStringFromTimeString:(NSString *)timeString withFormat:(NSString *)format changeFormat:(NSString *)changeFomat
{
    NSDate *date = [self timeFromString:timeString format:format];
    NSString *time = [self getTimeStrFromDate:date format:changeFomat];
    
    return time;
}




@end
