//
//  GLMProtocolCenter.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/26/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GLMProtocolContext.h"
#import "GLMError.h"
#import "GLMBaseNetworkService.h"


#define GLM_MESSAGE_NOTIFY_NOTIFICATION @"GLM_MESSAGE_NOTIFY_NOTIFICATION"

#define GLM_CLIENT_VERSION     @"1.0.0"
#define GLM_VERSION            @"1.0.0"

// User 模块的协议簇
#define GLM_PB_CMD_USER     @"user"

// Message 模块的协议簇
#define GLM_PB_CMD_MSG      @"msg"

// Follow 模块的协议簇
#define GLM_PB_CMD_FOLLOW   @"follow"

