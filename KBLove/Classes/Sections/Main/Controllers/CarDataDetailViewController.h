//
//  CarDataDetailViewController.h
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDataDetailViewController : UIViewController

- (IBAction)back_btn:(UIButton *)sender;
- (IBAction)search_btn:(id)sender;
- (IBAction)home_btn:(id)sender;

//详情标题
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//速度饼状图
@property (strong, nonatomic) IBOutlet UIView *speedView;
//里程折线图
@property (strong, nonatomic) IBOutlet UIView *distanceView;
//统计概况
@property (strong, nonatomic) IBOutlet UIView *countView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerVIew;

@end
