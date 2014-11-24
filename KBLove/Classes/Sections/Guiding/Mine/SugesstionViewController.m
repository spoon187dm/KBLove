//
//  SugesstionViewController.m
//  KBLove
//
//  Created by Huang on 14/11/20.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "SugesstionViewController.h"

@interface SugesstionViewController ()

@end

@implementation SugesstionViewController

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
}
@end
