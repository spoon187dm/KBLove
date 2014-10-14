//
//  SearchResultViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "SearchResultViewController.h"
#import "KBHttpRequestTool.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userNameLabel.text = _userName;
}

#pragma mark - loadData
- (void)loadData {
    //获得当前user_id
    NSString *user_id = [KBUserInfo sharedInfo].user_id;
    //获得当前token
    NSString *token = [KBUserInfo sharedInfo].token;
    //拼接urlStr
    NSString *urlStr = [NSString stringWithFormat:VERIFYMESSAGE_URL,user_id,token,_friendId,51];
    NSLog(@"%@",urlStr);
    //发起请求
    [[KBHttpRequestTool sharedInstance] request:urlStr requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *root = (NSDictionary *)result;
                if ([root[@"ret"] integerValue] == 1) {
                    [UIAlertView showWithTitle:@"温馨提示" Message:@"添加成功!" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                        if (index == 0) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                    }];
                } else if ([root[@"ret"] integerValue] == 2) {
                    
                }
            }
        } else {
            
        }
    }];
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftItemClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addFriendBtnClicked:(id)sender {
    [self loadData];
}
@end
