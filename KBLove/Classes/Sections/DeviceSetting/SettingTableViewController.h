//
//  SettingTableViewController.h
//  KBLove
//
//  Created by block on 14/10/22.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBDevices;
@interface SettingTableViewController : UITableViewController

@property (nonatomic, strong) KBDevices *device;

- (IBAction)click_nav_back:(id)sender;

- (IBAction)click_nav_home:(id)sender;

- (IBAction)click_nav_submit:(id)sender;

- (IBAction)click_rebootDevice:(id)sender;

- (IBAction)click_reStartDevice:(id)sender;

- (IBAction)click_settingFence:(id)sender;

- (BOOL)isZero:(NSNumber *)number;

@end
