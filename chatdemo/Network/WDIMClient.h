//
//  WDIMClient.h
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-17.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cs_header.h"

#define IM_SERVER_ADDR @"10.1.21.139"
#define IM_SERVER_PORT 2015

@interface WDIMClient : NSObject

+ (instancetype)instance;

- (void)startService;

- (void)handshake;

@end
