//
//  NSDateManager.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/2.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateManager : NSObject

/**
 *  //获取date的时间字符串
 *
 *  @param date   <#date description#>
 *  @param format <#format description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)getTimeStrFromDate:(NSDate *)date format:(NSString *)format;


+ (NSString *)getTimeStrFromDate:(NSDate *)date format:(NSString *)format timeZone:(NSTimeZone *)timezone local:(NSLocale *)local;



+ (NSDate *)timeFromString:(NSString *)timeStrig format:(NSString *)format;


+ (NSDate *)timeFromString:(NSString *)timeStrig format:(NSString *)format timeZone:(NSTimeZone *)timezone local:(NSLocale *)local;


/**
 *  将一种时间转换为另一种时间格式
 *
 *  @param timeString  <#timeString description#>
 *  @param originFormat     <#format description#>
 *  @param changeFomat <#changeFomat description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)getTimeStringFromTimeString:(NSString *)timeString withFormat:(NSString *)originFormat changeFormat:(NSString *)changeFomat;












@end
