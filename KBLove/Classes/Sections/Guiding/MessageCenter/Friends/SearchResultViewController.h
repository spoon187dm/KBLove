//
//  SearchResultViewController.h
//  KBLove
//
//  Created by 吴铭博 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController
//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
//用户名Label
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

//返回item点击事件
- (IBAction)leftItemClicked:(id)sender;
//添加好友点击事件
- (IBAction)addFriendBtnClicked:(id)sender;

@end
