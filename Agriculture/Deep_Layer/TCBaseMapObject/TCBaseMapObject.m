//
//  TCBaseMapObject.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/1.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "TCBaseMapObject.h"
#import <objc/runtime.h>
#import "AutoCoding.h"


static const char TCMapObjectClassInArrayKey;   //存放对象的数组
static NSSet *_foundationClasses;

@implementation NSObject (ClassName)

- (NSString *)className
{
    return NSStringFromClass([self class]);
}

@end

@interface TCBaseMapObject ()

@property (nonatomic, assign) TCBaseMapType mapType;


@end

@implementation TCBaseMapObject


+ (void)load
{
    _foundationClasses = [NSSet setWithObjects:
                          [NSObject class],
                          [NSURL class],
                          [NSDate class],
                          [NSNumber class],
                          [NSDecimalNumber class],
                          [NSData class],
                          [NSMutableData class],
                          [NSArray class],
                          [NSMutableArray class],
                          [NSDictionary class],
                          [NSMutableDictionary class],
                          [NSString class],
                          [NSMutableString class], nil];
}


+ (BOOL)isClassFromFoundation:(Class)c
{
    return [_foundationClasses containsObject:c];
}

/**
 *  直接转化
 *
 *  @param dictionary <#dictionary description#>
 */
- (void)objectFromDictionary:(NSDictionary *)dictionary
{
    NSArray *propertyList = [self propertyNames];
    
    for (NSString *propertName in propertyList) {
        
        //找到json中对应的值
        id obj = [dictionary objectForKey:propertName];
        if (!obj) {
            //是nil，先从自定义反射中查找对应的key
            NSDictionary *mapDic = [self mappingDictionary];
            if (mapDic && [mapDic isKindOfClass:[NSDictionary class]]) {
                for (NSString *mapKey in [mapDic allKeys]) {
                    if ([mapKey isEqualToString:propertName]) {
                        obj = [dictionary objectForKey:[mapDic objectForKey:propertName]];
                    }
                }
            }
        }
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            TCBaseMapObject *subObj = [[TCBaseMapObject alloc] initCustomWithDictionary:obj];
            [self setValue:subObj forKey:propertName];
        }else if ([obj isKindOfClass:[NSArray class]])
        {
            NSArray *subList = [[self class] mapCustomAutoInstanceList:obj];
            [self setValue:subList forKey:propertName];
        }else
        {
            if (![obj isEqual:NSNull.null])
            {
                Class class = [self getPropertyByName:propertName];
                if ([NSStringFromClass(class) isEqualToString:[obj className]]) {
                    //json字典返回的对象与model的属性类型一致，一致直接设置
                    [self setValue:obj forKey:propertName];
                }else
                {
                    //如果不一致，则进行转化，这里只转换将nsnumber转化为nsstring
                    if ([NSStringFromClass(class) isEqualToString:@"NSString"]  && [[obj className] isEqualToString:@"_NSCFNumber"]) {
                        NSString *objStr = [obj stringValue];
                        [self setValue:objStr forKey:propertName];
                    }
                }
            }
        }
    }
}

/**
 *   初始化方法
 *
 *  @param dictionary json 字典
 *  @param mapType    映射类型
 *
 *  @return <#return value description#>
 */
- (id)initWithDictionary:(NSDictionary *)dictionary mapType:(TCBaseMapType)mapType
{
    if (mapType == TCBaseMapSystem) {
        return [self initWithDictionary:dictionary];
    }else
    {
        return [self initCustomWithDictionary:dictionary];
    }
}


/**
 *  默认使用系统映射
 *
 *  @param dictionary <#dictionary description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        if ([self mapToInstance:dictionary]) {
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    
    return self;
}



- (id)initCustomWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        if ([self mapToInstance:dictionary]) {
            [self objectFromDictionary:dictionary];
        }
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //重载保证没有映射的属性会崩溃
    NSDictionary *mapDic = [self mappingDictionary];
    
    if (mapDic && [mapDic isKindOfClass:[NSDictionary class]]) {
        for (NSString *mapKey in [mapDic allKeys]) {
            if ([mapKey isEqualToString:key]) {
                [self setValue:[mapDic objectForKey:key] forKey:key];
            }
        }
    }
    
}


#pragma mark - Private

- (Class)getPropertyByName:(NSString *)name
{
    Class subclass = [self class];
    while (subclass != [NSObject class])
    {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(subclass,
                                                             &propertyCount);
        for (int i = 0; i < propertyCount; i++)
        {
            // Get property name
            objc_property_t property = properties[i];
            const char *cPropertyName = property_getName(property);
            NSString *propertyName = @(cPropertyName);
            if ([propertyName isEqualToString:name] ) {
                return [self getPropertyClass:property];
            }
        }
        free(properties);
        subclass = [subclass superclass];
    }
    
    return NULL;

}


- (Class)getPropertyClass:(objc_property_t)property
{
    //get property type
    Class propertyClass = nil;
    //通过property_getAttributes函数可以后去编码后的字符串，该字符串以T开头，紧接@encode type和逗号，接着以V和变量名结尾
    char *typeEncoding = property_copyAttributeValue(property, "T");
    switch (typeEncoding[0])
    {
        case '@':
        {
            if (strlen(typeEncoding) >= 3)
            {
                char *className = strndup(typeEncoding + 2, strlen(typeEncoding) - 3);
                __autoreleasing NSString *name = @(className);
                NSRange range = [name rangeOfString:@"<"];
                if (range.location != NSNotFound)
                {
                    name = [name substringToIndex:range.location];
                }
                propertyClass = NSClassFromString(name) ?: [NSObject class];
                free(className);
            }
            break;
        }
        case 'c':
        case 'i':
        case 's':
        case 'l':
        case 'q':
        case 'C':
        case 'I':
        case 'S':
        case 'L':
        case 'Q':
        case 'f':
        case 'd':
        case 'B':
        {
            propertyClass = [NSNumber class];
            break;
        }
        case '{':
        {
            propertyClass = [NSValue class];
            break;
        }
    }
    free(typeEncoding);
    
    return propertyClass;
}


- (NSArray *)propertyNames
{
    // Check for a cached value (we use _cmd as the cache key,
    // which represents @selector(propertyNames))
    NSMutableArray *array = objc_getAssociatedObject([self class], _cmd);
    if (array)
    {
        return array;
    }
    
    // Loop through our superclasses until we hit NSObject
    array = [NSMutableArray array];
    Class subclass = [self class];
    while (subclass != [NSObject class])
    {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(subclass,
                                                             &propertyCount);
        for (int i = 0; i < propertyCount; i++)
        {
            // Get property name
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = @(propertyName);
            
            // Check if there is a backing ivar
            char *ivar = property_copyAttributeValue(property, "V");
            if (ivar)
            {
                // Check if ivar has KVC-compliant name
                NSString *ivarName = @(ivar);
                if ([ivarName isEqualToString:key] ||
                    [ivarName isEqualToString:[@"_" stringByAppendingString:key]])
                {
                    // setValue:forKey: will work
                    [array addObject:key];
                    // 设置数组对应
                    //[self setObjectClassInArray:[[self class] propertyObjectClassInArray:key] forClass:[self class]];
                }
                free(ivar);
            }
        }
        free(properties);
        subclass = [subclass superclass];
    }
    
    // Cache and return array
    objc_setAssociatedObject([self class], _cmd, array, 
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return array;
}


+ (void)enumerateClassesWithBlock:(TCBaseClassesBlock)block
{
    // 1.没有block就直接返回
    if (block == nil) return;
    
    // 2.停止遍历的标记
    BOOL stop = NO;
    
    // 3.当前正在遍历的类
    Class c = self;
    
    // 4.开始遍历每一个类
    while (c && !stop) {
        // 4.1.执行操作
        block(c, &stop);
        
        // 4.2.获得父类
        c = class_getSuperclass(c);
        
        if ([self isClassFromFoundation:c]) break;
    }
}



+ (Class)propertyObjectClassInArray:(NSString *)propertyName
{
    __block id class = nil;
    if ([self respondsToSelector:@selector(objectClassInArray)]) {
        class = [self objectClassInArray][propertyName];
    }
    
    if (!class) {
        [self enumerateClassesWithBlock:^(__unsafe_unretained Class c, BOOL *stop) {
            NSDictionary *dict = objc_getAssociatedObject(c, &TCMapObjectClassInArrayKey);
            if (dict) {
                class = dict[propertyName];
            }
            if (class) *stop = YES;
        }];
    }
    
    // 如果是NSString类型
    if ([class isKindOfClass:[NSString class]]) {
        class = NSClassFromString(class);
    }
    return class;
}



/** 模型数组中的模型类型 */
- (void)setObjectClassInArray:(Class)objectClass forClass:(Class)c
{
    if (!objectClass) return;
    
    NSMutableDictionary *arryDic = objc_getAssociatedObject([self class], _cmd);
    if (!arryDic)
    {
        arryDic = [NSMutableDictionary dictionary];
    }
    
    arryDic[NSStringFromClass(c)] = objectClass;
    
    objc_setAssociatedObject([self class], &TCMapObjectClassInArrayKey, arryDic,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - TCBaseMapObjectDeleagte

- (NSDictionary *)mappingDictionary
{
    return nil;
}


- (BOOL)mapToInstance:(NSDictionary *)dic
{
    return (nil != dic && [dic isKindOfClass:[NSDictionary class]] && dic.count > 0);
}


+ (NSArray *)mapToInstanceList:(NSArray *)arry
{
    NSMutableArray *tmpArry = [NSMutableArray array];
    if (nil != arry && [arry isKindOfClass:[NSArray class]] && arry.count > 0)
    {
        for (NSDictionary *dic in arry)
        {
            TCBaseMapObject *obj = [[[self class] alloc] init];
            if ([obj mapToInstance:dic])
            {
                [tmpArry addObject:obj];
            }
        }
    }
    
    return [NSArray arrayWithArray:tmpArry];
}


+ (NSArray *)mapAutoInstanceList:(NSArray *)arry
{
    NSMutableArray  *tmpArry = [NSMutableArray array];
    if (nil != arry && [arry isKindOfClass:[NSArray class]] && arry.count) {
        for (NSDictionary *dic in arry) {
            TCBaseMapObject *obj = [[self class] initWithDictionary:dic];
            [tmpArry addObject:obj];
        }
    }
    
    return [NSArray arrayWithArray:tmpArry];
}


+ (NSArray *)mapCustomAutoInstanceList:(NSArray *)arry
{
    NSMutableArray  *tmpArry = [NSMutableArray array];
    if (nil != arry && [arry isKindOfClass:[NSArray class]] && arry.count) {
        for (NSDictionary *dic in arry) {
            TCBaseMapObject *obj = [[self class] init];
            if ([obj mapToInstance:dic]) {
                [obj objectFromDictionary:dic];
            }
            [tmpArry addObject:obj];
        }
    }
    
    return [NSArray arrayWithArray:tmpArry];
}


+ (NSDictionary *)objectClassInArray
{
    return nil;
}



@end
