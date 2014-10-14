//
//  ChangeInformationViewController.m
//  KBLove
//
//  Created by qianfeng on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "ChangeInformationViewController.h"

@interface ChangeInformationViewController ()

@end

@implementation ChangeInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
//导航条左侧按钮点击事件
- (IBAction)leftNavBarButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rightButtonClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
