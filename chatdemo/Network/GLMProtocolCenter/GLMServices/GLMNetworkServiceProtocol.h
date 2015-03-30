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
 * 设置请求的CS_HEADER_CMD.
 * 默认HEADER_CMD_COMMON类型。
 * 如有特殊变更，各个业务的子类重写此方法。
 *          例如，Login的CMD是HEADER_CMD_LOGIN，
 *          所以，需要重写此方法，返回login的cmd。
 *
 *************************************************/
- (E_HEADER_CMD)CS_HEADER_CMD;

/*************************************************
 *
 * 请求的PB CMD.各个业务的子类必须实现
 *
 *************************************************/
- (id)requestPBCMD;

/*************************************************
 *
 * 请求的PB SUB_CMD.各个业务的子类必须实现
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


/*************************************************
 *
 * 请求的PB Request Body内容，如果service定义需要传PB 
 * Request Body 那么必须实现此方法。
 *
 * return PBGeneratedMessageBuilder 具体业务serivce的PB Body Builder，否则 nil
 *
 *************************************************/
- (PBGeneratedMessage *)generatePBBody;

/*************************************************
 *
 * 如果service需要处理request对应的PB Response，需要实现此方法
 *
 * @param PBResHeader 服务器返回的PBHeader，其中包含了PBBodyContent
 *                    的二进制数据，需要自己解析成PB对象。
 *
 * return YES 处理成功，否则 NO
 *
 *************************************************/
- (BOOL)processForPBResHeader:(CProtocolServerResp*)PBResHeader;

@end
