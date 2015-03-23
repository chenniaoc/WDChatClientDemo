//
//  WDOutputStream.h
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-17.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDOutputStreamData : NSObject

@property (nonatomic, strong) NSMutableData *data;

@property (nonatomic, assign) NSInteger length;

- (void)writeInt:(int)data;

- (void)writeShort:(short)data;

- (void)writeChar:(char)data;


@end
