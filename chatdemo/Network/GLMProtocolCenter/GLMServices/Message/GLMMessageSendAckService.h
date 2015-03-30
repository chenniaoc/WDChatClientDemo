//
//  GLMMessageSendAckService.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/28/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMBaseNetworkService.h"
#import "GLMProtocolCenter.h"

@interface GLMMessageSendAckService : GLMBaseNetworkService

/// 要确认的消息的发送⽅方客户端类型
@property (nonatomic, assign) EConstSourceTypes ack_source_type;

/// 要确认的消息发送⽅方⽤用户id
@property (nonatomic, assign) UInt64 ack_uid;

/// 要确认的消息的消息id
@property (nonatomic, assign) UInt64 ack_msgid;

@end
