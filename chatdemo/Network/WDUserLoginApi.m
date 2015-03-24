//
//  WDUserLoginApi.m
//  WDChatDemo
//
//  Created by zhangyuchen on 3/24/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "WDUserLoginApi.h"
#import "Im_base.pb.h"
#import "User.pb.h"
#import "WDOutputStreamData.h"
#import "cs_header.h"

@implementation WDUserLoginApi

- (NSData *)headerDataWithBodyData:(NSData *)body
{
    
    UInt32 bodyLength = (UInt32)body.length;
    WDOutputStreamData *data = [[WDOutputStreamData alloc] init];
    // version
    [data writeInt:CS_HEADER_VERSION];
    // magic_num
    [data writeInt:CS_HEADER_MAGIC];
    // cmd
    [data writeShort:HEADER_CMD_LOGIN];
    // proto_flag
    [data writeChar:CONNECT_STATUS_STEP_1]; // connect_status
    [data writeChar:SYM_METHOD_NONE];       // E_SYM_METHOD
    
    // 原始长度
    [data writeInt:bodyLength];
    // 加密后长度
    [data writeInt:bodyLength];
    // reserved1
    [data writeInt:0];
    // reserved2
    [data writeInt:0];
    
    [data.data appendData:body];

    return data.data;
}

- (NSData *)bodyData
{
    static int seqId = 0;
    NSOutputStream *rawos = [[NSOutputStream alloc] initToMemory];
    
    [rawos open];
    // PB req client header
    CProtocolClientReqBuilder *reqBuilder = [[CProtocolClientReq builder] setCmd:@"user"];
    [reqBuilder setSubCmd:@"login"];
    [reqBuilder setSeq:++seqId];
    [reqBuilder setVersion:@"1.0.0"];
    [reqBuilder setSourceType:EConstSourceTypesClientTypeAndroidDaigou];
    
    NSOutputStream *rawBodyOS = [[NSOutputStream alloc] initToMemory];
    [rawBodyOS open];
    // PB user login
    CUserLoginReqBuilder *lb = [CUserLoginReq builder];
    [lb setSid:@"368095437"];
    [lb setUss:@"ad7947f8c1839c42f00de546370263d4"];
    [lb setClientVersion:@"1.0.0"];
    CUserLoginReq *lbr = [lb build];
    [lbr writeToOutputStream:rawBodyOS];
    
    NSData *pbBodyData = [rawBodyOS propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    [reqBuilder setProtocolContent:pbBodyData];
    CProtocolClientReq *cr = [reqBuilder build];
    [cr writeToOutputStream:rawos];
    
    NSData *data2 = [rawos propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    
    return data2;
}

- (NSData*)request
{
    NSMutableData *reqData = [NSMutableData data];
    
    NSData *bodyData = [self bodyData];
    
    reqData = [self headerDataWithBodyData:bodyData];
    
    return reqData;
}

@end
