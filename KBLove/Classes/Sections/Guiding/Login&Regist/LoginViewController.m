//
//  LoginViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginRequest.h"
#import <SVProgressHUD.h>
#import "RegisterViewController.h"

@interface LoginViewController ()
{
    BOOL _isRemBtnPressed;//记录 记录密码按键是否被点击
    KBUserInfo *_userInfo;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //为banner赋值
    NSArray *imageArray = @[@"bj.png",@"bj.png",@"bj.png",@"bj.png",@"bj.png"];
    [_bannerView setImageWithArray:imageArray andIsAutoScroll:YES];
    
    _isRemBtnPressed = NO;//默认为no
    
    
    _userNameTF.clearButtonMode=UITextFieldViewModeAlways;
    _passWordTF.clearButtonMode=UITextFieldViewModeAlways;
    
    //判断是否记录密码
    _userInfo = [KBUserInfo sharedInfo];
    if (_userInfo.isPasswordRecord == NO) {
        _isRemBtnPressed = _userInfo.isPasswordRecord;
        _userNameTF.text = _userInfo.userName;
        [_isPwdRemeberBtn setBackgroundImage:[UIImage imageNamed:@"pwd"] forState:UIControlStateNormal];
    } else if (_userInfo.isPasswordRecord == YES) {
        _isRemBtnPressed = _userInfo.isPasswordRecord;
        _userNameTF.text = _userInfo.userName;
        _passWordTF.text = _userInfo.passWord;
        [_isPwdRemeberBtn setBackgroundImage:[UIImage imageNamed:@"pwdRem"] forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 登陆
- (IBAction)loginBtnClicked:(id)sender {
    //判断是否用户名是否合法
    if ([_userNameTF.text isValidateEmail] || [_userNameTF.text isValidateMobile]) {
        //发起登陆请求
        [SVProgressHUD showWithStatus:@"登录中..." maskType:SVProgressHUDMaskTypeBlack];
        
        [[LoginRequest shareInstance] requestWithUserName:_userNameTF.text andPassWord:_passWordTF.text andLoginFinishedBlock:^{
            //成功后跳转
            
            [SVProgressHUD dismiss];
            NSLog(@"登陆成功");
        } andLoginFaildeBlock:^(NSString *desc) {
            [SVProgressHUD dismiss];
            //展示错误信息
            [UIAlertView showWithTitle:@"温馨提示" Message:desc cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                
            }];
        }];

    } else {
        [SVProgressHUD dismiss];
        [UIAlertView showWithTitle:@"温馨提示" Message:@"用户名或密码错误" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
    }
    
}

- (IBAction)qqLoginBtnClicked:(id)sender {
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:nil];
    UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"FriendsListTableViewController"];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)weiBoLoginClicked:(id)sender {

}

- (IBAction)demoLoginClicked:(id)sender {

}
//记住密码
- (IBAction)isPwdRemeberBtnClicked:(id)sender {
    if (!_isRemBtnPressed) {
        [_isPwdRemeberBtn setBackgroundImage:[UIImage imageNamed:@"pwdRem"] forState:UIControlStateNormal];
        _userInfo.isPasswordRecord = YES;
        [_userInfo save];
        _isRemBtnPressed = YES;
    } else if (_isRemBtnPressed) {
        [_isPwdRemeberBtn setBackgroundImage:[UIImage imageNamed:@"pwd"] forState:UIControlStateNormal];
        _userInfo.isPasswordRecord = NO;
        [_userInfo save];
        _isRemBtnPressed = NO;
    }
}
//忘记密码
- (IBAction)forgetPwdBtnClicked:(id)sender {
}

#pragma mark - 注册
- (IBAction)registerBtnClicked:(id)sender {
//跳转到注册页面
    if (_isModalFromRegist) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        RegisterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
        vc.isModalFromLogin = YES;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
