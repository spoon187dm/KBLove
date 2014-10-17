//
//  AccountManagerViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14/10/17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AccountManagerViewController.h"

@interface AccountManagerViewController ()

@end

@implementation AccountManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

#pragma mark - configUI
//从NSUSerDefault中读取信息
- (void)loadData {
    KBUserInfo *info = [KBUserInfo sharedInfo];
    _emailLabel.text = info.email;
    _phoneLabel.text = info.phone;
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backItemClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
