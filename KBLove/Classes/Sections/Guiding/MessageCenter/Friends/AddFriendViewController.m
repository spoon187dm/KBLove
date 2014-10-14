//
//  AddFriendViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AddFriendViewController.h"
#import "KBHttpRequestTool.h"
#import "KBFriendInfo.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - loadData
- (void)loadData {
    //获得当前user_id
    NSString *user_id = [KBUserInfo sharedInfo].user_id;
    //获得当前token
    NSString *token = [KBUserInfo sharedInfo].token;
    //拼接urlStr
    NSString *urlStr = [NSString stringWithFormat:SEARCHFRIEND_URL,user_id,token,_userNameTextField.text,49];
    //发起请求
    [[KBHttpRequestTool sharedInstance] request:urlStr requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {//如果成功
            if ([result isKindOfClass:[NSDictionary class]]) {//如果是字典类型
                NSDictionary *root = (NSDictionary *)result;
                KBFriendInfo *info = [[KBFriendInfo alloc] init];
                [info setValuesForKeysWithDictionary:root[@"user"]];
                
                //如果成功获得查询数据则弹出modal视图展示
                UIStoryboard *stb = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:nil];
                UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
                [self.navigationController pushViewController:vc animated:YES];
                
            } else {//如果不是字典类型
            
            }
        } else {//如果失败
        
        }
    }];
}

#pragma mark -
#pragma mark - click and touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)leftItemClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addFromAdressBtnClicked:(id)sender {
}

- (IBAction)addFromQQBtnClicked:(id)sender {
}
- (IBAction)searchBtnClicked:(id)sender {
    if (_userNameTextField.text.length != 0) {
        [self loadData];
    }
    
}
- (IBAction)addFromWeiBoBtnClicked:(id)sender {
}
@end
