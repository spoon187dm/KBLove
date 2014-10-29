//
//  SettingTableViewController.m
//  KBLove
//
//  Created by block on 14/10/22.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"设置01"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click_nav_back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)click_nav_home:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)click_nav_submit:(id)sender{
    
}

@end
