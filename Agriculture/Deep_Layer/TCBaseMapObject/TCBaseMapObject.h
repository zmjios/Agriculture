//
//  TCBaseMapObject.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/1.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCBaseMapObjectDelegate.h"


typedef NS_ENUM(NSInteger, TCBaseMapType) {
    TCBaseMapSystem,    /*<使用系统反射 **/
    TCBaseMapCustom,    /*<使用自定义反射，将Json反射中反射的NSNumber对象直接直接转换为NSString **/
};


/**
 *  遍历所有类的block（父类）
 */
typedef void (^TCBaseClassesBlock)(Class c, BOOL *stop);


@interface TCBaseMapObject : NSObject<TCBaseMapObjectDelegate>


/**
 *   初始化方法
 *
 *  @param dictionary json 字典
 *  @param mapType    映射类型
 *
 *  @return <#return value description#>
 */
- (id)initWithDictionary:(NSDictionary *)dictionary mapType:(TCBaseMapType)mapType;


/**
 *  默认使用系统映射
 *
 *  @param dictionary <#dictionary description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;



/**
 *   自定义反射
 *
 *  @param dictionary <#dictionary description#>
 *
 *  @return <#return value description#>
 */
- (id)initCustomWithDictionary:(NSDictionary *)dictionary;




/**
 *  直接转化
 *
 *  @param dictionary <#dictionary description#>
 */
- (void)objectFromDictionary:(NSDictionary *)dictionary;




@end
