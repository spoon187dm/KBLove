//
//  CircledeleteFriendCell.m
//  KBLove
//
//  Created by 1124 on 14/10/23.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircledeleteFriendCell.h"

@implementation CircledeleteFriendCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configUIWithModel:(KBFriendInfo *)info AndisSelect:(BOOL)isselect
{
    _friendHeaderImageView.image=[UIImage imageNamed:@"圈子创建1_21"];
    _friendNameLable.text=info.name;
    if (isselect) {
        _SelectImageView.hidden=NO;
    }else
    {
        _SelectImageView.hidden=YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
