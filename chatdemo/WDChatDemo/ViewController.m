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
    DemoMessagesViewController *vc = [DemoMessagesViewController messagesViewController];
    vc.delegateModal = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)didDismissJSQDemoViewController:(DemoMessagesViewController *)vc
{
    [self dismissViewControllerAnimated:vc completion:^{
        
    }];
}
@end
