//
//  TraceListViewController.h
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TableMenuViewController.h"
@class KBDevices;
@interface TraceListViewController : TableMenuViewController

@property (nonatomic, strong) KBDevices *device;

- (IBAction)click_back:(UIButton *)sender;
- (IBAction)click_home:(id)sender;

@end
