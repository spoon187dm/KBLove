//
//  CarSettingViewController.m
//  KBLove
//
//  Created by block on 14/10/22.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CarSettingViewController.h"
#import "FenceSettingViewController.h"
@interface CarSettingViewController ()

@end

@implementation CarSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DeviceFenceSetting:(id)sender
{
    NSLog(@"098743");
    FenceSettingViewController *fence=[[FenceSettingViewController alloc]initWithNibName:@"FenceSettingView" bundle:nil];
    [self.navigationController pushViewController:fence animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
