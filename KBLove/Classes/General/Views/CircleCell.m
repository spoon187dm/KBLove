//
//  CircleCell.m
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleCell.h"

@implementation CircleCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)ConfigWithModel:(KBCircleInfo *)cModel
{
    _Circle_headerImageView.image=[UIImage imageNamed:@"loginQQ"];
    _Circle_NameLable.text=cModel.name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
