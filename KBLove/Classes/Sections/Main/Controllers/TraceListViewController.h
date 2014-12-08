//
//  TraceListViewController.h
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TableMenuViewController.h"
@class KBDevices;

@interface TraceListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) KBDevices *device;
@property(nonatomic,assign) int isSelected;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *click_back;
- (IBAction)click_home:(id)sender;
- (IBAction)click_search:(id)sender;

@end
