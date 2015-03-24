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
    
    NSUInteger bodyLength = body.length;
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

- (WDOutputStreamData *)bodyData
{
    WDOutputStreamData *data = nil;
    
    NSOutputStream *rawos = [[NSOutputStream alloc] initToMemory];
    
    [rawos open];
    // PB req client header
    CProtocolClientReqBuilder *reqBuilder = [[CProtocolClientReq builder] setCmd:@"msg"];
    [reqBuilder setSubCmd:@"login"];
    [reqBuilder setSeq:1];
    [reqBuilder setSourceType:EConstSourceTypesClientTypeIphoneWeidian];
    CProtocolClientReq *cr = [reqBuilder build];
    SInt32 headerSize =  cr.serializedSize;
    
    [cr writeToOutputStream:rawos];
    
    // PB user login
    CUserLoginReqBuilder *lb = [CUserLoginReq builder];
    [lb setSid:@"13042"];
    [lb setUss:@"Wm85FefWB0mcZwbSvfZ8B0zgDSQjVl2kU2Fm3UWIJNpI3D"];
    CUserLoginReq *lbr = [lb build];
    SInt32 bodySize = lbr.serializedSize;
    [rawos open];
//    PBCodedOutputStream *bos = [PBCodedOutputStream streamWithData:bodyData];
//    [lbr writeToCodedOutputStream:bos];
    [lbr writeToOutputStream:rawos];
//    [bos flush];
    
    
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
