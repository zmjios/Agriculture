//
//  NSString+EncodingURL.m
//  DragonWell
//
//  Created by  jacob.Chiang on 13-1-6.
//  Copyright (c) 2013年 TCGROUP. All rights reserved.
//

#import "NSString+EncodingURL.h"

@implementation NSString (EncodingURL)

- (NSString *)encodeURL
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
	return nil != newString ? newString : nil;
}

@end
