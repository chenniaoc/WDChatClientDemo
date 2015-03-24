//
//  GLIMBaseNetworkService.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLIMNetworkServiceProtocol.h"
#import "cs_header.h"

typedef void(^completionBlock)(id responeObject, NSError *error);

@interface GLIMBaseNetworkService : NSObject <GLIMNetworkServiceProtocol>


- (NSMutableData *)csHeaderData;

- (void)requestWithObject:(id<GLIMNetworkServiceProtocol>)object
          completionBlock:(completionBlock)block;



@end
