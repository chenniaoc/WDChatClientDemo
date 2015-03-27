//
//  GLMMessageSendMsgService.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/26/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMMessageSendMsgService.h"

@implementation GLMMessageSendMsgService

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
    
    
    builder.fromUid = 7593173432823256053l;
    builder.toUid = 7593173432823256054l;
//    builder.msgid = now_timestamp;
    builder.msgData = @"hello world";
    builder.time = now_timestamp;
    builder.msgType = EConstMsgTypesMsgTypeNormal;
    builder.msgMediaType = EConstMsgMediaTypesMsgMediaTypeText;
    
    return [builder build];
}

- (BOOL)processForPBResHeader:(CProtocolServerResp*)PBResHeader
{
    NSData *pbBodyData = PBResHeader.protocolContent;
    CMsgSendResp *res = [CMsgSendResp parseFromData:pbBodyData];
    if (res) {
        self.completionBlock(res, nil);
        return YES;
    }
    return NO;
}

@end
