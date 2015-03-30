//
//  ViewController.m
//  WDChatDemo
//
//  Created by zhangyuchen on 15-3-17.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import "ViewController.h"
#import "WDIMClient.h"
#import "DemoMessagesViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[WDIMClient instance] startService];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)handshake:(id)sender
{
    [[WDIMClient instance] handshake];
}

-(IBAction)login:(id)sender
{
    [[WDIMClient instance] login];
}

-(IBAction)readData:(id)sender
{
    [[WDIMClient instance] readData];
}

-(IBAction)sendMessage:(id)sender
{
    [[WDIMClient instance] sendMessage];
}

- (IBAction)gotoChat:(id)sender
{
    
    __weak ViewController *weakSelf = self;
    
    
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"跟谁聊"
                                                                message:@"输入聊天对象im uid"
                                                         preferredStyle:UIAlertControllerStyleAlert];

    
    [ac addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"im uid";
    }];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction *action) {
                                                       UITextField *uidF = [ac.textFields objectAtIndex:0];
                                                       NSString *uidStr = uidF.text;
                                                       if (!uidStr || [uidStr isEqualToString:@""]) {
                                                           uidStr = @"7593173468933068660";
                                                       }
                                                       
                                                       DemoMessagesViewController *vc = [DemoMessagesViewController messagesViewController];
                                                       vc.to_UID = [uidStr longLongValue];
                                                       vc.delegateModal = weakSelf;
                                                       UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
                                                       [weakSelf presentViewController:nc animated:YES completion:nil];
        
    }];
    
    
    
    [ac addAction:action];
    
    [self presentViewController:ac animated:YES completion:^{
        
    }];
    
}

- (void)didDismissJSQDemoViewController:(DemoMessagesViewController *)vc
{
    [self dismissViewControllerAnimated:vc completion:^{
        
    }];
}
@end
