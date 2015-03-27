//
//  AppDelegate.h
//  MacUI
//
//  Created by zhangyuchen on 15-3-27.
//  Copyright (c) 2015年 zhangyuchen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

//@property (nonatomic, assign) IBOutlet NSComboBox *userIDList;

@property (nonatomic, assign) IBOutlet NSComboBox *userIDField;

//@property (nonatomic, assign) IBOutlet NSComboBox *wdussList;


@property (nonatomic, assign) IBOutlet NSComboBox *wdussDField;

@property (nonatomic, assign) IBOutlet NSComboBox *msgToUIDField;

@property (nonatomic, assign) IBOutlet NSTextField *msgContentField;

- (IBAction)handShake:(id)sender;

- (IBAction)loginClicked:(id)sender;

- (IBAction)sendMessageClicked:(id)sender;

@end

