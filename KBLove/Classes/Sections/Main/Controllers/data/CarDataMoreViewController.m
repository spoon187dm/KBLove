//
//  CarDataMoreViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CarDataMoreViewController.h"

@interface CarDataMoreViewController ()
{
    WLPieView * tpieView;
}
@end

@implementation CarDataMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tpieView = [[WLPieView alloc] initWithFrame:_TpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor redColor] andStart:-45.00f andEnd:-45.01f andredius:(_TpieView.bounds.size.width-5)/2 andWidth:3 andLabel:YES];
    [tpieView strokeChart];
    [_TpieView addSubview:tpieView];
    
    WLPieView *tpieView1 = [[WLPieView alloc] initWithFrame:_WpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor redColor] andStart:-45.00f andEnd:-45.01f andredius:(_WpieView.bounds.size.width-5)/2 andWidth:3 andLabel:YES];
    [tpieView1 strokeChart];
    [_WpieView addSubview:tpieView1];
    
    WLPieView *tpieView2 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor redColor] andStart:-45.00f andEnd:-45.01f andredius:(_MpieView.bounds.size.width-5)/2 andWidth:3 andLabel:YES];
    [tpieView2 strokeChart];
    [_MpieView addSubview:tpieView2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)back_btn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)home_btn:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//搜索
- (IBAction)search_btn:(UIButton *)sender {
}
//今日详情
- (IBAction)todayDetail_btn:(id)sender {
    
}
//本周详情
- (IBAction)weekDetail_btn:(id)sender {
    
}
//本月详情
- (IBAction)monthDetail_btn:(id)sender {
    
}
@end
