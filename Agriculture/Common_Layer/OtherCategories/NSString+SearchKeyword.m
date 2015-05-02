//
//  NSString+SearchKeyword.m
//  NewYunlu
//
//  Created by ChenQi on 12-11-4.
//  Copyright (c) 2012年 TCGROUP. All rights reserved.
//

#import "NSString+SearchKeyword.h"

#import "pinyin.h"
#import "POAPinyin.h"

#define kNUMBER_REGX    @"^[0-9]*$"
#define kALPHA_REGX     @"^[a-zA-Z]*$"

@implementation NSString (SearchKeyword)

// 是否是纯数字
- (BOOL)isNumber
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kNUMBER_REGX];
    return [prd evaluateWithObject:self];
}

- (BOOL)isAlphabet
{
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kALPHA_REGX];
    return [prd evaluateWithObject:self];
}

- (NSString *)clearWhiteString
{
    NSMutableCharacterSet *trimSet = [[NSMutableCharacterSet alloc] init];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet controlCharacterSet]];
    
    // 去掉前后空格、换行符
    NSString *trimText = [self stringByTrimmingCharactersInSet:trimSet];
    // 去掉中间的空格
    trimText = [trimText stringByReplacingOccurrencesOfString:@" " withString:@""];
    trimText = [trimText stringByReplacingOccurrencesOfString:@"　" withString:@""];
    
    return trimText;

}

- (NSString *)alphabetAndHanzi
{
    NSMutableCharacterSet *trimSet = [[NSMutableCharacterSet alloc] init];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet controlCharacterSet]];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
    
    // 去掉前后空格、换行符、数字、标点等
    NSString *trimText = [self stringByTrimmingCharactersInSet:trimSet];
    // 去掉中间的空格
    trimText = [trimText stringByReplacingOccurrencesOfString:@" " withString:@""];
    trimText = [trimText stringByReplacingOccurrencesOfString:@"　" withString:@""];
    
    return trimText;
}


- (NSString *)clearSymbolAndWhiteString
{
    NSMutableCharacterSet *trimSet = [[NSMutableCharacterSet alloc] init];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet controlCharacterSet]];
    [trimSet formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
    
    // 去掉前后空格、换行符、标点等
    NSString *trimText = [self stringByTrimmingCharactersInSet:trimSet];
    // 去掉中间的空格
    trimText = [trimText stringByReplacingOccurrencesOfString:@" " withString:@""];
    trimText = [trimText stringByReplacingOccurrencesOfString:@"　" withString:@""];
    
    return trimText;
}


- (NSString *)firstLetterFromHanzi
{
    return self.length > 0 ? [NSString stringWithFormat:@"%c", pinyinFirstLetter2([self characterAtIndex:0])] : @"#";
}

- (NSString *)shortPinyinFromHanzi
{    
    NSString *str = @"";
    NSInteger len = self.length;
    for (NSInteger i = 0; i < len; ++i)
    {
        str = [NSString stringWithFormat:@"%@%c", str, pinyinFirstLetter([self characterAtIndex:i])];
    }
    
    //    DLog(@"%@-----%@", self, str);
    return [str uppercaseString];
}

- (NSString *)fullPinyinFromHanzi
{
    return self.length > 0 ? [POAPinyin convert:self] : self;
}

@end
