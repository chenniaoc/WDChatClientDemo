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
#import "GLMNotificationForwardCenter.h"
#import "GLMMessageSendMsgService.h"



/**
 *  与服务器约定的客户端版本号
 */
#define GLM_CLIENT_VERSION     @"1.0.0"
/**
 * 与服务器约定的IM Server版本号
 */
#define GLM_VERSION            @"1.0.0"

// User 模块的协议簇名称
#define GLM_PB_CMD_USER     @"user"

// Message 模块的协议簇名称
#define GLM_PB_CMD_MSG      @"msg"

// Follow 模块的协议簇名称
#define GLM_PB_CMD_FOLLOW   @"follow"

