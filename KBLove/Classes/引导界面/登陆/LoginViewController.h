//
//  LoginViewController.h
//  KBLove
//
//  Created by 吴铭博 on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//  登陆视图控制器

#import <UIKit/UIKit.h>
#import "BannerView.h"

@interface LoginViewController : UIViewController
//用户名tf
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
//密码tf
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
//首页滚动横幅
@property (weak, nonatomic) IBOutlet BannerView *bannerView;
//是否记住密码
@property (weak, nonatomic) IBOutlet UIButton *isPwdRemeberBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *weiBoLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *demoLoginBtn;
//忘记密码
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdBtn;

//登陆
- (IBAction)loginBtnClicked:(id)sender;
//注册
- (IBAction)registerBtnClicked:(id)sender;
//qq登陆
- (IBAction)qqLoginBtnClicked:(id)sender;
//微博登陆
- (IBAction)weiBoLoginClicked:(id)sender;
//试用登陆
- (IBAction)demoLoginClicked:(id)sender;
//记住密码点击
- (IBAction)isPwdRemeberBtnClicked:(id)sender;
//忘记密码
- (IBAction)forgetPwdBtnClicked:(id)sender;

@end
