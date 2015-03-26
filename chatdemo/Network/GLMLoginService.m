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

- (GLMCS_Header *)csHeader
{
    GLMCS_Header *header = [[GLMCS_Header alloc] initWithCMD:HEADER_CMD_LOGIN];
    return header;
}

- (PBGeneratedMessageBuilder *)generatePBBody
{
    // PB user login
    CUserLoginReqBuilder *lb = [CUserLoginReq builder];
    [lb setSid:self.sid];
    [lb setUss:self.uss];
    [lb setClientVersion:[self clientVersion]];
    
    return lb;
}

@end
