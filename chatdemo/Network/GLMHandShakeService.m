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

- (E_HEADER_CMD)CS_HEADER_CMD
{
    return HEADER_CMD_HANDSHAKE;
}

//- (NSData *)packReqData
//{
//    return [self csHeaderData];
//}

@end
