//
//  FriendListCell.m
//  KBLove
//
//  Created by 1124 on 14/11/3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "FriendListCell.h"
#import <UIImageView+AFNetworking.h>
@implementation FriendListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    //    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    return self;
}
- (UIView *)ViewForCellContent{
    
    FriendListView *infoView = [[[NSBundle mainBundle]loadNibNamed:@"FriendListView" owner:self options:nil] lastObject];
    infoView.frame = self.bounds;
    //    infoView.backgroundColor = SYSTEM_COLOR;
    
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

- (void)configDateWithModel:(KBFriendInfo *)kbFinfo
{
    FriendListView *view=(FriendListView *)self.cellView;
   // NSString *urlstr=[NSString stringWithFormat:@"user_%@",kbFinfo.id];
    [view.FriendImageView setImageWithURL:[NSURL URLWithString:kUserImageFromName(kbFinfo.id)] placeholderImage:[UIImage imageNamed:@"页面列表1_22"]];
    view.FriendNickName.text=kbFinfo.name;
    //设置分享界面
    //view.FriendShareLable.text=kbFinfo.
    
}
@end
