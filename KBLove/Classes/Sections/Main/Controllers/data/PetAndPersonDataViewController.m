//
//  PetAndPersonDataViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "PetAndPersonDataViewController.h"

@interface PetAndPersonDataViewController ()

@end

@implementation PetAndPersonDataViewController

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

- (IBAction)back_btn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)home_btn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)calendarButton:(id)sender {
}
@end
