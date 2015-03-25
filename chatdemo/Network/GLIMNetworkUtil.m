//
//  GLIMNetworkUtil.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLIMNetworkUtil.h"

@implementation GLIMNetworkUtil

+ (NSData *)convertPB2Data:(id<PBMessage>)pbObject
{
    if (pbObject == nil || ![pbObject conformsToProtocol:@protocol(PBMessage)]) {
        return nil;
    }
    NSOutputStream *rawBodyOS = [[NSOutputStream alloc] initToMemory];
    [rawBodyOS open];
    [pbObject writeToOutputStream:rawBodyOS];
    NSData *pbBodyData = [rawBodyOS propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    return pbBodyData;
}

@end