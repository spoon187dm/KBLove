//
//  MineViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "MineViewController.h"
#import "KBUserManager.h"
#import "KBHttpRequestTool.h"
#import <SVProgressHUD.h>

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

#pragma mark - loadData
//通过搜索自己拿到自己的全部信息
- (void)loadData {
    //拿到user_id
    NSString *user_id = [KBUserInfo sharedInfo].user_id;
    //拿到token
    NSString *token = [KBUserInfo sharedInfo].token;
    //拿到name
    NSString *name = [KBUserInfo sharedInfo].userName;

    [SVProgressHUD showWithStatus:@"个人信息获取中..." maskType:SVProgressHUDMaskTypeBlack];
    [[KBHttpRequestTool sharedInstance] request:[NSString stringWithFormat:SEARCHFRIEND_URL,user_id,token,name,49] requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {//成功
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *root = (NSDictionary *)result;
                KBUserInfo *info = [KBUserInfo sharedInfo];
                [info setValuesForKeysWithDictionary:root[@"user"]];
                [info save];
                [SVProgressHUD dismiss];
            } else {
                [SVProgressHUD dismiss];
            }
        } else {
            [SVProgressHUD dismiss];
        }
    }];

}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)backItemClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)logOutBtnClicked:(id)sender {
    [[KBUserManager sharedAccount] logOut:^(BOOL isSuccess, id result) {
        
    }];
}


@end
