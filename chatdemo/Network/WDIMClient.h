//
//  WDIMClient.h
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-17.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "cs_header.h"
#import "GLMProtocolCenter.h"

#define IM_SERVER_ADDR @"10.1.21.139"
#define IM_SERVER_PORT 2015

@interface WDIMClient : NSObject

@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;

+ (instancetype)instance;

- (void)startService;

- (void)handshake;

- (void)login;

- (void)loginWithUserID:(NSString *)userID
                    uss:(NSString *)uss
             completion:(GLMCompletionBlock)completionBlock;

- (void)sendMessage;

- (void)sendMessageToUid:(NSString *)uid
                 content:(NSString *)content
                completion:(GLMCompletionBlock)completionBlock;


- (void)readData;

@end
