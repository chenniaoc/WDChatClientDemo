//
//  GLIMServiceProtocol.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLIM_CS_Header.h"
#import <ProtocolBuffers/ProtocolBuffers.h>

@protocol GLIMNetworkServiceProtocol <NSObject>

@optional

/*************************************************
 *
 *
 *
 *************************************************/
- (id)requestPBCMD;

- (id)requestPBSubCMD;

- (id)responsePBCMD;

- (id)responsePBSubCMD;

- (PBGeneratedMessageBuilder *)generatePBBody;

@required
- (GLIM_CS_Header *)csHeader;

//- (CProtocolClientReqBuilder *)generatePBHeader;

//- (PBGeneratedMessageBuilder *)generatePBBody;

//- (NSData *)packReqData;

- (id)unpackResData;

@end
