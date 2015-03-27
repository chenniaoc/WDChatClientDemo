//
//  GLMMessageSendMsgService.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/26/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMBaseNetworkService.h"

@interface GLMMessageSendMsgService : GLMBaseNetworkService

@property (nonatomic, assign) UInt64 from_uid;
@property (nonatomic, assign) UInt64 to_uid;
@property (nonatomic, assign) UInt64 time;


@end
