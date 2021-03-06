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
#import "GLMMessageSendNotifyService.h"
#import "GLMHeatBeatService.h"


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


//// 根据service生成Notify map的key
//#define NOTIFY_MAP_KEY_FOR_SERVICE(service) [NSString stringWithFormat:@"%@,%@",\
//[service requestPBCMD],\
//[service requestPBSubCMD]]
//
//// 根据PB Res Header生成Notify service的 map的key
//#define NOTIFY_MAP_KEY_FOR_PBRES(res) [NSString stringWithFormat:@"%@,%@", \
//res.cmd, \
//res.subCmd]


@interface GLMProtocolManager ()

/**
 *  临时存放 注册的service
 */
@property (nonatomic, strong) NSMutableDictionary *servicesMap;

//@property (nonatomic, strong) NSMutableDictionary *notifyServicesMap;


/**
 *  解析service 生成对应Header Instance
 *
 *  @param service 特定的业务service
 *
 *  @return GLMCS_Header 特定业务的CS Header
 */
- (GLMCS_Header *)CS_HeaderFromService:(GLMBaseNetworkService *)service;


/**
 *  解析service 生成对应PB Request Header Instance
 *
 *  @param service 特定的业务service
 *
 *  @return CProtocolClientReq
 */
- (CProtocolClientReq *)PBReqHeaderFromService:(GLMBaseNetworkService *)service;

@end

@implementation GLMProtocolManager

+ (instancetype)sharedManager
{
    static GLMProtocolManager *_self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _self = [[GLMProtocolManager alloc] init];
    });
    
    return _self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _initialze];
    }
    return self;
}


/**
 *  私有初始化方法
 *  1.初始化 临时存放注册的service map
 */
- (void)_initialze
{
    self.servicesMap = [NSMutableDictionary dictionary];
//    self.notifyServicesMap = [NSMutableDictionary dictionary];
//    GLMMessageSendNotifyService *sendNotify = [[GLMMessageSendNotifyService alloc] init];
//    
//    NSString *notifyKey = NOTIFY_MAP_KEY_FOR_SERVICE(sendNotify);
//    _notifyServicesMap[notifyKey] = sendNotify;
    
    
    
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
    
    GLMProtocolContext *mpc = GLMGetProtocolContext();
    
    [crb setCmd:[service requestPBCMD]];
    [crb setSubCmd:[service requestPBSubCMD]];
    [crb setSeq:service.seqNo];
    [crb setVersion:service.version];
    if (mpc.userID != -1) {
        [crb setUid:mpc.userID];
    }
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
        if (service.CS_HEADER_CMD == HEADER_CMD_HANDSHAKE || service.CS_HEADER_CMD == HEADER_CMD_KEEPALIVE) {
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


- (void)startHeartbreakSchedule
{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        GLMHeatBeatService * headerBeat = [[GLMHeatBeatService alloc] init];
        NSLog(@"headerBeat finished");
        [headerBeat requestWithCompletionBlock:^(id responeObject, NSError *error) {
        }];
        
        [self startHeartbreakSchedule];
    });
    
}


#pragma mark RAW Response Data Analysis

- (BOOL)tryToParseRawData:(NSData *)rawData
{
    GLMCS_Header *parsedHeader = [self tryToParseCSHeaderFromData:rawData];
    if (!parsedHeader) {
        return NO;
    }
    
    if (parsedHeader.cmd == HEADER_CMD_HANDSHAKE || parsedHeader.cmd == HEADER_CMD_KEEPALIVE) {
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
    if (parsedHeader.cmd == HEADER_CMD_HANDSHAKE || parsedHeader.cmd == HEADER_CMD_KEEPALIVE) {
        return YES;
    }
    
    NSData *pbHeader = [NSData dataWithBytes:&pbDataBodyBuffer length:originLength];
    
    NSError *error = nil;
    CProtocolServerResp *res = [self tryToParseRespFromData:pbHeader
                                                      error:&error];
    
    NSString *retriveKey = MAP_KEY_FOR_PBRES(res);
    
    GLMBaseNetworkService *service = [_servicesMap objectForKey:retriveKey];
    if (service == nil) {
        // 说明没注册过，可能是个notify
        [self tryToProcessPushedNotifyWithPBHeader:res];
    }
    else if (error) {
        service.completionBlock(nil, error);
    }
    else if (service && [service respondsToSelector:@selector(processForPBResHeader:)]) {
        [service processForPBResHeader:res];
    }
    
    [_servicesMap removeObjectForKey:retriveKey];
    
    return YES;
}

- (GLMCS_Header *)tryToParseCSHeaderFromData:(NSData *)data
{
    GLMCS_Header *parsedHeader = [GLMCS_Header headerFromData:data];
    return parsedHeader;
}


- (CProtocolServerResp *)tryToParseRespFromData:(NSData *)data
                                          error:(NSError **)error
{
    CProtocolServerResp *pbResHeader = nil;
    pbResHeader = [CProtocolServerResp parseFromData:data];
    
    if (pbResHeader.code != GLM_RESPONSE_OK) {
        *error = [NSError errorWithDomain:GLM_PROTOCOL_ERROR_DOMAIN
                                     code:pbResHeader.code
                                 userInfo:nil];
    }
    
    return pbResHeader;
}

- (BOOL)tryToProcessPushedNotifyWithPBHeader:(CProtocolServerResp *)PBHeaderRes
{
    
//    NSString *notifyServiceKey = NOTIFY_MAP_KEY_FOR_PBRES(PBHeaderRes);
//    
//    GLMBaseNetworkService *notifyService = _notifyServicesMap[notifyServiceKey];
//    
//    if (notifyService) {
//        [notifyService processForPBResHeader:PBHeaderRes];
//        
//    }
    
    return [[GLMNotificationForwardCenter defaultCenter] tryToProcessPushedNotifyWithPBHeader:PBHeaderRes];
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
