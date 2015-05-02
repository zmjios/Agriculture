/*
 *  pinyin.h
 *  Chinese Pinyin First Letter
 *
 *  Created by George on 4/21/10.
 *  Copyright 2010 RED/SAFI. All rights reserved.
 *
 */

#include <ctype.h>

#if !defined(NS_INLINE)
#if defined(__GNUC__)
#define NS_INLINE static __inline__ __attribute__((always_inline))
#elif defined(__MWERKS__) || defined(__cplusplus)
#define NS_INLINE static inline
#elif defined(_MSC_VER)
#define NS_INLINE static __inline
#elif TARGET_OS_WIN32
#define NS_INLINE static __inline__
#endif
#endif


#define TC_HANZI_START  19968U
#define TC_HANZI_COUNT  20902
#define TC_ALPHA        @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"


extern char tc_firstLetterArray_g[TC_HANZI_COUNT];


NS_INLINE char pinyinFirstLetter(unsigned short hanzi)
{
    unsigned int index = hanzi - TC_HANZI_START;
    return index <= TC_HANZI_COUNT ? tc_firstLetterArray_g[index] : hanzi;
}

NS_INLINE char pinyinFirstLetter2(unsigned short hanzi)
{
    char first = pinyinFirstLetter(hanzi);
    
    return isalpha(first) ? toupper(first) : '#';
}



