//
//  GLMCS_Header.m
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-25.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "GLMCS_Header.h"
#import "GLMInputStreamData.h"
#import "GLMOutputStreamData.h"


@implementation GLMCS_Header

- (instancetype)initWithCMD:(E_HEADER_CMD)cmd
{
    switch (cmd) {
        case HEADER_CMD_HANDSHAKE:
            self = [self init];
            self.cmd = HEADER_CMD_HANDSHAKE;
            self.enc_len = 8;
            self.org_len = 8;
            break;
            
        case HEADER_CMD_LOGIN:
            self = [self init];
            self.cmd = HEADER_CMD_LOGIN;
            break;

        default:
            self = [self init];
            self.cmd = HEADER_CMD_COMMON;
            break;
    }
    
    if (cmd != HEADER_CMD_HANDSHAKE) {
        // 只有握手协议使用step-1
        self.connect_status = CONNECT_STATUS_OK;
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // default values
        self.version = CS_HEADER_VERSION;
        self.magic_num = CS_HEADER_MAGIC;
        self.cmd = HEADER_CMD_COMMON;
        self.connect_status = CONNECT_STATUS_STEP_1;
        self.sym_method = SYM_METHOD_NONE;
        self.org_len = 0;
        self.enc_len = 0;
        self.reserved1 = 0x0;
        self.reserved2 = 0x0;
    }
    return self;
}

+ (instancetype)headerFromData:(NSData *)data
{
    if (data.length < 28) {
        NSLog(@"data is not enough to init a header");
        return nil;
    }
    GLMCS_Header *_newSelf = [GLMCS_Header new];
    
    GLMInputStreamData *isd = [GLMInputStreamData streamWithData:data];
    
    _newSelf.version = [isd readInt];
    _newSelf.magic_num = [isd readInt];
    
    if (![_newSelf validateMagicNumber]) {
        NSLog(@"invalid magic number");
        
        return nil;
    }
    
    _newSelf.cmd = [isd readShort];
    _newSelf.connect_status = [isd readChar];
    _newSelf.sym_method = [isd readChar];
    _newSelf.org_len = [isd readInt];
    _newSelf.enc_len = [isd readInt];
    _newSelf.reserved1 = [isd readInt];
    _newSelf.reserved2 = [isd readInt];
    
    return _newSelf;

}

- (NSData *)encodeData
{
    GLMOutputStreamData  *data = [[GLMOutputStreamData  alloc] init];
    // version
    [data writeInt:self.version];
    
    // magic_num
    [data writeInt:self.magic_num];
    
    //    [data writeIntAsLittleEndian:CS_HEADER_MAGIC];
    // cmd
    [data writeShort:self.cmd];
    // proto_flag
    [data writeChar:self.connect_status]; // connect_status
    [data writeChar:self.sym_method];       // E_SYM_METHOD
    
    // 原始长度
    [data writeInt:self.org_len];
    // 加密后长度
    [data writeInt:self.enc_len];
    // reserved1
    [data writeInt:0];
    // reserved2
    [data writeInt:0];
    if (self.cmd == HEADER_CMD_HANDSHAKE) {
        // reserved2
        [data writeInt:0];
        // reserved2
        [data writeInt:0];
    }
    
    
    return [data mutableData];
}

- (BOOL)validateVersion
{
    return self.version == CS_HEADER_VERSION;
}


- (BOOL)validateMagicNumber
{
    return self.magic_num == CS_HEADER_MAGIC;
}

@end
