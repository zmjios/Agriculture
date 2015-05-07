//
//  ATHTTPRequestCenter.h
//  Agriculture
//
//  Created by 曾明剑 on 15/5/5.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "TCHTTPRequestCenter.h"


@class TCHTTPRequest;
typedef  void(^TCHTTPRequestBeforeRun)(TCHTTPRequest *request);

@interface ATHTTPRequestCenter : TCHTTPRequestCenter


- (TCHTTPRequest *)requestForRegister:(TCHTTPRequestBeforeRun)beforeBlock withParams:(NSDictionary *)params;









@end
