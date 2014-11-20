//
//  CarDataViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CarDataViewController.h"
#import "UIViewController+NavigationItemSettingTool.h"
#import "WLPieView.h"
@interface CarDataViewController ()
{
    WLPieView * _pieView;
}
@end

@implementation CarDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeNavigationBarFromImage:@"数据01.png"];
    
    //画图
    _pieView = [[WLPieView alloc] initWithFrame:_carPie.bounds andTotal:@(100) andCurrent:@(89) andClockwise:NO andShadow:YES andBgColor:[UIColor orangeColor] andStart:-90.00f andEnd:-89.99f andredius:(_carPie.bounds.size.width-15)/2 andWidth:13 andLabel:YES];
    
    [_pieView strokeChart];
    [_carPie addSubview:_pieView];
    
    [_startView setStart:3];
    
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

- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_home:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
