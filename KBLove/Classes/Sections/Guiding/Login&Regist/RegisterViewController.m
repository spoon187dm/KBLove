//
//  RegisterViewController.m
//  KBLove
//
//  Created by qianfeng on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "DxConnection.h"
#import "KBHttpRequestTool.h"
#import "NSString+WLTooll.h"
//#import "CircleViewController.h"
#import "CircleAndFriendListViewController.h"
@interface RegisterViewController ()
{
    RegisterType _registertype;
}
@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //为banner赋值
    NSArray *imageArray = @[@"bj.png",@"bj.png",@"bj.png",@"bj.png",@"bj.png"];
    [_bannerView setImageWithArray:imageArray andIsAutoScroll:YES];
    
    //默认电话注册
    _registertype=phone;
    _verifyPasswordTextfiled.secureTextEntry=YES;
    _passwordTextFiled.secureTextEntry=YES;
    _userNameTextfiled.clearButtonMode=UITextFieldViewModeAlways;
    _passwordTextFiled.clearButtonMode=UITextFieldViewModeAlways;
    _verifyPasswordTextfiled.clearButtonMode=UITextFieldViewModeAlways;
    // Do any additional setup after loading the view.
}
//电话注册
- (IBAction)phoneRegisterButton:(id)sender
{
    _userNameTextfiled.placeholder=@"电话注册";
    _registertype=phone;
    [_phoneRegisterButton setBackgroundImage:[UIImage imageNamed:@"telregisterbtn"] forState:UIControlStateNormal];
    [_mailRegisterButton setBackgroundImage:[UIImage imageNamed:@"mailregisterbtn"] forState:UIControlStateNormal];
}
//邮箱注册
- (IBAction)mailRegisterButton:(id)sender
{
    _userNameTextfiled.placeholder=@"邮箱注册";
    _registertype=email;
    [_phoneRegisterButton setBackgroundImage:[UIImage imageNamed:@"mailregisterbtnSelected"] forState:UIControlStateNormal];
    [_mailRegisterButton setBackgroundImage:[UIImage imageNamed:@"telregisterbtnNormal"] forState:UIControlStateNormal];
}
#pragma mark - 注册
//注册
- (IBAction)RegisterButton:(id)sender
{
    if (_userNameTextfiled.text.length&&_passwordTextFiled.text.length&&_verifyPasswordTextfiled.text) {
        
        
        /**
         *  现在的需要不需要判断手机或者邮箱
         */
//        switch (_registertype) {
//            case phone:{
        if (![_userNameTextfiled.text isValidateMobile]) {
            [self showAlertWithTitle:@"温馨提示" AndMessage:@"手机号不合法"];
             return;
        }
//
//                
//            }break;
//            case email:{
//                if (![_userNameTextfiled.text isValidateEmail]) {
//                    [self showAlertWithTitle:@"温馨提示" AndMessage:@"邮箱不合法"];
//                    return;
//                }
//            }break;
//            default:
//                break;
//        }
        
        if (![_passwordTextFiled.text isEqualToString:_verifyPasswordTextfiled.text])
        {
            [self showAlertWithTitle:@"温馨提示" AndMessage:@"两次输入密码不一致"];
            return;
        }
        
        [KBFreash startRefreshWithTitle:@"注册中..." inView:self.view];
        
        
        //信息没有错误 进行注册
        NSLog(@"---%@", [NSString stringWithFormat:REGRSTER_URL,(int)_registertype,_userNameTextfiled.text,[_passwordTextFiled.text MD5Hash]]);
        [[KBHttpRequestTool sharedInstance] request:[NSString stringWithFormat:REGRSTER_URL,(int)_registertype,_userNameTextfiled.text,[_passwordTextFiled.text MD5Hash]] requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
            [KBFreash StopRefreshinView:self.view];
            if (IsSuccess) {
               //注册成功
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSLog(@"resultDic:%@",result);
                    NSDictionary *dic=result;
                    NSNumber *ret=[dic objectForKey:@"ret"];
                    NSString *des=[dic objectForKey:@"desc"];
                    NSString *token=[dic objectForKey:@"token"];
                    NSString *user_id=[dic objectForKey:@"user_id"];
                    if ([ret intValue]) {
                        if([ret intValue]==2)
                        {
                            [UIAlertView showWithTitle:@"提示" Message:[result objectForKey:@"desc"] cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                                
                            }];
                            return ;
                        }
                        //注册成功 存储信息 跳转到 成功界面
                        KBUserInfo *user=[KBUserInfo sharedInfo];
                        user.token=token;
                        user.userName=_userNameTextfiled.text;
                        user.user_id=user_id;
                        user.passWord=_passwordTextFiled.text;
                        
                        UINavigationController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistFinishNavigationController"];

                        
                        [self presentViewController:vc animated:YES completion:^{
                            
                        }];
                        
                    }else
                    {
                        //失败 打印 描述信息
//                        NSLog(@"%@",des);
                        [self showAlertWithTitle:@"温馨提示" AndMessage:des];
                    }
                }else if ([result isKindOfClass:[NSData class]]){
//                    NSLog(@"resultData:%@",result);
                }
                
                
            }else{
            
                
                [self showAlertWithTitle:@"温馨提示" AndMessage:[(NSError *)result localizedDescription] ];
            }
            
        }];
    }else
    {
        [self showAlertWithTitle:@"温馨提示" AndMessage:@"信息填写不完整"];
    }
  
}

- (void)showAlertWithTitle:(NSString *)title AndMessage:(NSString *)msg
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
#pragma mark - 登陆
//登陆
- (IBAction)loginBtnClicked:(id)sender
{
    //跳转到登陆界面
    if (_isModalFromLogin) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        vc.isModalFromRegist = YES;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
}
#pragma  mark - 测试接口
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //手键盘
    [self.view endEditing:YES];
//    UINavigationController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistFinishNavigationController"];
//    
//    
//    [self presentViewController:vc animated:YES completion:^{
//        
//    }];
    //测试圈子用 上线是需要关闭
//    CircleViewController *circle=[[CircleViewController alloc]init];
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:circle];
//    [self presentViewController:nav animated:YES completion:^{
//        
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
