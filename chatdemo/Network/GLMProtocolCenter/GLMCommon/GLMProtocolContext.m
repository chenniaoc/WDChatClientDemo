//
//  GLMCommonContext.m
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-27.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "GLMProtocolContext.h"

GLMProtocolContext* GLMGetProtocolContext()
{
    return [GLMProtocolContext sharedContext];
}

@implementation GLMProtocolContext

+ (instancetype)sharedContext
{
    static GLMProtocolContext *_self = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _self = [GLMProtocolContext new];
        _self.userID = -1;
    });
    
    return _self;
}

@end
