//
//  GLIMHandShakeReq.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMHandShakeService.h"
#import "GLMCS_Header.h"

@implementation GLMHandShakeService

- (GLMCS_Header *)csHeader
{
    GLMCS_Header *header = [[GLMCS_Header alloc] initWithCMD:HEADER_CMD_HANDSHAKE];
    return header;
}

//- (NSData *)packReqData
//{
//    return [self csHeaderData];
//}

@end
