//
//  MineViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "MineViewController.h"
#import "KBUserManager.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

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
