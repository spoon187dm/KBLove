//
//  AddFriendViewController.h
//  KBLove
//
//  Created by 吴铭博 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendViewController : UIViewController
//账户输入tf
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

//查找btn点击事件
- (IBAction)searchBtnClicked:(id)sender;
//返回item 点击事件
- (IBAction)leftItemClicked:(id)sender;
//从通讯录添加好友btn点击事件
- (IBAction)addFromAdressBtnClicked:(id)sender;
//从qq添加好友btn点击事件
- (IBAction)addFromQQBtnClicked:(id)sender;
//从微博添加好友btn点击事件
- (IBAction)addFromWeiBoBtnClicked:(id)sender;

@end
