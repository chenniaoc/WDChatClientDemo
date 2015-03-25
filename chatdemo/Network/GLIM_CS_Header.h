//
//  GLIM_CS_Header.h
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-25.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cs_header.h"

////CMD
//typedef enum GLIM_CS_HEADER_CMD
//{
//    HEADER_CMD_HANDSHAKE = 1,
//    HEADER_CMD_COMMON = 2,
//    HEADER_CMD_KEEPALIVE = 3,
//    HEADER_CMD_LOGIN = 4,
//    HEADER_CMD_LOGOUT = 5,
//    HEADER_CMD_KICKOUT = 6,
//    HEADER_CMD_QUICK_CONNECT = 7,
//    HEADER_CMD_SET_BACKGROUND = 8,
//};



@interface GLIM_CS_Header : NSObject

// 协议版本 CS_HEADER_VERSION
@property (nonatomic, assign) UInt32 version;

// 校验标记 CS_HEADER_MAGIC
@property (nonatomic, assign) UInt32 magic_num;

// 命令号 E_HEADER_CMD
@property (nonatomic, assign) E_HEADER_CMD cmd;

// 协议标记 PROTO_FLAG 1.E_CONNECT_STATUS
@property (nonatomic, assign) E_CONNECT_STATUS connect_status;
// 协议标记 PROTO_FLAG 2.E_CONNECT_STATUS
@property (nonatomic, assign) UInt8 sym_method;

// 原始长度
@property (nonatomic, assign) UInt32 org_len;

// 加密后长度
@property (nonatomic, assign) UInt32 enc_len;

// reserved1
@property (nonatomic, assign) UInt32 reserved1;
// reserved2
@property (nonatomic, assign) UInt32 reserved2;

// 请求数据区域
@property (nonatomic, assign) UInt8 *bodyDataBytes;


+ (instancetype)headerFromData:(NSData *)data;

- (UInt8 *)encodeBytes;

- (NSData *)encodeData;

@end
