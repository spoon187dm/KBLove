//
//  SettingTableViewController.m
//  KBLove
//
//  Created by block on 14/10/22.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "SettingTableViewController.h"
#import "FenceSettingViewController.h"
@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"设置01"]]];
    UIImageView *imageview = [UIImageView imageViewWithFrame:self.view.bounds image:[UIImage imageNamed:@"设置01"]];
    [self.tableView setBackgroundView:imageview];
    
    [self changeNavigationBarFromImage:@"设置01"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate
#pragma mark 单元行被选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    取消反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark private method

- (BOOL)isZero:(NSNumber *)number{
    return [number isEqualToNumber:@0];
}

#pragma mark -
#pragma mark 点击事件

- (IBAction)click_nav_back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)click_nav_home:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)click_nav_submit:(id)sender{
    
}

- (IBAction)click_rebootDevice:(id)sender{
    
}

- (IBAction)click_reStartDevice:(id)sender{
    
}

- (IBAction)click_settingFence:(id)sender{
    NSLog(@"098743");
    FenceSettingViewController *fence=[[FenceSettingViewController alloc]initWithNibName:@"FenceSettingView" bundle:nil];
//    KBDevices *device = self.device;
    [self.navigationController pushViewController:fence animated:YES];
}

@end
