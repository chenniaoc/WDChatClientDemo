//
//  GLMSendMsgService.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/26/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMSendMsgService.h"

@implementation GLMSendMsgService

- (id)requestPBCMD
{
    return @"msg";
}

- (id)requestPBSubCMD
{
    return @"send";
}


- (PBGeneratedMessage *)generatePBBody
{
    CMsgPBContentBuilder *builder = [CMsgPBContent builder];
    NSTimeInterval  now_timestamp = [[NSDate date] timeIntervalSince1970];
    
    
    builder.fromUid = 7593173432823256053;
    builder.toUid = 0;
    builder.msgid = now_timestamp;
    builder.msgData = @"hello world";
    builder.time = now_timestamp;
    builder.msgType = EConstMsgTypesMsgTypeNormal;
    builder.msgMediaType = EConstMsgMediaTypesMsgMediaTypeText;
    
    return [builder build];
}

@end
