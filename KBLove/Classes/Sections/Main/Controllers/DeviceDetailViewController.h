//
//  DeviceDetailViewController.h
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBDevices;
@interface DeviceDetailViewController : UIViewController

@property (nonatomic, strong) KBDevices *device;

- (IBAction)click_back:(UIButton *)sender;
- (IBAction)click_home:(id)sender;
//报警
- (IBAction)click_alarm:(UIButton *)sender;
//数据
- (IBAction)click_data:(UIButton *)sender;
//轨迹
- (IBAction)click_track:(UIButton *)sender;
//删除
- (IBAction)click_delete:(UIButton *)sender;
//设置
- (IBAction)click_setting:(UIButton *)sender;

@end
