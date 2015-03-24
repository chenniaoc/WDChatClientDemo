//
//  WDIMClient.m
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-17.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "WDIMClient.h"
#import "GCDAsyncSocket.h"
#import "WDHandshakeAPI.h"
#import "WDUserLoginApi.h"

@interface WDIMClient() <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;

@end

@implementation WDIMClient



+ (instancetype)instance
{
    static WDIMClient *c;
    if (!c) {
        @synchronized(self)
        {
            if (!c) {
                c = [WDIMClient new];
                c.asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:c delegateQueue:dispatch_get_main_queue()];
            }
        }
        
    }
    return c;
}

- (void)startService
{
    if ([_asyncSocket isConnected]) {
        NSLog(@"already running");
        return;
    }
    NSError *error;
    [_asyncSocket connectToHost:IM_SERVER_ADDR onPort:IM_SERVER_PORT withTimeout:-1 error:&error];

}

- (NSData *)mockData
{
    NSMutableData *data = [NSMutableData data];
    
    return data;
}

- (void)handshake
{
    WDHandshakeAPI *handshakeApi = [[WDHandshakeAPI alloc] init];
    NSData *handshakeData = [handshakeApi headerData];
    
    [_asyncSocket writeData:handshakeData withTimeout:-1 tag:0];
    
    [_asyncSocket readDataWithTimeout:-1 tag:0];
}

- (void)login;
{
    WDUserLoginApi *login = [[WDUserLoginApi alloc] init];
    
    NSData *data = [login request];
    
    [_asyncSocket writeData:data withTimeout:-1 tag:2];
    

}

#pragma mark GCDAsyncSocket

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"connected to server %@", host);
    
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"disconnected with error:%@", [err description]);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"didReadData%@", data);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
     NSLog(@"didWriteDataWithTag");
    [sock readDataWithTimeout:-1 tag:3];
}




@end
