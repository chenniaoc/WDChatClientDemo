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
#import "GLMNetworkServiceProtocol.h"
#import "cs_header.h"
#import "GLMCS_Header.h"

#define GLM_CLIENT_VERSION     @"1.0.0"
#define GLM_VERSION            @"1.0.0"

typedef void(^GLMCompletionBlock)(id responeObject, NSError *error);

@interface GLMBaseNetworkService : NSObject <GLMNetworkServiceProtocol>

@property (nonatomic, copy) GLMCompletionBlock completionBlock;

@property (nonatomic, strong) NSString *clientVersion;

@property (nonatomic, strong) NSString *version;


- (void)requestWithCompletionBlock:(GLMCompletionBlock)block;


- (GLMCS_Header *)csHeader;

- (UInt32)generateSeqId;

- (CProtocolClientReqBuilder *)generatePBHeader;

//- (PBGeneratedMessageBuilder *)generatePBBody;


@end
