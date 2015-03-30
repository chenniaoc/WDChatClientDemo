//
//  GLMError.h
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-27.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GLM_PROTOCOL_ERROR_DOMAIN @"GLM_PROTOCOL_ERROR"

/**
 *  Normal
 */
#define GLM_RESPONSE_OK 200000


/**
 *  Client Error
 */
#define     ERROR_LOGIC_CLIENT_LACK_PARAM        400001
#define     ERROR_LOGIC_BAD_REQUEST              400002
#define     ERROR_LOGIC_BAD_TOKEN                400003
#define     ERROR_LOGIC_EXPIRED_TOKEN            400004
#define     ERROR_LOGIC_BAD_USS                  400005
#define     ERROR_LOGIC_MSG_TOO_LONG             400006
#define     ERROR_LOGIC_MSG_SEND_TO_SELF         400007
#define     ERROR_LOGIC_AS_COMMON_CHECK_FAIL     400008
#define     ERROR_LOGIC_QUERY_COUNT_TO_LONG      400009
#define     ERROR_LOGIC_USER_IS_VISITOR          400010
#define     ERROR_LOGIC_USER_MEMO_TOLONG         400011

/**
 *  验证码
 */
#define     ERROR_LOGIC_USER_CHECK_CODE          400012
#define     ERROR_LOGIC_USER_WRONG_CODE          400013

/**
 *  Server Error: Common
 */
#define     ERROR_LOGIC_EXCEPTION                510001
#define     ERROR_LOGIC_USER_A_IS_BLOCKED        510002
#define     ERROR_LOGIC_GENERATE_TOKEN_FAIL      510003
#define     ERROR_LOGIC_GENERATE_UID_FAIL        510004
#define     ERROR_LOGIC_SERVER_LACK_PARAM        510005
#define     ERROR_LOGIC_PARSE_JSON_FAIL          510006
#define     ERROR_LOGIC_BAD_PB_RESPONSE          510007
#define     ERROR_LOGIC_SERVER_BAD_RESP          510008
#define     ERROR_LOGIC_COMMON_CHECK_FAIL        510009
#define     ERROR_LOGIC_WRONG_SERVER_RESP_CODE   510010
/**
 *  Server Error: DAS
 */
#define     ERROR_LOGIC_PUT_DAS                  511001
#define     ERROR_LOGIC_DUPLICATE_SID            511002
#define     ERROR_LOGIC_DUPLICATE_UID            511003
#define     ERROR_LOGIC_PARSE_DAS_RESP           511004
#define     ERROR_LOGIC_QUERY_DAS_NO_RESULT      511005
#define     ERROR_LOGIC_DAS_PARSE_RESULT         511006
#define     ERROR_LOGIC_INSERT_DAS_RESP          511007

/**
 * /TIMEOUT
 */
#define     ERROR_LOGIC_DAS_TIMEOUT              512001
#define     ERROR_LOGIC_ROUTER_TIMEOUT           512002
#define     ERROR_LOGIC_SPAM_TIMEOUT             512003
#define     ERROR_LOGIC_TRANSIT_TIMEOUT          512003

@interface GLMError : NSObject

@end
