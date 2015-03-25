//
//  GLIMServiceProtocol.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GLIMNetworkServiceProtocol <NSObject>

// req must to implement
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

@required
- (id)csHeaderCMD;

- (id)csHeaderSubCMD;

- (NSData *)packReqData;

- (id)unpackResData;

@end
