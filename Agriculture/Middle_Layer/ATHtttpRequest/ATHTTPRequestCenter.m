//
//  ATHTTPRequestCenter.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/5.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "ATHTTPRequestCenter.h"


static NSString *const kHost = @"http://qxw1142440282.my3w.com/api/";

@implementation ATHTTPRequestCenter

+(instancetype)defaultCenter
{
    static ATHTTPRequestCenter *defaultCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[self alloc] initWithBaseURL:[NSURL URLWithString:kHost]];
    });
    
    return defaultCenter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeoutInterval = 90.0f;
        // You can set urlFilter delegate here to self, or other.
        // self.urlFilter = self;
    }
    return self;
}

- (TCHTTPRequest *)cacheRequestWithMethod:(TCHTTPRequestMethod)method apiUrl:(NSString *)apiUrl host:(NSString *)host
{
    TCHTTPRequest *request = [super cacheRequestWithMethod:method apiUrl:apiUrl host:host];
    [request setCustomHeaderValue:@{@"Content-Type":@"application/json; charset=utf-8"}];
    [request setCustomHeaderValue:@{@"Accept":@"application/json"}];
    
    return request;
}


- (TCHTTPRequest *)requestForRegister:(TCHTTPRequestBeforeRun)beforeBlock withParams:(NSDictionary *)params
{
    TCHTTPRequest *request = [self cacheRequestWithMethod:kTCHTTPRequestMethodPost apiUrl:@"Register" host:nil];
    if (nil != beforeBlock) {
        beforeBlock(request);
    }
    request.parameters = params;
    return [request start:NULL] ? request : nil;
}


@end
