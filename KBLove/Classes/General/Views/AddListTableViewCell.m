//
//  AddListTableViewCell.m
//  KBLove
//
//  Created by 1124 on 14/11/12.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AddListTableViewCell.h"
#import <UIImageView+AFNetworking.h>
@implementation AddListTableViewCell
{
    AgreeBlock _agreeBlock;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)configUIWithMesageModel:(KBMessageInfo *)msgModel AndFriendModel:(KBFriendInfo *)friendModel WithBlock:(AgreeBlock)agBlock
{
    if (_agreeBlock!=agBlock) {
        _agreeBlock=nil;
        _agreeBlock=agBlock;
    }
    _FriendNameLable.text=friendModel.name;
    _frienDesLable.text=msgModel.text;
    [_AddFriendImageView setImageWithURL:[NSURL URLWithString:kUserImageFromName(friendModel.id)] placeholderImage:kImage_person];
    _FriendStatusLable.text=@"";
    _AgreeBtn.backgroundColor=[UIColor whiteColor];
    _AgreeBtn.layer.cornerRadius=15;
    _AgreeBtn.layer.masksToBounds=YES;
    switch (msgModel.status) {
        case KBMessageStatusAgree:{
            //已同意
            _FriendStatusLable.text=@"已同意";
            _AgreeBtn.hidden=YES;
        }break;
        case KBMessageStatusReject:{
            _FriendStatusLable.text=@"已拒绝";
            _AgreeBtn.hidden=YES;
            
        }break;
        case KBMessageStatusUnRead:{
            _FriendStatusLable.text=@"";
            _AgreeBtn.hidden=NO;
        }break;
        case KBMessageStatusHaveRead:{
            _FriendStatusLable.text=@"";
            _AgreeBtn.hidden=NO;
        }break;


            
        default:
            break;
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)AgreeClick:(id)sender {
    
    _agreeBlock(_AgreeBtn);
}
@end
