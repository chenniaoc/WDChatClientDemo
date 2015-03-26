//
//  GLIMServiceProtocol.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLMCS_Header.h"
#import <ProtocolBuffers/ProtocolBuffers.h>


@protocol GLMNetworkServiceProtocol <NSObject>

@optional

/*************************************************
 *
 * 设置需求请求的PB CMD.各个业务的子类必须实现
 *
 *************************************************/
- (id)requestPBCMD;

/*************************************************
 *
 * 设置需求请求的PB SUB_CMD.各个业务的子类必须实现
 *
 *************************************************/
- (id)requestPBSubCMD;


/*************************************************
 *
 * 子类可以不实现此方法，默认返回子类实现的requestPBCMD
 * 原因：目前看来response的cmd与request的cmd一致，
 *      先预留着，以备扩展。
 *
 *************************************************/
- (id)responsePBCMD;

/*************************************************
 *
 * 子类可以不实现此方法，默认返回子类实现的requestPBSubCMD
 * 原因：目前看来response的subCmd与request的subCmd一致，
 *      先预留着，以备扩展。
 *
 *************************************************/

- (id)responsePBSubCMD;

- (PBGeneratedMessageBuilder *)generatePBBody;

@required
- (GLMCS_Header *)csHeader;

//- (CProtocolClientReqBuilder *)generatePBHeader;

//- (PBGeneratedMessageBuilder *)generatePBBody;

//- (NSData *)packReqData;

- (id)unpackResData;

@end
