//
//  CarDataDetailViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CarDataDetailViewController.h"

@interface CarDataDetailViewController ()

@end

@implementation CarDataDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _scrollerVIew.contentSize = CGSizeMake(self.view.bounds.size.width, _countView.frame.size.height + self.view.bounds.size.height);
    
    if (_str) {
        NSLog(@"str======================%@",_str);
    }
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

- (IBAction)back_btn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)search_btn:(id)sender {
}

- (IBAction)home_btn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
