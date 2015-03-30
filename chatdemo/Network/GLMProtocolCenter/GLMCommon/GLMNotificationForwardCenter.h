//
//  GLMNotificationForwardCenter.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/28/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CProtocolServerResp;

/**
 *  IM Server推过来的notify，中转广播key的定义。
 *  需要处理的类自己注册对应的Notification。
 */
/// 新消息通知
extern NSString * const kGLMNotificationMessageNotify;
/// 消息应答通知
extern NSString * const kGLMNotificationMessageAckNotify;
/// 踢人通知
extern NSString * const kGLMNotificationKickoffNotify;


/**
 *  负责处理IM Server notify过来的消息，
 *  之后进行转发。
 */
@interface GLMNotificationForwardCenter : NSObject

+ (instancetype)defaultCenter;

-(BOOL)tryToProcessPushedNotifyWithPBHeader:(CProtocolServerResp *)PBHeaderRes;

@end
