//
//  PetAndPersonDataViewController.h
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceDataViewController.h"
#import "WLPieView.h"

@interface PetAndPersonDataViewController : DeviceDataViewController
- (IBAction)back_btn:(id)sender;
- (IBAction)home_btn:(id)sender;

//人或者宠物的头像
@property (strong, nonatomic) IBOutlet UIImageView *iconImageVIew;
@property (strong, nonatomic) IBOutlet UIButton *calendar;

//日历按钮点击
- (IBAction)calendarButton:(id)sender;

//今日运动量
@property (strong, nonatomic) IBOutlet UILabel *todayExerciseLabel;
//30天平均运动量
@property (strong, nonatomic) IBOutlet UILabel *averageExerciseLabel;
//底部scrollView
@property (strong, nonatomic) IBOutlet UIScrollView *petScrollVIew;

@end
