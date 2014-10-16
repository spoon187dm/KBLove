//
//  CircleFriendCell.m
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleFriendCell.h"

@implementation CircleFriendCell
{
    FriendCellSelectBtnClickBlock _block;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
       
    
    }
    return  self;
}
- (void)configUIWithModel:(KBFriendInfo *)finfo Path:(NSIndexPath *)path isSleect:(BOOL) iss andBlock:(FriendCellSelectBtnClickBlock)block
{
    _CircleFriendImageView.image=[UIImage imageNamed:@"loginQQ"];
    _CircleFriendImageView.layer.cornerRadius=20;
    _CircleFriendImageView.layer.masksToBounds=YES;
    _CircleFriendName.text=finfo.name;
    _path=path;
    _block=block;
    [_SelectBtn setBackgroundImage:[UIImage imageNamed:@"pwd"] forState:UIControlStateNormal];
    [_SelectBtn setBackgroundImage:[UIImage imageNamed:@"pwdRem"] forState:UIControlStateSelected];
    if (iss) {
        _SelectBtn.selected=YES;
    }else
    {
        _SelectBtn.selected=NO;
    }
}
- (IBAction)SelectBtnClick:(id)sender {
    UIButton *btn=sender;
    btn.selected=!btn.selected;
    _block(_path,btn.selected);
}
@end
