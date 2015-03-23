//
//  WDHandshakeAPI.m
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-17.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "WDHandshakeAPI.h"
#import "cs_header.h"
#import "WDOutputStreamData.h"

@implementation WDHandshakeAPI

- (NSData *)headerData
{
    WDOutputStreamData *data = [[WDOutputStreamData alloc] init];
    // version
    [data writeInt:CS_HEADER_VERSION];
    // magic_num
    [data writeInt:CS_HEADER_MAGIC];
    // cmd
    [data writeShort:HEADER_CMD_HANDSHAKE];
    // proto_flag
    [data writeChar:CONNECT_STATUS_STEP_1]; // connect_status
    [data writeChar:SYM_METHOD_NONE];       // E_SYM_METHOD
    
    // 原始长度
    [data writeInt:8];
    // 加密后长度
    [data writeInt:8];
    // reserved1
    [data writeInt:0];
    // reserved2
    [data writeInt:0];
    
    
//    [data writeInt:0];
//    [data writeInt:0];

    NSData *headerData = [NSData dataWithBytes:data.data.bytes length:data.length];
    return headerData;
}

@end
