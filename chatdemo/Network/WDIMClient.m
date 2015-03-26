//
//  WDIMClient.m
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-17.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "WDIMClient.h"
//#import "WDHandshakeAPI.h"
//#import "WDUserLoginApi.h"
#import "GLMCS_Header.h"
#import "GLMHandShakeService.h"
#import "GLMLoginService.h"
#import "Im_base.pb.h"
#import "User.pb.h"

#import "GLMProtocolManager.h"

@interface WDIMClient() <GCDAsyncSocketDelegate>



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
                
                // 这是个struct
                TCP_HEADER header;
                char *bytes = (char *)&header;
                char *tempOrin = bytes;
                
                char *byteCopy = malloc(sizeof(header));
                char *tempCopy = byteCopy;
                
                int length = sizeof(header);
                while (length > 0) {
                    *tempCopy = *tempOrin;
                    tempCopy++;
                    tempOrin++;
                    
                    length--;
                }
                
                TCP_HEADER *copyHeader = (TCP_HEADER *)byteCopy;
                
                c.asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:[GLMProtocolManager sharedManager] delegateQueue:dispatch_get_global_queue(0, 0)];
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
//    [_asyncSocket readDataWithTimeout:-1 tag:0];

}

- (NSData *)mockData
{
    NSMutableData *data = [NSMutableData data];
    
    return data;
}

- (void)handshake
{
    if(![_asyncSocket isConnected]) return;
    
    
    
    GLMHandShakeService *req = [[GLMHandShakeService alloc] init];
    
    [req requestWithCompletionBlock:^(id responeObject, NSError *error) {
        
    }];
    
//    return;
//    WDHandshakeAPI *handshakeApi = [[WDHandshakeAPI alloc] init];
//    NSData *handshakeData = [handshakeApi headerData];
//    NSLog(@"handshake req data:%@", handshakeData);
//    [_asyncSocket writeData:handshakeData withTimeout:-1 tag:0];
    
//    [_asyncSocket readDataWithTimeout:-1 tag:0];
}

- (void)login;
{
    
    GLMLoginService *req = [[GLMLoginService alloc] init];
    req.sid = @"13042";
    req.uss = @"Wm85FefWB0mcZwbSvfZ8B0zgDSQjVl2kU2Fm3UWIJNpI3D";
    
    [req requestWithCompletionBlock:^(id responeObject, NSError *error) {
        
    }];
}


//#pragma mark GCDAsyncSocket
//
//- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
//{
//    NSLog(@"connected to server %@", host);
//}
//
//- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
//{
//    NSLog(@"disconnected with error:%@", [err description]);
//}
//
//- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    NSLog(@"didReadData%@", data);
//    
////    [sock readDataWithTimeout:-1 tag:0];
//    GLMCS_Header *parsedHeader = [GLMCS_Header headerFromData:data];
//    
//    if (parsedHeader) {
//        // valid header
//        UInt32 originLength = parsedHeader.org_len;
//        UInt8 buffer[originLength];
//        [data getBytes:&buffer range:(NSRange){CS_HEADER_LENGTH, originLength}];
//        for (int i = 0; i< originLength; i++) {
//            printf("%02x", buffer[i]);
//            if ((i + 1) % 4 == 0) {
//                printf(" ");
//            }
//        }
//        if (parsedHeader.cmd == HEADER_CMD_HANDSHAKE) {
//            return;
//        }
//        
//        NSData *pbHeader = [NSData dataWithBytes:&buffer length:originLength];
//        CProtocolServerResp *res = [CProtocolServerResp parseFromData:pbHeader];
//        if ([res.cmd isEqualToString:@"user"]) {
//            if ([res.subCmd isEqualToString:@"login"]) {
//                
//                NSData *pbBodyData = res.protocolContent;
//                CUserLoginResp *loginResp = [CUserLoginResp parseFromData:pbBodyData];
//                
//                
//            }
//        }
//        
//        
//        
//    }
//    
//    [sock readDataWithTimeout:-1 tag:0];
//    
//}
//
//
//- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//     NSLog(@"didWriteDataWithTag");
//    [sock readDataWithTimeout:-1 tag:0];
//}




@end
