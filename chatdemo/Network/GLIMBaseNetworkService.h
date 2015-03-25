//
//  GLIMBaseNetworkService.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ProtocolBuffers/ProtocolBuffers.h>
#import "Im_base.pb.h"
#import "GLIMNetworkServiceProtocol.h"
#import "cs_header.h"
#import "GLIM_CS_Header.h"

#define GLIM_CLIENT_VERSION     @"1.0.0"
#define GLIM_VERSION            @"1.0.0"

typedef void(^IMCompletionBlock)(id responeObject, NSError *error);

@interface GLIMBaseNetworkService : NSObject <GLIMNetworkServiceProtocol>

@property (nonatomic, copy) IMCompletionBlock completionBlock;

@property (nonatomic, strong) NSString *clientVersion;

@property (nonatomic, strong) NSString *version;


- (void)requestWithCompletionBlock:(IMCompletionBlock)block;


- (GLIM_CS_Header *)csHeader;

- (UInt32)generateReqId;

- (CProtocolClientReqBuilder *)generatePBHeader;

//- (PBGeneratedMessageBuilder *)generatePBBody;


@end
