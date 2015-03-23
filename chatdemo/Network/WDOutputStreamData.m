//
//  WDOutputStream.m
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-17.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "WDOutputStreamData.h"

@implementation WDOutputStreamData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _data = [NSMutableData data];
        _length = 0;
    }
    return self;
}


- (void)writeInt:(int)data
{
    char d1 = 0;
    for (int i = 0; i<4; i++) {
        d1 = (data >> (24-i*8)) & 0xff;
        [_data appendBytes:&d1 length:1];
        _length += 1;
    }
}

- (void)writeShort:(short)data
{
    int8_t d[2];
    d[0] = (data >> 8) & 0xff;
    d[1] = data & 0xff;
    [_data appendBytes:&d length:2];
    _length += 2;
}

- (void)writeChar:(char)data
{
    [_data appendBytes:&data length:1];
    _length++;
}

@end
