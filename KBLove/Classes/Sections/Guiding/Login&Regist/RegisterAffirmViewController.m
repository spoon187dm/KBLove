//
//  RegisterAffirmViewController.m
//  KBLove
//
//  Created by yuri on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "RegisterAffirmViewController.h"
#import "MainViewController.h"

@interface RegisterAffirmViewController ()

/** 验证码输入框*/
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
/** 重写发送*/
@property (weak, nonatomic) IBOutlet UIButton *resendBtn;

/** 确认验证码*/
@property (weak, nonatomic) IBOutlet UIButton *affirmBtn;

@property (weak, nonatomic) IBOutlet UIButton *descView;

/** 重新发送点击*/
- (IBAction)resendBtnClick:(id)sender;

/** 提交验证点击*/
- (IBAction)affirmBtnClick:(id)sender;


@end

@implementation RegisterAffirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.descView.titleLabel.numberOfLines = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)resendBtnClick:(id)sender {
    
#warning 重新发送验证码
}

- (IBAction)affirmBtnClick:(id)sender {
    
#warning 手机验证码短信判断
    
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UINavigationController *nav = [stb instantiateViewControllerWithIdentifier:@"MainNavigationViewController"];
    MainViewController *welcomeVc = (MainViewController *)nav.topViewController;
    // 通知主界面第一次登陆
    welcomeVc.firstLogin = YES;

    [self presentViewController:nav animated:YES completion:^{
        // 销毁自身所有子控件，简约内存
        for (UIView *subview in self.view.subviews) {
            [subview removeFromSuperview];
        }
        self.view = nil;
    }];
}
@end
