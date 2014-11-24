//
//  DeviceDetailViewController.h
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <MAMapKit/MAMapKit.h>
@class KBDevices;
@class KBDevicesStatus;
@interface DeviceDetailViewController : UIViewController<BMKMapViewDelegate,MAMapViewDelegate>

@property (nonatomic, strong) KBDevicesStatus *deviceStatus;
@property (nonatomic, strong) KBDevices *device;


- (IBAction)click_refrash:(UIButton *)sender;
- (IBAction)click_lacation:(UIButton *)sender;
- (IBAction)click_zoomin:(UIButton *)sender;
- (IBAction)click_zoomout:(UIButton *)sender;

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
