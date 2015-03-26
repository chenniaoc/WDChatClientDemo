//
//  GLMProtocolManager.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/26/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GLMProtocolCenter.h"
#import "Im_base.pb.h"
#import "GLMCS_Header.h"
#import "GLMBaseNetworkService.h"

@interface GLMProtocolManager : NSObject


+ (instancetype)sharedManager;

- (BOOL)registerForService:(GLMBaseNetworkService *)service;

- (void)startRequestWithService:(GLMBaseNetworkService *)service;

- (UInt32)generateSeqNo;

@end
