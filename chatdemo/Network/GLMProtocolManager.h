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


/**
 *  如果要请求的service需要处理服务器返回的response，
 *  需要在发起request之前把service注册到映射内。
 *
 *  @param service 需要通知回掉的service
 *
 *  @return YES 注册成功，否则 NO
 */
- (BOOL)registerForService:(GLMBaseNetworkService *)service;


/**
 *  向服务端发起请求。
 *
 *  @param service 需要发起的特定service
 */
- (void)startRequestWithService:(GLMBaseNetworkService *)service;

- (void)startHeartbreakSchedule;


/**
 *  生成每次service的唯一Sequence Number
 *
 *  @return 自增的seq no
 */
- (UInt32)generateSeqNo;

@end
