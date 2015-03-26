//
//  GLIMLoginReq.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "Im_base.pb.h"
#import "User.pb.h"

#import "GLMLoginService.h"
#import "GLMCS_Header.h"
#import "GLMNetworkUtil.h"

@implementation GLMLoginService

- (id)requestPBCMD
{
    return @"user";
}

- (id)requestPBSubCMD
{
    return @"login";
}

- (E_HEADER_CMD)CS_HEADER_CMD
{
    return HEADER_CMD_LOGIN;
}


- (PBGeneratedMessage *)generatePBBody
{
    // PB user login
    CUserLoginReqBuilder *lb = [CUserLoginReq builder];
    [lb setSid:self.sid];
    [lb setUss:self.uss];
    [lb setClientVersion:[self clientVersion]];
    
    return [lb build];
}

- (BOOL)processForPBResHeader:(CProtocolServerResp*)PBResHeader
{
    NSData *pbBodyData = PBResHeader.protocolContent;
    CUserLoginResp *loginResp = [CUserLoginResp parseFromData:pbBodyData];
    if (loginResp) {
        self.completionBlock(loginResp, nil);
        return YES;
    }
    return NO;
}

@end
