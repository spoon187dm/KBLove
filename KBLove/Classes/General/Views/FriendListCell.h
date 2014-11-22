//
//  FriendListCell.h
//  KBLove
//
//  Created by 1124 on 14/11/3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableMenuCell.h"
#import "FriendListView.h"
#import "KBFriendInfo.h"
@interface FriendListCell : TableMenuCell
- (void)configDateWithModel:(KBFriendInfo *)kbFinfo;
@end
