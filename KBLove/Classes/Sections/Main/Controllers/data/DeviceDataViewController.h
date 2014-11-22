//
//  DeviceDataViewController.h
//  KBLove
//
//  Created by qianfeng on 14-11-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBDevices;
@class KBDevicesStatus;

@interface DeviceDataViewController : UIViewController

@property (nonatomic, strong) KBDevicesStatus *deviceStatus;
@property (nonatomic, strong) KBDevices *device;
@end
