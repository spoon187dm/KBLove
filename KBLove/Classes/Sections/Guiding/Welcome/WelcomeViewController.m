//
//  WelcomeViewController.m
//  KBLove
//
//  Created by block on 14-10-12.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(100, 100, 200, 200) title:@"click" clickBlock:^(UIButton *button) {
        NSLog(@"clicked");
    }];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setClickBlock:^(UIButton *button) {
        NSLog(@"click2");
    }];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toregist"]) {
        RegisterViewController *vc = segue.destinationViewController;
        vc.isModalFromLogin = NO;
    }else{
        LoginViewController *vc = segue.destinationViewController;
        vc.isModalFromRegist = NO;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
