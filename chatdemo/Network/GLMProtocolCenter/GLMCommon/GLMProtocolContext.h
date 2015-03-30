//
//  GLMCommonContext.h
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-27.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLMProtocolContext;

GLMProtocolContext* GLMGetProtocolContext();

@interface GLMProtocolContext : NSObject

+ (instancetype)sharedContext;

@property (nonatomic, assign) UInt64 userID;

@end
