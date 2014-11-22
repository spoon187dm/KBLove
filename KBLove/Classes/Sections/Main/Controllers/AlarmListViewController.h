//
//  AlarmListViewController.h
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TableMenuViewController.h"
@class KBDevices;
@interface AlarmListViewController : TableMenuViewController
@property (nonatomic, strong) KBDevices *device;
- (IBAction)click_back:(UIButton *)sender ;
- (IBAction)click_menu:(id)sender;
- (IBAction)click_home:(UIButton *)sender;

@end
