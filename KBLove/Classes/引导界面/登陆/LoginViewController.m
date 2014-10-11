//
//  LoginViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //为banner赋值
    NSArray *imageArray = @[@"bj.png",@"bj.png",@"bj.png",@"bj.png",@"bj.png"];
    [_bannerView setImageWithArray:imageArray andIsAutoScroll:YES];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 登陆
- (void)loginBtnClicked:(id)sender {

}

- (void)qqLoginBtnClicked:(id)sender {

}

- (void)weiBoLoginClicked:(id)sender {

}

- (void)demoLoginClicked:(id)sender {

}

#pragma mark - 注册
- (void)registerBtnClicked:(id)sender {

}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
