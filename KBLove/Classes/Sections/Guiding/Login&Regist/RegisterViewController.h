//
//  RegisterViewController.h
//  KBLove
//
//  Created by qianfeng on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BannerView;

@interface RegisterViewController : UIViewController

@property (nonatomic, assign) BOOL isModalFromLogin;

//电话注册
@property (weak, nonatomic) IBOutlet UIButton *phoneRegisterButton;
//邮箱注册
@property (weak, nonatomic) IBOutlet UIButton *mailRegisterButton;
//注册
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;
//登录
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
//用户名
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfiled;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
//重复密码
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextfiled;
/** 广告view*/
@property (weak, nonatomic) IBOutlet BannerView *bannerView;

//对应点击事件
- (IBAction)phoneRegisterButton:(id)sender;
- (IBAction)mailRegisterButton:(id)sender;
- (IBAction)RegisterButton:(id)sender;
- (IBAction)loginBtnClicked:(id)sender;
@end
