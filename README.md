
##WDChat Demo Introduction

###Contents
 1. Demo说明
 2. Demo演示
 3. Source目录结构
 

####Demo说明


####Demo演示

 * 模拟登录请求(主动发起的请求)

	1. 创建一个service继承自GLMBaseNetworkService
     	
	
```objc
		@interface GLMUserLoginService : GLMBaseNetworkService<GLMNetworkServiceProtocol>	 
			//输入参数 （userid）	 
			@property (nonatomic, strong) NSString *sid;  
			//输入参数 （wduss）	 
			@property (nonatomic, strong) NSString *uss;  
		@end	
		
```

	2. 创建一个service继承自GLMBaseNetworkService
```objc
@implementation GLMUserLoginService

/**
 * 需要实现requestPBCMD，返回PB的CMD
 * 返回PB的CMD
 *
 *  @return @"user"
 */
- (id)requestPBCMD
{
    return @"user";
}

/**
 * 需要实现requestPBCMD，
 * 返回对应PB的SUB_CMD
 *
 *  @return @"login"
 */
- (id)requestPBSubCMD
{
    return @"login";
}

/**
 *  需要实现CS_HEADER_CMD，返回对应CS_HEADER的CMD
 *
 *  @return HEADER_CMD_LOGIN
 */
- (E_HEADER_CMD)CS_HEADER_CMD
{
    return HEADER_CMD_LOGIN;
}

/**
 * 业务自己需要负责生成业务对应的PBBody Instance
 *
 *  @return CUserLoginReqBuilder Instance
 */
- (PBGeneratedMessage *)generatePBBody
{
    // PB user login
    CUserLoginReqBuilder *lb = [CUserLoginReq builder];
    [lb setSid:self.sid];
    [lb setUss:self.uss];
    [lb setClientVersion:[self clientVersion]];
    
    return [lb build];
}

/**
 * 如果需要处理服务器返回的response，需要自己从PBResHeader，解析出login协议对应的
 * PBResp Body，login对应的是CUserLoginResp。
 * 幷根绝自己的业务判断是否要回掉completionBlock
 *
 *  @param PBResHeader 此次请求服务器返回的PB Header Data
 *
 *  @return YES 处理成功，如果不处理返回No
 */
- (BOOL)processForPBResHeader:(CProtocolServerResp*)PBResHeader
{
    NSData *pbBodyData = PBResHeader.protocolContent;
    CUserLoginResp *loginResp = [CUserLoginResp parseFromData:pbBodyData];
    if (loginResp) {
        GLMProtocolContext *mpc = GLMGetProtocolContext();
        mpc.userID = loginResp.uid;
        self.completionBlock(loginResp, nil);
        return YES;
    }
    return NO;
}

@end	
		
```

	
####source tree 

 
    [1] 代表一级根目录，[2] 代表二级目录.. 依次类推
    
 
  
Directory Name          | Comment							
----------------------- | -------------
[1].GLMProtocolCenter   | Root目录
--> [2].GLMCommon    | 公共操作实现，协议Header，二进制读写，etc
------> [3].Common   | 通用协议请求的具体Service实现，心跳,握手,etc	
------> [3].Message  | IM消息相关协议请求的具体Service实现，发送消息,接收消息的notify，发送消息ack,etc
------> [3].User     | User信息相关协议请求的具体Service实现，用户登录,踢下线notify,etc
  


```
├── GLMProtocolCenter
│   ├── GLMCommon
│   │   ├── GLMCS_Header.h ##cs_header头协议的objc封装，方便Serialization
│   │   ├── GLMCS_Header.m
│   │   ├── GLMError.h	##IM_Server定义的错误码
│   │   ├── GLMError.m
│   │   ├── GLMInputStreamData.h ## 方便操作NSData read二进制
│   │   ├── GLMInputStreamData.m
│   │   ├── GLMNetworkUtil.h ## 常用方法
│   │   ├── GLMNetworkUtil.m
│   │   ├── GLMNotificationForwardCenter.h ## im_server推送的notify转发
│   │   ├── GLMNotificationForwardCenter.m
│   │   ├── GLMOutputStreamData.h ## 方便操作NSData write二进制
│   │   ├── GLMOutputStreamData.m
│   │   ├── GLMProtocolContext.h ## 与IMserver通讯时，全局上下文
│   │   ├── GLMProtocolContext.m
│   │   └── cs_header.h ##im_server提供的原始cs_header定义
│   ├── GLMServices
│   │   ├── Common ##公共模块service
│   │   │   ├── GLMHandShakeService.h ##握手协议service请求
│   │   │   ├── GLMHandShakeService.m
│   │   │   ├── GLMHeatBeatService.h ##心跳协议service请求
│   │   │   └── GLMHeatBeatService.m
│   │   ├── Message ##消息模块Service
│   │   │   ├── GLMMessageAckNotifyService.h ##消息ack notify的service请求
│   │   │   ├── GLMMessageAckNotifyService.m
│   │   │   ├── GLMMessageSendAckService.h ##消息ack协议service请求
│   │   │   ├── GLMMessageSendAckService.m
│   │   │   ├── GLMMessageSendMsgService.h ##发送消息的service请求
│   │   │   ├── GLMMessageSendMsgService.m
│   │   │   ├── GLMMessageSendNotifyService.h ##对方推过来消息notify请求
│   │   │   └── GLMMessageSendNotifyService.m
│   │   ├── User ##用户模块Service
│   │   │   ├── GLMUserLoginService.h ##用户登录协议service
│   │   │   └── GLMUserLoginService.m
│   │   ├── GLMBaseNetworkService.h ##所有的业务service需要继承的superclass
│   │   ├── GLMBaseNetworkService.m
│   │   ├── GLMNetworkServiceProtocol.h ##service定义的公共接口
│   ├── GLMProtocolCenter.h ## 第三方导入ProtocolCenter的头文件。
│   ├── GLMProtocolManager.h ## 与GLSocket层通讯的核心类，负责raw_data的处理
│   ├── GLMProtocolManager.m
├── WDIMClient.h ##Demo 演示用
├── WDIMClient.m 
```
