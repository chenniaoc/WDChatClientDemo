//
//  GLMMessageSendAckService.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/28/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMMessageSendAckService.h"

@implementation GLMMessageSendAckService

- (id)requestPBCMD
{
    return @"msg";
}

- (id)requestPBSubCMD
{
    return @"send_ack";
}

- (PBGeneratedMessage *)generatePBBody
{
    CMsgAckContentBuilder cb = [CMsgAckContent builder];
    
    cb.ackSourceType = self.ack_source_type;
    cb.ackUid = self.ack_uid;
    cb.ackMsgid = self.ack_msgid;
    
    return [cb build];
    
}

- (BOOL)processForPBResHeader:(CProtocolServerResp*)PBResHeader
{
    NSData *pbBodyData = PBResHeader.protocolContent;
    CMsgSendAckResp *msgContent = [CMsgSendAckResp parseFromData:pbBodyData];
    if (msgContent) {
        if (self.completionBlock) {
            self.completionBlock(msgContent, nil);
        }
        return YES;
    }
    return NO;
}


@end
