//
//  GLIMLoginReq.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "Im_base.pb.h"
#import "User.pb.h"

#import "GLMUserLoginService.h"
#import "GLMCS_Header.h"
#import "GLMNetworkUtil.h"
#import "GLMProtocolContext.h"

@implementation GLMUserLoginService

/**
 * 需要实现requestPBCMD，返回PB的CMD
 * 返回PB的CMD
 *
 *  @return @"user"
 */
- (id)requestPBCMD
{
    return @"user";
}

/**
 * 需要实现requestPBCMD，
 * 返回对应PB的SUB_CMD
 *
 *  @return @"login"
 */
- (id)requestPBSubCMD
{
    return @"login";
}

/**
 *  需要实现CS_HEADER_CMD，返回对应CS_HEADER的CMD
 *
 *  @return HEADER_CMD_LOGIN
 */
- (E_HEADER_CMD)CS_HEADER_CMD
{
    return HEADER_CMD_LOGIN;
}

/**
 * 业务自己需要负责生成业务对应的PBBody Instance
 *
 *  @return CUserLoginReqBuilder Instance
 */
- (PBGeneratedMessage *)generatePBBody
{
    // PB user login
    CUserLoginReqBuilder *lb = [CUserLoginReq builder];
    [lb setSid:self.sid];
    [lb setUss:self.uss];
    [lb setClientVersion:[self clientVersion]];
    
    return [lb build];
}

/**
 * 如果需要处理服务器返回的response，需要自己从PBResHeader，解析出login协议对应的
 * PBResp Body，login对应的是CUserLoginResp。
 * 幷根绝自己的业务判断是否要回掉completionBlock
 *
 *  @param PBResHeader 此次请求服务器返回的PB Header Data
 *
 *  @return YES 处理成功，如果不处理返回No
 */
- (BOOL)processForPBResHeader:(CProtocolServerResp*)PBResHeader
{
    NSData *pbBodyData = PBResHeader.protocolContent;
    CUserLoginResp *loginResp = [CUserLoginResp parseFromData:pbBodyData];
    if (loginResp) {
        GLMProtocolContext *mpc = GLMGetProtocolContext();
        mpc.userID = loginResp.uid;
        self.completionBlock(loginResp, nil);
        return YES;
    }
    return NO;
}

@end
