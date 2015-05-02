//
//  NSString+SearchKeyword.h
//  NewYunlu
//
//  Created by ChenQi on 12-11-4.
//  Copyright (c) 2012年 TCGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SearchKeyword)

// 是否是纯数字
- (BOOL)isNumber;

// 是纯字母
- (BOOL)isAlphabet;

// 去除空白符, 换行符, 空格
- (NSString *)clearWhiteString;

// 去除标点符号, 空白符, 换行符, 空格
- (NSString *)clearSymbolAndWhiteString;

// 去除标点符号, 数字, 空白符, 换行符, 空格
- (NSString *)alphabetAndHanzi;

// 返回拼音首字母(大写)
- (NSString *)firstLetterFromHanzi;

// 返回拼音首字母缩写(大写)
- (NSString *)shortPinyinFromHanzi;

// 返回拼音全拼(大写)
- (NSString *)fullPinyinFromHanzi;

@end
