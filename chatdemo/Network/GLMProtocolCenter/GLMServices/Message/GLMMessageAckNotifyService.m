//
//  GLMMessageAckNotifyService.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/28/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMMessageAckNotifyService.h"

@implementation GLMMessageAckNotifyService

- (id)requestPBCMD
{
    return @"msg";
}

- (id)requestPBSubCMD
{
    return @"ack_notify";
}

- (BOOL)processForPBResHeader:(CProtocolServerResp*)PBResHeader
{
    NSData *pbBodyData = PBResHeader.protocolContent;
    CMsgAckContent *msgContent = [CMsgAckContent parseFromData:pbBodyData];
    if (msgContent) {
        if (self.completionBlock) {
            self.completionBlock(msgContent, nil);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kGLMNotificationMessageAckNotify object:msgContent];
        
        return YES;
    }
    return NO;
}


@end
