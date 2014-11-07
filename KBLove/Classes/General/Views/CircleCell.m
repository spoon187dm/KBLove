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
    _Circle_headerImageView.image=[UIImage imageNamed:@"userimage"];
    _Circle_NameLable.text=cModel.name;
    _CircleLastMessageLable.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    KBMessageInfo *msg=[[KBDBManager shareManager]getLastMsgWithEnvironment:KBTalkEnvironmentTypeCircle AndFromID:[cModel.id stringValue]];
    _CircleLastMessageLable.text=msg.text;
    //从数据库读取消息
    _CircleMessageTimeLable.text=[NSString timeStampWithHM:[NSString stringWithFormat:@"%lld",msg.time/1000]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
