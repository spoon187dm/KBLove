//
//  FriendsListCell.h
//  KBLove
//
//  Created by 吴铭博 on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAContextMenuCell.h"


@interface FriendsListCell : DAContextMenuCell

@property (weak, nonatomic) IBOutlet UILabel *friendNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;

@end
