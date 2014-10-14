//
//  ConfigPersonDeviceViewController.m
//  KBLove
//
//  Created by qianfeng on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "ConfigPersonDeviceViewController.h"

@interface ConfigPersonDeviceViewController ()

@end

@implementation ConfigPersonDeviceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)leftBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
