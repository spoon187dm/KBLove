//
//  MessageListCell.m
//  KBLove
//
//  Created by 1124 on 14/11/8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "MessageListCell.h"
#import <UIImageView+AFNetworking.h>
#import "MessageListView.h"
@implementation MessageListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)ViewForCellContent{
    
    MessageListView *infoView = [[[NSBundle mainBundle]loadNibNamed:@"MessageListView" owner:self options:nil] lastObject];
    infoView.frame = self.bounds;
    //    infoView.backgroundColor = SYSTEM_COLOR;
    infoView.UnReadView.layer.cornerRadius=7.5;
    infoView.UnReadView.layer.masksToBounds=YES;
    return infoView;
}

- (UIView *)menuViewForMenuCount:(NSInteger)count{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(320 - 80*count, 0, 80*count, 70);
    view.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < count; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        menuBtn.frame = CGRectMake(80*i, 0, 80, 70);
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:i] objectForKey:@"stateNormal"]]] forState:UIControlStateNormal];
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:i] objectForKey:@"stateHighLight"]]] forState:UIControlStateHighlighted];
        [view addSubview:menuBtn];
    }
    //  view.backgroundColor=[UIColor grayColor];
    return view;
}
- (void)configDateWithFriendModel:(KBFriendInfo *)kbFinfo
{
    MessageListView *view=(MessageListView *)self.cellView;
    // NSString *urlstr=[NSString stringWithFormat:@"user_%@",kbFinfo.id];
    [view.Circle_headerImageView setImageWithURL:[NSURL URLWithString:kUserImageFromName(kbFinfo.id)] placeholderImage:[UIImage imageNamed:@"页面列表1_22"]];
    view.Circle_NameLable.text=kbFinfo.name;
    KBMessageInfo *msginf=[[KBDBManager shareManager] getLastMsgWithEnvironment:KBTalkEnvironmentTypeFriend AndFromID:kbFinfo.id];
        if (msginf.MessageType==KBMessageTypeTalkText) {
      view.CircleLastMessageLable.text=msginf.text;
    }else
    {
        view.CircleLastMessageLable.text=@"地理位置信息";
    }
    view.CircleLastMessageLable.text=msginf.text;

    view.CircleMessageTimeLable.text=[NSString timeStampWithHM:[NSString stringWithFormat:@"%lld",msginf.time/1000]];
    NSInteger count=[[KBDBManager shareManager]getUnreadMessageCountWithTalkEnvironment:KBTalkEnvironmentTypeFriend TalkID:kbFinfo.id andMessageType:0];
    if (count>0) {
        view.UnReadView.hidden=NO;
        view.UnReadCountLable.text=[NSString stringWithFormat:@"%d",count];
    }else
    {
        view.UnReadView.hidden=YES;
    }
}
- (void)configDateWithCircleModel:(KBCircleInfo *)kbCircle_info
{
    MessageListView *view=(MessageListView *)self.cellView;
    // NSString *urlstr=[NSString stringWithFormat:@"user_%@",kbFinfo.id];
    [view.Circle_headerImageView setImage:[UIImage imageNamed:@"页面列表1_22"]];
    view.Circle_NameLable.text=kbCircle_info.name;
    KBMessageInfo *msginf=[[KBDBManager shareManager] getLastMsgWithEnvironment:KBTalkEnvironmentTypeCircle AndFromID:[kbCircle_info.id stringValue]];
    if (msginf.MessageType==KBMessageTypeTalkText) {
        view.CircleLastMessageLable.text=msginf.text;
    }else
    {
        view.CircleLastMessageLable.text=@"地理位置信息";
    }
    view.CircleMessageTimeLable.text=[NSString timeStampWithHM:[NSString stringWithFormat:@"%lld",msginf.time/1000]];
    NSInteger count=[[KBDBManager shareManager]getUnreadMessageCountWithTalkEnvironment:KBTalkEnvironmentTypeCircle TalkID:[kbCircle_info.id stringValue] andMessageType:0];
    if (count>0) {
        view.UnReadView.hidden=NO;
      view.UnReadCountLable.text=[NSString stringWithFormat:@"%d",count];
    }else
    {
        view.UnReadView.hidden=YES;
    }
    

}
- (void)configDateWithAddFrienMsg:(KBMessageInfo *)msg
{
       MessageListView *view=(MessageListView *)self.cellView;
    [view.Circle_headerImageView setImage:[UIImage imageNamed:@"页面列表1_22"]];
    view.Circle_NameLable.text=@"新朋友";
    view.CircleLastMessageLable.text=msg.text;
    view.CircleMessageTimeLable.text=[NSString timeStampWithHM:[NSString stringWithFormat:@"%lld",msg.time/1000]];
    NSInteger count=[[KBDBManager shareManager]getUnreadMessageCountWithTalkEnvironment:KBTalkEnvironmentTypeFriend TalkID:nil andMessageType:KBMessageTypeAddFriend];
    if (count>0) {
        view.UnReadView.hidden=NO;
        view.UnReadCountLable.text=[NSString stringWithFormat:@"%d",count];
    }else
    {
        view.UnReadView.hidden=YES;
    }

}
@end
