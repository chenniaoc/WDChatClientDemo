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
#import "Msg.pb.h"
#import "GLMNetworkServiceProtocol.h"
#import "cs_header.h"
#import "GLMCS_Header.h"



typedef void(^GLMCompletionBlock)(id responeObject, NSError *error);

@interface GLMBaseNetworkService : NSObject <GLMNetworkServiceProtocol>


/// service请求成功后的callback
@property (nonatomic, copy) GLMCompletionBlock completionBlock;


/// PB Request Header的字段，目前不需要外部更改。
@property (nonatomic, strong) NSString *clientVersion;
/// PB Request Header的字段，目前不需要外部更改。
@property (nonatomic, strong) NSString *version;
/// PB Request Header的seqNo，启动请求时由ProtocolManager分配，不需要手动设置。
@property (nonatomic, assign) UInt32 seqNo;

/*************************************************
 *
 * 发起一个请求。
 *
 * @param block 接收到resp后的callback
 *
 *************************************************/
- (void)requestWithCompletionBlock:(GLMCompletionBlock)block;


/*************************************************
 *
 * 设置请求的CS_HEADER_CMD.
 * 默认HEADER_CMD_COMMON类型。
 * 如有特殊变更，各个业务的子类重写此方法。
 *          例如，Login的CMD是HEADER_CMD_LOGIN，
 *           所以，需要重写此方法，返回login的cmd。
 *
 *************************************************/
- (E_HEADER_CMD)CS_HEADER_CMD;

@end
