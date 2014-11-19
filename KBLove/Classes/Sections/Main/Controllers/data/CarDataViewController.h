//
//  CarDataViewController.h
//  KBLove
//
//  Created by qianfeng on 14-11-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DeviceDataViewController.h"
#import "WLStartView.h"

@interface CarDataViewController : DeviceDataViewController

- (IBAction)click_back:(UIButton *)sender;
- (IBAction)click_home:(UIButton *)sender;
//小车评分百分比图
@property (strong, nonatomic) IBOutlet UIView *carPie;
//根据百分比图颜色设置提示
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;
//评分星级
@property (strong, nonatomic) IBOutlet WLStartView *startView;

//OBD检测按钮
@property (strong, nonatomic) IBOutlet UIButton *OBDButton;
//今日里程
@property (strong, nonatomic) IBOutlet UILabel *todayCourse;
//平均速度
@property (strong, nonatomic) IBOutlet UILabel *averageLabel;
//最高速度
@property (strong, nonatomic) IBOutlet UILabel *MaxSpeedLabel;
//行驶时间
@property (strong, nonatomic) IBOutlet UILabel *travelTimeLabel;
//超速次数
@property (strong, nonatomic) IBOutlet UILabel *OverSpeedLabel;
//总里程
@property (strong, nonatomic) IBOutlet UILabel *totalCourseLabel;

@end
