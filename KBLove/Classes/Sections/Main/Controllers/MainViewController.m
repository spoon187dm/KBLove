//
//  MainViewController.m
//  KBLove
//
//  Created by block on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "MainViewController.h"
#import "KBDevices.h"
#import "KBAccount.h"
#import "CircleViewController.h"
@interface MainViewController ()

- (IBAction)click_car:(id)sender;
- (IBAction)click_person:(id)sender;
- (IBAction)click_pet:(id)sender;
- (IBAction)click_allDevices:(id)sender;
- (IBAction)click_friends:(id)sender;
- (IBAction)click_circle:(id)sender;
- (IBAction)click_devicesList:(id)sender;
- (IBAction)click_message:(id)sender;
- (IBAction)click_mine:(id)sender;

@end

@implementation MainViewController

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
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click_car:(id)sender {
}


- (IBAction)click_person:(id)sender{
}

- (IBAction)click_pet:(id)sender{
}

- (IBAction)click_allDevices:(id)sender{
    [[KBAccount sharedAccount]getDevicesStatus:^(BOOL isSuccess) {
        if (isSuccess) {
            NSArray *array = [KBAccount sharedAccount].devicesArray;
            NSLog(@"%@",array);
        }
    }];
}

- (IBAction)click_friends:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"FriendsListTableViewController"];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)click_circle:(id)sender{
    CircleViewController *vc = [[CircleViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click_devicesList:(id)sender{
    
}

- (IBAction)click_message:(id)sender{
}

- (IBAction)click_mine:(id)sender{
}

@end
