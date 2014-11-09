//
//  MessageListCell.h
//  KBLove
//
//  Created by 1124 on 14/11/8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TableMenuCell.h"
#import "KBFriendInfo.h"
#import "KBCircleInfo.h"
@interface MessageListCell : TableMenuCell
- (void)configDateWithFriendModel:(KBFriendInfo *)kbFinfo;
- (void)configDateWithCircleModel:(KBCircleInfo *)kbCircle_info;
- (void)configDateWithAddFrienMsg:(KBMessageInfo *)msg;
@end
