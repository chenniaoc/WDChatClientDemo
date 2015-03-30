//
//  GLIMBaseNetworkService.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMBaseNetworkService.h"
#import "WDIMClient.h"
#import "GLMNetworkUtil.h"
#import "GLMProtocolManager.h"

@implementation GLMBaseNetworkService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clientVersion = GLM_CLIENT_VERSION;
        self.version = GLM_VERSION;
    }
    
    return self;
}

- (E_HEADER_CMD)CS_HEADER_CMD
{
    return HEADER_CMD_COMMON;
}

/*************************************************
 *
 * 发起一个请求。
 *
 *************************************************/
- (void)requestWithCompletionBlock:(GLMCompletionBlock)block
{

    // 如果设置了callback block,start之前,需要注册自己。
    if (block) {
        [[GLMProtocolManager sharedManager] registerForService:self];
        self.completionBlock = block;
    }
    
    // 发起一个write请求
    [[GLMProtocolManager sharedManager] startRequestWithService:self];
}

/*************************************************
 *
 * 子类如果不实现此方法，默认返回子类实现的requestPBCMD
 *
 *************************************************/
- (id)responsePBCMD
{
    return [self requestPBCMD];
}

/*************************************************
 *
 * 子类如果不实现此方法，默认返回子类设置的requestPBSubCMD
 *
 *************************************************/
- (id)responsePBSubCMD
{
    return [self requestPBSubCMD];
}

//- (CProtocolClientReqBuilder *)generatePBHeader
//{
//    CProtocolClientReqBuilder *pbHeader = [CProtocolClientReq builder];
//    
//    if (![self respondsToSelector:@selector(requestPBCMD)]
//        || ![self respondsToSelector:@selector(requestPBSubCMD)]) {
//        return nil;
//    }
//    [pbHeader setCmd:[self requestPBCMD]];
//    [pbHeader setSubCmd:[self requestPBSubCMD]];
//    [pbHeader setVersion:self.version];
//    [pbHeader setSourceType:EConstSourceTypesClientTypeIphoneWeidian];
//    
//    return pbHeader;
//}

//- (NSData *)packReqData
//{
//    
//    PBGeneratedMessage *pbBody= nil;
//    
//    // 从子类实现的pbBodyBuilder方法获取pbBody的Builder对象
//    if ([self respondsToSelector:@selector(generatePBBody)]) {
//        pbBody = [self generatePBBody];
//    }
//    NSMutableData *reqData = [NSMutableData data];
//    
//    NSData *tmpData = [GLMNetworkUtil convertPB2Data:pbBody];
//    
//    // 从基类或子类（被重写的情况）实现的pbHeaderBuilder方法获取pbBody的Builder对象
//    CProtocolClientReqBuilder *pbHeaderBuilder = nil;
//    if ([self respondsToSelector:@selector(generatePBHeader)]) {
//        pbHeaderBuilder = [self generatePBHeader];
//    }
//    [pbHeaderBuilder setProtocolContent:tmpData];
//    CProtocolClientReq *pHeader = [pbHeaderBuilder build];
//    tmpData = [GLMNetworkUtil convertPB2Data:pHeader];
//    
//    
//    
//    // 从基类或子类（被重写的情况）实现的csHeader方法获取GLMCS_Header对象
//    GLMCS_Header *csHeader = [self csHeader];
//    if (tmpData) {
//        // 如果子类实现了生成pb数据，那么在header内指定对应的长度
//        csHeader.org_len = (UInt32)tmpData.length;
//        csHeader.enc_len = (UInt32)tmpData.length;
//    }
//    
//    // 把GLMCS_Header instance 转换成NSData
//    NSData *headerData = [csHeader encodeData];
//    
//    // 拼装请求数据
//    // 格式为
//    // 1.如果有PBBody :[HEADER:NSDATA] + [PBBody:NSData]
//    // 2.没有PBBody   : [HEADER:NSDATA]
//    [reqData appendData:headerData];
//    [reqData appendData:tmpData];
//    return reqData;
//}
//
//- (id)unpackResData
//{
//    // todo
//    return nil;
//}

@end
