//
//  AlterUserDataViewController.h
//  KBLove
//
//  Created by 吴铭博 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlterUserDataViewController : UIViewController
//昵称tf
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
//生日Btn
@property (weak, nonatomic) IBOutlet UIButton *birthdayBtn;
//性别Btn
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headPortrait;
//生日选择器
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayPicker;
//确定生日选择
@property (weak, nonatomic) IBOutlet UIButton *alertBirthdayBtn;

@property (weak, nonatomic) IBOutlet UIView *sexView;


//头像的点击事件
- (IBAction)headPortraitBtnClicked:(id)sender;
//返回点击事件
- (IBAction)backItemClicked:(id)sender;
//确认修改事件
- (IBAction)ConfirmAlterItemClicked:(id)sender;
//切换生日点击事件
- (IBAction)birthdayBtnClicked:(id)sender;
//修改性别点击事件
- (IBAction)sexBtnClicked:(id)sender;
//确定生日选择点击事件
- (IBAction)alertBirthdayBtnClicked:(id)sender;


@end
