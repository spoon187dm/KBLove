//
//  MainViewController.m
//  KBLove
//
//  Created by block on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "MainViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)click_car:(id)sender {
}


- (IBAction)click_person:(id)sender{
}

- (IBAction)click_pet:(id)sender{
}

- (IBAction)click_allDevices:(id)sender{
}

- (IBAction)click_friends:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"FriendsListTableViewController"];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)click_circle:(id)sender{
}

- (IBAction)click_devicesList:(id)sender{
}

- (IBAction)click_message:(id)sender{
}

- (IBAction)click_mine:(id)sender{
}

@end
