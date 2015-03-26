//
//  GLMInputStreamData.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLMInputStreamData : NSObject

+ (instancetype)streamWithData:(NSData *)data;

- (UInt32)readInt;

- (UInt16)readShort;

- (UInt8)readChar;

@end
