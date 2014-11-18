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
#import "UMSocial.h"
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
        
//        [[LoginRequest shareInstance] requestWithUserName:_userNameTF.text andPassWord:_passWordTF.text andLoginFinishedBlock:^{
//            //成功后跳转
//            
//            [SVProgressHUD dismiss];
            [self gotoMainVireController];
            NSLog(@"登陆成功");
//        } andLoginFaildeBlock:^(NSString *desc) {
//            [SVProgressHUD dismiss];
//            //展示错误信息
//            [UIAlertView showWithTitle:@"温馨提示" Message:desc cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
//                
//            }];
//        }];

    } else {
        [SVProgressHUD dismiss];
        [UIAlertView showWithTitle:@"温馨提示" Message:@"用户名或密码错误" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
    }
    
}

- (IBAction)qqLoginBtnClicked:(id)sender {
    //判断是否授权到某个微博平台，并且Token没有过期，例如有没有授权到新浪微博
    BOOL b = [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToQQ];
    NSLog(@"判断是否授权到某个微博平台，并且Token没有过期:%d",b);
    
    if (b == 1) {
        
        //包括各平台的uid和accestoken，各个平台不一样，腾讯微博有openid。得到的数据在回调Block对象形参respone的data属性。
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
            NSLog(@"SnsInformation is %@",response.data);
        }];
        
        //判断是否已经登录友盟账号。
        BOOL isLoginWithSnsAccount = [UMSocialAccountManager isLoginWithSnsAccount];
        NSLog(@"判断是否已经登录友盟账号---isLoginWithSnsAccount:%d",isLoginWithSnsAccount);
        
        //登录友盟账号，选择登录的平台一定为已经授权的微博平台，否则无法正常登录。下面是选择新浪微博作为友盟账号。
        //[[UMSocialDataService defaultDataService] requestBindToSnsWithType:UMShareToSina completion:nil];
        
        [[UMSocialDataService defaultDataService] requestBindToSnsWithType:UMShareToQQ completion:^(UMSocialResponseEntity *response) {
            NSLog(@"使用友盟登录成功！！！！！！");
            if (response.data) {
                NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response.data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic);
            }
        }];
        
        //判断新浪微博账号的token是否有效
        [[UMSocialDataService defaultDataService] requestIsTokenValid:@[UMShareToQQ] completion:^(UMSocialResponseEntity *response) {
            NSLog(@"判断新浪微博账号的token是否有效---is token valid is %@",[response.data.allValues objectAtIndex:0]);
        }];
        //如果已经授权，打印信息
        NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
        UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToQQ];
        NSLog(@"sina nickName is %@, iconURL is %@",sinaAccount.userName,sinaAccount.iconURL);
        
       
        
    }
    else
    {
        NSLog(@"没有授权!");
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          NSLog(@"response is %@",response);
                                          
                                          
                                      });
        
    };

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

- (void)gotoMainVireController{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"MainNavigationViewController"];
    [self presentViewController:vc animated:YES completion:^{
#warning 进入主界面时清除所有view
        for (UIView *view in self.view.subviews) {
            [view removeFromSuperview];
            
        }
        self.view = nil;
    }];
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
