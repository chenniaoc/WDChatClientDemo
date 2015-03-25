//
//  GLIMNetworkConstant.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ProtocolBuffers/ProtocolBuffers.h>


@interface GLIMNetworkUtil : NSObject

+ (NSData *)convertPB2Data:(id<PBMessage>)pbObject;

@end