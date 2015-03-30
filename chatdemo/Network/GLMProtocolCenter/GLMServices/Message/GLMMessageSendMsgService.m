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
    
    
    builder.fromUid = self.from_uid;
    builder.toUid = self.to_uid;
//    builder.msgid = now_timestamp;
//    [self.messageContent dataUsingEncoding:NSUTF8StringEncoding];
    builder.msgData = self.messageContent;
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
