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
    
    // litile-endian
//    for (int i = 0; i<4; i++) {
//        d1 = (data >> (i*8)) & 0xff;
//        [_data appendBytes:&d1 length:1];
//        _length += 1;
//    }
    
    
    //big-endian
    for (int i = 0; i<4; i++) {
        d1 = (data >> (24-i*8)) & 0xff;
        [_data appendBytes:&d1 length:1];
        _length += 1;
    }
//    Byte resultByte[4] ={0};
//    int2bytes(data, resultByte);
//    [_data appendBytes:resultByte length:4];
}

- (void)writeIntAsLittleEndian:(int)data
{
    char d1 = 0;
    
    // litile-endian
        for (int i = 0; i<4; i++) {
            d1 = (data >> (i*8)) & 0xff;
            [_data appendBytes:&d1 length:1];
            _length += 1;
        }
    
    
//    //big-endian
//    for (int i = 0; i<4; i++) {
//        d1 = (data >> (24-i*8)) & 0xff;
//        [_data appendBytes:&d1 length:1];
//        _length += 1;
//    }
    //    Byte resultByte[4] ={0};
    //    int2bytes(data, resultByte);
    //    [_data appendBytes:resultByte length:4];
}

unsigned char* int2bytes(int a,unsigned char* aResult)
{
    
    unsigned char * result = aResult;
    result[3] = (unsigned char)(a &0xff);
    result[2] = (unsigned char)(a >> 8 &0xff);
    result[1] = (unsigned char)(a >> 16 &0xff);
    result[0] = (unsigned char)(a >> 24 &0xff);
    return result;
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
