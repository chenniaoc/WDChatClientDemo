//
//  GLMInputStreamData.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMInputStreamData.h"

@interface GLMInputStreamData ()

@property (nonatomic, assign) NSUInteger readOffset;

@property (nonatomic, strong) NSData *data;

@end

@implementation GLMInputStreamData


+ (instancetype)streamWithData:(NSData *)data
{
    GLMInputStreamData *sd = [[GLMInputStreamData alloc] init];
    sd.data = data;
    return sd;
}


- (UInt32)readInt
{
    UInt32 result = 0;
    if (_data.length <= _readOffset + 4) {
        return 0;
    }
    [_data getBytes:&result range:(NSRange){_readOffset, 4}];
    _readOffset += 4;
    return htonl(result);
}

- (UInt16)readShort
{
    UInt16 result = 0;
    if (_data.length <= _readOffset + 2) {
        return 0;
    }
    [_data getBytes:&result range:(NSRange){_readOffset, 2}];
    _readOffset += 2;
    return htons(result);
}

- (UInt8)readChar
{
    if (_data.length <= _readOffset + 1) {
        return 0;
    }
    UInt8 result = 0;
    [_data getBytes:&result range:(NSRange){_readOffset, 1}];
    _readOffset ++;
    return result;
}

@end
