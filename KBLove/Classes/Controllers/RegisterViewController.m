//
//  RegisterViewController.m
//  KBLove
//
//  Created by qianfeng on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "RegisterViewController.h"
#import "DxConnection.h"
#import "WLHttpRequestTool.h"
#import "NSString+WLTooll.h"
@interface RegisterViewController ()
{
    RegisterType _registertype;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认电话注册
    _registertype=phone;
    // Do any additional setup after loading the view.
}
//电话注册
- (IBAction)phoneRegisterButton:(id)sender
{
    _userNameTextfiled.placeholder=@"电话注册";
    _registertype=phone;
}
//邮箱注册
- (IBAction)mailRegisterButton:(id)sender
{
    _userNameTextfiled.placeholder=@"邮箱注册";
    _registertype=email;
}
//注册
- (IBAction)RegisterButton:(id)sender
{
    if (_userNameTextfiled.text.length&&_passwordTextFiled.text.length&&_verifyPasswordTextfiled.text) {
        
        switch (_registertype) {
            case phone:{
                if ([_userNameTextfiled.text isValidateMobile]) {
                    [self showAlertWithTitle:@"温馨提示" AndMessage:@"手机号不合法"];
                }
                return;
                
            }break;
            case email:{
                if ([_userNameTextfiled.text isValidateEmail]) {
                    [self showAlertWithTitle:@"温馨提示" AndMessage:@"邮箱不合法"];
                    return;
                }
            }break;
            default:
                break;
        }
        if (![_passwordTextFiled.text isEqualToString:_verifyPasswordTextfiled.text]) {
            [self showAlertWithTitle:@"温馨提示" AndMessage:@"两次输入密码不一致"];
            return;
            }
        //信息没有错误 进行 注册
        [[WLHttpRequestTool sharedInstance] request:[REGRSTER_URL,_registertype,_userNameTextfiled.text,_passwordTextFiled.text] requestType:WLHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
            if (IsSuccess) {
               //注册成功
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
//登陆
- (IBAction)loginBtnClicked:(id)sender
{
    //跳转到登陆界面
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
