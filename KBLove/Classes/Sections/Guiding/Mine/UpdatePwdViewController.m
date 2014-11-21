//
//  UpdatePwdViewController.m
//  KBLove
//
//  Created by Huang on 14/11/20.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UpdatePwdViewController.h"
#import "UIAlertView+EasyTool.h"
#import "KBUserInfo.h"
#import "KBHttpRequestTool.h"

@interface UpdatePwdViewController ()

@end

@implementation UpdatePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)backClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"password------%@",[KBUserInfo sharedInfo].passWord);
}

- (IBAction)ContainClicked:(UIButton *)sender {
    
    if (self.isEditing == YES) {
        
    }else {
        
    }
    
    if ([self.oldPassword.text isEqualToString:@""] && [self.newtext.text isEqualToString:@""] && [self.ConfirmPassword.text isEqualToString:@""]) {
        
        [UIAlertView showWithTitle:@"提示" Message:@"信息不完全" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
        
    }else if (![self.newtext.text isEqualToString:self.ConfirmPassword.text]) {
        [UIAlertView showWithTitle:@"提示" Message:@"两次输入不匹配，请重新输入" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
           
            self.ConfirmPassword.text = @"";
        }];
    }else {
        if (![self.oldPassword.text isEqualToString:[KBUserInfo sharedInfo].passWord]) {
            self.oldPassword.text = @"";
            return;
        }
        NSString * url = [self getUrlEncrypt:self.newtext.text];
        [[KBHttpRequestTool sharedInstance] request:url requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
            if (IsSuccess) {
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSLog(@"request=========%@,tollen======%@",result[@"desc"],[KBUserInfo sharedInfo].token);
                }
            }
            
        }];
    }
    
    
}

- (NSString *)getUrlEncrypt:(NSString *)password
{
    //得到用户信息
    KBUserInfo *userInfo = [KBUserInfo sharedInfo];
    //对密码进行加密
    NSString *twoEncrypt = [[password MD5Hash] MD5Hash];
    //和时间进行拼接
//    NSString *timeEncrypt = [NSString stringWithFormat:@"%@",twoEncrypt];
    NSString *getPwdStr = [[[KBUserInfo sharedInfo].passWord MD5Hash] MD5Hash];
    NSString *oldPwd = [NSString stringWithFormat:@"%@%@",getPwdStr,[KBUserInfo sharedInfo].time];
    NSString *oldPass = [oldPwd MD5Hash];
    
    NSString * url = [ALTER_PASSWORD_URL,userInfo.user_id,oldPass,[self getTime],twoEncrypt,[KBUserInfo sharedInfo].token];
    return url;
}

- (NSString *)getTime
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    
    long long int newTime = time *1000;
    
    NSString *timeStr = [NSString stringWithFormat:@"%lld",newTime];
    return timeStr;
}

//收键盘

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
