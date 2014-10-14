//
//  FriendsListTableViewController.h
//  KBLove
//
//  Created by 吴铭博 on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAContextMenuTableViewController.h"

@interface FriendsListTableViewController : DAContextMenuTableViewController

//返回item
- (IBAction)leftItemClicked:(id)sender;
//添加好友item
- (IBAction)addItemClicked:(id)sender;

@end
