//
//  CarDataViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CarDataViewController.h"
#import "UIViewController+NavigationItemSettingTool.h"
@interface CarDataViewController ()

@end

@implementation CarDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeNavigationBarFromImage:@"数据01.png"];
    
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

- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_home:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
