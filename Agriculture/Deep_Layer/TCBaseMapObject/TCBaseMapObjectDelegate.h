//
//  TCBaseMapObjectDelegate.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/1.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#ifndef Agriculture_TCBaseMapObjectDelegate_h
#define Agriculture_TCBaseMapObjectDelegate_h


@protocol TCBaseMapObjectDelegate <NSObject, NSCopying>

@optional

+ (NSArray *)mapToInstanceList:(NSArray *)arry;

/**
 *  系统映射方法
 *
 *  @param arry json数组
 *
 *  @return 对应映射的model数组
 */
+ (NSArray *)mapAutoInstanceList:(NSArray *)arry;

/**
 *  自定义映射方法
 *
 *  @param arry <#arry description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray *)mapCustomAutoInstanceList:(NSArray *)arry;



/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)objectClassInArray;


/**
 *  
 *
 *  @param dic 检测dic的合法性
 *
 *  @return 是否能解析
 */
- (BOOL)mapToInstance:(NSDictionary *)dic;



/**
 *   自定义的Dictionary
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)mappingDictionary;


@end


#endif
