//
//  AddFriendViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)leftItemClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
