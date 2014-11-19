//
//  CarDataMoreViewController.h
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLPieView.h"
@interface CarDataMoreViewController : UIViewController

//今日行驶情况
- (IBAction)todayDetail_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *TcourseLabel;

@property (strong, nonatomic) IBOutlet UILabel *TaverageSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *TtravelTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ToverSpeedLabel;
@property (strong, nonatomic) IBOutlet UIView *TpieView;





//本周行驶情况
- (IBAction)weekDetail_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *WcourseLabel;
@property (strong, nonatomic) IBOutlet UILabel *WaverageSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *WtravelTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *WoverSpeedLabel;
@property (strong, nonatomic) IBOutlet UIView *WpieView;




//本月行驶情况

- (IBAction)monthDetail_btn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *McourseLabel;
@property (strong, nonatomic) IBOutlet UILabel *MaverageSpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *MtravelTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *MoverSpeedLabel;
@property (strong, nonatomic) IBOutlet UIView *MpieView;



- (IBAction)back_btn:(UIButton *)sender;
- (IBAction)home_btn:(UIButton *)sender;
//搜索
- (IBAction)search_btn:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *todayVIew;
@property (strong, nonatomic) IBOutlet UIView *weekView;
@property (strong, nonatomic) IBOutlet UIView *monthView;

@end
