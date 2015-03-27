//
//  GLMMessageSendNotifyService.m
//  WDChatDemo
//
//  Created by zhangyuchen on 3/27/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMProtocolCenter.h"
#import "GLMMessageSendNotifyService.h"

@implementation GLMMessageSendNotifyService

- (id)requestPBCMD
{
    return @"msg";
}

- (id)requestPBSubCMD
{
    return @"send_notify";
}

- (BOOL)processForPBResHeader:(CProtocolServerResp*)PBResHeader
{
    NSData *pbBodyData = PBResHeader.protocolContent;
    CMsgPBContent *msgContent = [CMsgPBContent parseFromData:pbBodyData];
    if (msgContent) {
        if (self.completionBlock) {
            self.completionBlock(msgContent, nil);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:GLM_MESSAGE_NOTIFY_NOTIFICATION object:msgContent.msgData];
        
        return YES;
    }
    return NO;
}


@end
