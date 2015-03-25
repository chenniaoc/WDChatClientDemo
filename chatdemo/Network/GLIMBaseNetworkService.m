//
//  GLIMBaseNetworkService.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLIMBaseNetworkService.h"
#import "WDIMClient.h"
#import "GLIMNetworkUtil.h"

@implementation GLIMBaseNetworkService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clientVersion = GLIM_CLIENT_VERSION;
        self.version = GLIM_VERSION;
    }
    
    return self;
}

- (GLIM_CS_Header *)csHeader
{
    return nil;
}

- (void)requestWithCompletionBlock:(IMCompletionBlock)block
{
    
    NSData *headerData = [self packReqData];
    GCDAsyncSocket *socket = [WDIMClient instance].asyncSocket;
    [socket writeData:headerData withTimeout:-1 tag:0];
    [socket readDataWithTimeout:-1 tag:0];
    
}

- (UInt32)generateReqId
{
    static UInt32 reqId = 0;
    return reqId++;
}

- (CProtocolClientReqBuilder *)generatePBHeader
{
    CProtocolClientReqBuilder *pbHeader = [CProtocolClientReq builder];
    
    if (![self respondsToSelector:@selector(requestPBCMD)]
        || ![self respondsToSelector:@selector(requestPBSubCMD)]) {
        return nil;
    }
    [pbHeader setCmd:[self requestPBCMD]];
    [pbHeader setSubCmd:[self requestPBSubCMD]];
    [pbHeader setVersion:self.version];
    [pbHeader setSourceType:EConstSourceTypesClientTypeIphoneWeidian];
    
    return pbHeader;
}

- (NSData *)packReqData
{
    
    PBGeneratedMessageBuilder *pbBodyBuilder = nil;
    
    // 从子类实现的pbBodyBuilder方法获取pbBody的Builder对象
    if ([self respondsToSelector:@selector(generatePBBody)]) {
        pbBodyBuilder = [self generatePBBody];
    }
    PBGeneratedMessage *pbody = [pbBodyBuilder build];
    NSMutableData *reqData = [NSMutableData data];
    
    NSData *tmpData = [GLIMNetworkUtil convertPB2Data:pbody];
    
    // 从基类或子类（被重写的情况）实现的pbHeaderBuilder方法获取pbBody的Builder对象
    CProtocolClientReqBuilder *pbHeaderBuilder = nil;
    if ([self respondsToSelector:@selector(generatePBHeader)]) {
        pbHeaderBuilder = [self generatePBHeader];
    }
    [pbHeaderBuilder setProtocolContent:tmpData];
    CProtocolClientReq *pHeader = [pbHeaderBuilder build];
    tmpData = [GLIMNetworkUtil convertPB2Data:pHeader];
    
    
    
    // 从基类或子类（被重写的情况）实现的csHeader方法获取GLIM_CS_Header对象
    GLIM_CS_Header *csHeader = [self csHeader];
    if (tmpData) {
        // 如果子类实现了生成pb数据，那么在header内指定对应的长度
        csHeader.org_len = (UInt32)tmpData.length;
        csHeader.enc_len = (UInt32)tmpData.length;
    }
    
    // 把GLIM_CS_Header instance 转换成NSData
    NSData *headerData = [csHeader encodeData];
    
    // 拼装请求数据
    // 格式为
    // 1.如果有PBBody :[HEADER:NSDATA] + [PBBody:NSData]
    // 2.没有PBBody   : [HEADER:NSDATA]
    [reqData appendData:headerData];
    [reqData appendData:tmpData];
    return reqData;
}

- (id)unpackResData
{
    // todo
    return nil;
}

@end
