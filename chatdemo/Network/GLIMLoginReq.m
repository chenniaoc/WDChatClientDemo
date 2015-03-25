//
//  GLIMLoginReq.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLIMLoginReq.h"
#import "Im_base.pb.h"
#import "User.pb.h"
#import "GLIM_CS_Header.h"
#import "GLIMNetworkUtil.h"

@implementation GLIMLoginReq

- (id)requestPBCMD
{
    return @"user";
}

- (id)requestPBSubCMD
{
    return @"login";
}

- (GLIM_CS_Header *)csHeader
{
    GLIM_CS_Header *header = [[GLIM_CS_Header alloc] initWithCMD:HEADER_CMD_LOGIN];
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
