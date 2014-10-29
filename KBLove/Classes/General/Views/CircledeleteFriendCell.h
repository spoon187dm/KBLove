//
//  CircledeleteFriendCell.h
//  KBLove
//
//  Created by 1124 on 14/10/23.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBFriendInfo.h"
@interface CircledeleteFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *friendHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *friendNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *SelectImageView;
- (void)configUIWithModel:(KBFriendInfo *)info AndisSelect:(BOOL)isselect;
@end
