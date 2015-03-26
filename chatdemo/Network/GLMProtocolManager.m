//
//  GLMProtocolManager.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/26/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMProtocolManager.h"
#import "GLMNetworkUtil.h"
#import "WDIMClient.h"


#import "User.pb.h"


// 根据service生成map的key
#define MAP_KEY_FOR_SERVICE(service) [NSString stringWithFormat:@"%@,%@,%d",\
[service requestPBCMD],\
[service requestPBSubCMD], \
[service seqNo]]

// 根据PB Res Header生成map的key
#define MAP_KEY_FOR_PBRES(res) [NSString stringWithFormat:@"%@,%@,%d", \
res.cmd, \
res.subCmd, \
res.seq]


@interface GLMProtocolManager ()

@property (nonatomic, strong) NSMutableDictionary *servicesMap;

- (GLMCS_Header *)CS_HeaderFromService:(GLMBaseNetworkService *)service;

- (CProtocolClientReq *)PBReqHeaderFromService:(GLMBaseNetworkService *)service;

@end

@implementation GLMProtocolManager

+ (instancetype)sharedManager
{
    static GLMProtocolManager *_self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _self = [[GLMProtocolManager alloc] init];
        _self.servicesMap = [NSMutableDictionary dictionary];
    });
    
    return _self;
}

#pragma mark Private Method For Assemble PB Data
- (GLMCS_Header *)CS_HeaderFromService:(GLMBaseNetworkService *)service
{
    E_HEADER_CMD headerCMD = [service CS_HEADER_CMD];
    GLMCS_Header *header = [[GLMCS_Header alloc] initWithCMD:headerCMD];
    return header;
}

- (CProtocolClientReq *)PBReqHeaderFromService:(GLMBaseNetworkService *)service;
{
    CProtocolClientReq *rc = nil;
    
    CProtocolClientReqBuilder *crb = [CProtocolClientReq builder];
    
    if (![service respondsToSelector:@selector(requestPBCMD)]
        || ![service respondsToSelector:@selector(requestPBSubCMD)]) {
        return nil;
    }
    [crb setCmd:[service requestPBCMD]];
    [crb setSubCmd:[service requestPBSubCMD]];
    [crb setSeq:service.seqNo];
    [crb setVersion:service.version];
    [crb setSourceType:EConstSourceTypesClientTypeIphoneWeidian];
    
    PBGeneratedMessage *pbBody = nil;
    NSData* tempData = nil;
    
    if ([service respondsToSelector:@selector(generatePBBody)]) {
        pbBody = [service generatePBBody];
        tempData = [GLMNetworkUtil convertPB2Data:pbBody];
        [crb setProtocolContent:tempData];
    }
    
    rc = [crb build];
    
    return rc;
}


#pragma mark Public Methods For Caller
- (BOOL)registerForService:(GLMBaseNetworkService *)service
{
    @synchronized(self)
    {
        if (service.CS_HEADER_CMD == HEADER_CMD_HANDSHAKE) {
            return YES;
        }
        service.seqNo = [self generateSeqNo];
        NSString *key = MAP_KEY_FOR_SERVICE(service);
        // 已经存在了，草 咋办
        GLMBaseNetworkService *existedService = [_servicesMap objectForKey:key];
        if (existedService) {
            // 已经存在我就不玩了
            return NO;
        }
        [_servicesMap setObject:service forKey:key];
        return YES;
    }
}

- (void)startRequestWithService:(GLMBaseNetworkService *)service
{
    
    CProtocolClientReq *req = [self PBReqHeaderFromService:service];
    GLMCS_Header *csHeader = [self CS_HeaderFromService:service];
    
    NSData *pbData = [GLMNetworkUtil convertPB2Data:req];
    if (pbData) {
        csHeader.org_len = (UInt32)pbData.length;
        csHeader.enc_len = (UInt32)pbData.length;
    }
    
    NSMutableData *dataToBeSent = [NSMutableData data];
    
    NSData *headerData = [csHeader encodeData];
    
    [dataToBeSent appendData:headerData];
    [dataToBeSent appendData:pbData];
    
    
    [[WDIMClient instance].asyncSocket writeData:dataToBeSent
                                     withTimeout:-1
                                             tag:0];
}

- (UInt32)generateSeqNo
{
    static UInt32 seqId = 0;
    return seqId++;
}



#pragma mark RAW Response Data Analysis

- (BOOL)tryToParseRawData:(NSData *)rawData
{
    GLMCS_Header *parsedHeader = [self tryToParseCSHeaderFromData:rawData];
    if (!parsedHeader) {
        return NO;
    }
    
    if (parsedHeader.cmd == HEADER_CMD_HANDSHAKE) {
        return YES;
    }
    
    // valid header
    UInt32 originLength = parsedHeader.org_len;
    UInt8 pbDataBodyBuffer[originLength];
    [rawData getBytes:&pbDataBodyBuffer range:(NSRange){CS_HEADER_LENGTH, originLength}];
    
#ifdef DEBUG
    for (int i = 0; i< originLength; i++) {
        printf("%02x", pbDataBodyBuffer[i]);
        if ((i + 1) % 4 == 0) {
            printf(" ");
        }
    }
#endif
    if (parsedHeader.cmd == HEADER_CMD_HANDSHAKE) {
        return YES;
    }
    
    NSData *pbHeader = [NSData dataWithBytes:&pbDataBodyBuffer length:originLength];
    CProtocolServerResp *res = [CProtocolServerResp parseFromData:pbHeader];
    
    NSString *retriveKey = MAP_KEY_FOR_PBRES(res);
    
    id<GLMNetworkServiceProtocol> service = [_servicesMap objectForKey:retriveKey];
    
    if (service && [service respondsToSelector:@selector(processForPBResHeader:)]) {
        [service processForPBResHeader:res];
        [_servicesMap removeObjectForKey:retriveKey];
    }
    
    return YES;
}

- (GLMCS_Header *)tryToParseCSHeaderFromData:(NSData *)data
{
    GLMCS_Header *parsedHeader = [GLMCS_Header headerFromData:data];
    return parsedHeader;
}


- (CProtocolServerResp *)tryToParseRespFromData:(NSData *)data
{
    return nil;
}

#pragma mark GCDAsyncSocketDelegate

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
    
    [self tryToParseRawData:data];
    
    [sock readDataWithTimeout:-1 tag:0];
    
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"didWriteDataWithTag");
    [sock readDataWithTimeout:-1 tag:0];
}


@end
