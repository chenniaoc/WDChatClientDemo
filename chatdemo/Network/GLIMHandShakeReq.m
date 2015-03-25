//
//  GLIMHandShakeReq.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLIMHandShakeReq.h"
#import "GLIM_CS_Header.h"

@implementation GLIMHandShakeReq

- (NSData *)csHeaderData
{
    GLIM_CS_Header *header = [[GLIM_CS_Header alloc] initWithCMD:HEADER_CMD_HANDSHAKE];
    return [header encodeData];
}

- (GLIM_CS_Header *)csHeader
{
    GLIM_CS_Header *header = [[GLIM_CS_Header alloc] initWithCMD:HEADER_CMD_HANDSHAKE];
    return header;
}

//- (NSData *)packReqData
//{
//    return [self csHeaderData];
//}

@end
