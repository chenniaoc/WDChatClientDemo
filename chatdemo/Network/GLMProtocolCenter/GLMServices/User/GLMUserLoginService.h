//
//  GLIMLoginReq.h
//  WDChatDemo
//
//  Created by YuchenZhang on 3/25/15.
//  Copyright (c) 2015 zhangyuchen. All rights reserved.
//

#import "GLMBaseNetworkService.h"

@interface GLMUserLoginService : GLMBaseNetworkService <GLMNetworkServiceProtocol>

@property (nonatomic, strong) NSString *sid;

@property (nonatomic, strong) NSString *uss;

@end
