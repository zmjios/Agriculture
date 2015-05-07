//
//  CADisplayLinkHelper.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/7.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "CADisplayLinkHelper.h"

@interface CADisplayLinkHelper ()

@property (nonatomic, copy) CADisplayLinkHelperBlock block;
@property (nonatomic, strong) CADisplayLink *caDisplayLink;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval startTime;

@end


@implementation CADisplayLinkHelper


+ (void)runCADisplayLinkwithDuration:(NSTimeInterval)duration block:(CADisplayLinkHelperBlock)block
{
    CADisplayLinkHelper *helper = [[CADisplayLinkHelper alloc] init];
    helper.duration = duration;
    helper.block = block;
    
    helper.caDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startFlash)];
    [helper.caDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}



- (void)startFlash
{
    if (self.startTime == 0) {
        self.startTime = self.caDisplayLink.timestamp;
    }
    
    CFTimeInterval elapsed = self.caDisplayLink.timestamp - self.startTime;
    
    if (elapsed > self.duration) {
        [self.caDisplayLink invalidate];
    } else {
        self.block(elapsed / self.duration);
    }
}

@end
