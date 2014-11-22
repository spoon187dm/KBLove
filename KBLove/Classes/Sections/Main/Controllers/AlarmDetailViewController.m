//
//  AlarmDetailViewController.m
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AlarmDetailViewController.h"
#import <ReactiveCocoa.h>
typedef void (^buttonClickBlock)(UIButton *btn);
@interface AlarmDetailViewController ()

@end

@implementation AlarmDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView{
    [self addBUttonFrame:CGRectMake(10, kScreenHeight-20-40, kScreenWidth-20, 40) title:@"关闭警报1" action:^(UIButton *btn) {
        
    }];
    
    [self addBUttonFrame:CGRectMake(10, kScreenHeight-20-60-40, kScreenWidth-20, 40) title:@"关闭警报2" action:^(UIButton *btn) {
        
    }];
    
    [self addBUttonFrame:CGRectMake(10, kScreenHeight-20-120-40, kScreenWidth-20, 40) title:@"关闭警报3" action:^(UIButton *btn) {
        
    }];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"数据01"]];
    
}

#pragma mark -
#pragma mark private

- (void)addBUttonFrame:(CGRect)frame title:(NSString *)title action:(buttonClickBlock)block{
    UIButton *btn = [UIButton buttonWithFrame:frame title:title];
    [btn setBackgroundImage:[UIImage imageNamed:@"报警模块41_11"] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        block(btn);
    }];
    [self.view addSubview:btn];
}

#pragma mark -
#pragma mark 界面点击事件
- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_home:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
