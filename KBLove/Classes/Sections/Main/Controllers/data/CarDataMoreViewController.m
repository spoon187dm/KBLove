//
//  CarDataMoreViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CarDataMoreViewController.h"
#import "CarDataDetailViewController.h"
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
    
    /** wwww */
    WLPieView *tpieView1 = [[WLPieView alloc] initWithFrame:_WpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor redColor] andStart:-45.00f andEnd:-45.01f andredius:(_WpieView.bounds.size.width-5)/2 andWidth:3 andLabel:YES];
    [tpieView1 strokeChart];
    [_WpieView addSubview:tpieView1];
    
    WLPieView *tpieView22 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(100) andClockwise:YES andShadow:NO andBgColor:[UIColor grayColor] andStart:-45.00f andEnd:-45.01f andredius:(_MpieView.bounds.size.width)/2-7 andWidth:17 andLabel:NO];
    [tpieView22 strokeChart];
    [_WpieView addSubview:tpieView22];
    WLPieView *tpieView23 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor redColor] andStart:-90.00f andEnd:-90.01f andredius:(_MpieView.bounds.size.width)/2-1 andWidth:2 andLabel:NO];
    [tpieView23 strokeChart];
    [_WpieView addSubview:tpieView23];
    WLPieView *tpieView24 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor greenColor] andStart:-45.00f andEnd:-45.01f andredius:(_MpieView.bounds.size.width)/2-5 andWidth:2 andLabel:NO];
    [tpieView24 strokeChart];
    [_WpieView addSubview:tpieView24];
    WLPieView *tpieView25 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor orangeColor] andStart:0.00f andEnd:-0.01f andredius:(_MpieView.bounds.size.width)/2-9 andWidth:2 andLabel:YES];
    [tpieView25 strokeChart];
    [_MpieView addSubview:tpieView25];
    WLPieView *tpieView26 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor purpleColor] andStart:45.00f andEnd:44.99f andredius:(_MpieView.bounds.size.width)/2-13 andWidth:2 andLabel:YES];
    [tpieView26 strokeChart];
    [_WpieView addSubview:tpieView26];
    
    /** mmm */
    WLPieView *tpieView2 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(100) andClockwise:YES andShadow:NO andBgColor:[UIColor grayColor] andStart:-45.00f andEnd:-45.01f andredius:(_MpieView.bounds.size.width)/2-7 andWidth:17 andLabel:NO];
    [tpieView2 strokeChart];
    [_MpieView addSubview:tpieView2];
    WLPieView *tpieView3 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor redColor] andStart:-90.00f andEnd:-90.01f andredius:(_MpieView.bounds.size.width)/2-1 andWidth:2 andLabel:NO];
    [tpieView3 strokeChart];
    [_MpieView addSubview:tpieView3];
    WLPieView *tpieView4 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor greenColor] andStart:-45.00f andEnd:-45.01f andredius:(_MpieView.bounds.size.width)/2-5 andWidth:2 andLabel:NO];
    [tpieView4 strokeChart];
    [_MpieView addSubview:tpieView4];
    WLPieView *tpieView5 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor orangeColor] andStart:0.00f andEnd:-0.01f andredius:(_MpieView.bounds.size.width)/2-9 andWidth:2 andLabel:YES];
    [tpieView5 strokeChart];
    [_MpieView addSubview:tpieView5];
    WLPieView *tpieView6 = [[WLPieView alloc] initWithFrame:_MpieView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:YES andShadow:NO andBgColor:[UIColor purpleColor] andStart:45.00f andEnd:44.99f andredius:(_MpieView.bounds.size.width)/2-13 andWidth:2 andLabel:YES];
    [tpieView6 strokeChart];
    [_MpieView addSubview:tpieView6];
    
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"today2Detail"]) {
        CarDataDetailViewController * cv = segue.destinationViewController;
       
        cv.titleLabel.text = @"今日详情";
       
    }else if ([segue.identifier isEqualToString:@"week2Detail"]) {
        CarDataDetailViewController * cv = segue.destinationViewController;
        cv.titleLabel.text = @"本周详情";
    }else if ([segue.identifier isEqualToString:@"month2Detail"]) {
        CarDataDetailViewController * cv = segue.destinationViewController;
        cv.titleLabel.text = @"本月详情";
       
    }
}
@end
