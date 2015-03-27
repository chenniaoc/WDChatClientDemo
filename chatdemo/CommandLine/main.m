//
//  main.m
//  CommandLine
//
//  Created by zhangyuchen on 15-3-27.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDIMClient.h"
#import "GLMProtocolCenter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        while (TRUE) {
            WDIMClient *client = [WDIMClient instance];
            
            [client startService];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [client handshake];
            });
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [client login];
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [client sendMessage];
            });
//        }
    }
    

    
    
    pause();
    return 0;
}
