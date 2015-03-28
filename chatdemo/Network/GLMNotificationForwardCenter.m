//
//  GLMNotificationForwardCenter.m
//  WDChatDemo
//
//  Created by YuchenZhang on 3/28/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMNotificationForwardCenter.h"
#import "GLMMessageSendNotifyService.h"

/// 新消息通知
NSString * const kGLMNotificationMessageNotify = @"GLM_MESSAGE_NOTIFY_NOTIFICATION";
/// 消息应答通知
NSString * const kGLMNotificationMessageAckNotify = @"GLMNotificationMessageAckNotify";
/// 踢人通知
NSString * const kGLMNotificationKickoffNotify = @"GLM_KICKOUT_NOTIFY_NOTIFICATION";


// 根据service生成Notify map的key
#define NOTIFY_MAP_KEY_FOR_SERVICE(service) [NSString stringWithFormat:@"%@,%@",\
[service requestPBCMD],\
[service requestPBSubCMD]]

// 根据PB Res Header生成Notify service的 map的key
#define NOTIFY_MAP_KEY_FOR_PBRES(res) [NSString stringWithFormat:@"%@,%@", \
res.cmd, \
res.subCmd]

@interface GLMNotificationForwardCenter ()

@property (nonatomic, strong) NSMutableDictionary *notifyServicesMap;

@end

/**
 *  负责转发IM Server推过来的Notify
 */
@implementation GLMNotificationForwardCenter

+ (instancetype)defaultCenter
{
    static GLMNotificationForwardCenter *_center = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _center = [GLMNotificationForwardCenter new];
    });
    
    return _center;
}

- (instancetype)init
{
    if (self) {
        [self _initialize];
    }
    return self;
}

- (void)_initialize
{
    self.notifyServicesMap = [NSMutableDictionary dictionary];
    
    GLMMessageSendNotifyService *sendNotify = [[GLMMessageSendNotifyService alloc] init];
    NSString *notifyKey = NOTIFY_MAP_KEY_FOR_SERVICE(sendNotify);
    _notifyServicesMap[notifyKey] = sendNotify;
}


-(BOOL)tryToProcessPushedNotifyWithPBHeader:(CProtocolServerResp *)PBHeaderRes
{
    NSString *notifyServiceKey = NOTIFY_MAP_KEY_FOR_PBRES(PBHeaderRes);
    
    GLMBaseNetworkService *notifyService = _notifyServicesMap[notifyServiceKey];
    
    if (notifyService) {
        [notifyService processForPBResHeader:PBHeaderRes];
        return YES;
        
    }
    
    return NO;
}


@end
