//
//  GLIM_CS_Header.m
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-25.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "GLIM_CS_Header.h"

@implementation GLIM_CS_Header

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
    GLIM_CS_Header *_newSelf = [GLIM_CS_Header new];
    
    const int *dataBytes = data.bytes;
    NSUInteger dataLength = data.length;

    _newSelf.version = htonl(*dataBytes);

    dataBytes++;
    _newSelf.magic_num = htonl(*dataBytes);
    
    return _newSelf;

}

@end
