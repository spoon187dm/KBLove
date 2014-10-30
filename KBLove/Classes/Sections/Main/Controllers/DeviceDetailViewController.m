//
//  DeviceDetailViewController.m
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "KBAlarmManager.h"
#import "AlarmListViewController.h"
#import "KBDeviceManager.h"

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark -
#pragma mark 获取设备信息
    [KBDeviceManager getDeviceInfo:_device.sn finishBlock:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            _device = result;
        }
    }];

#pragma mark 获取设备状态
    [KBDeviceManager getDeviceStatus:_device.sn finishBlock:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            _deviceStatus = result;
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark 界面点击事件
- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_home:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//报警
- (IBAction)click_alarm:(UIButton *)sender{
    AlarmListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmListViewController"];
    vc.device = _device;
    [self.navigationController pushViewController:vc animated:YES];
}

//数据
- (IBAction)click_data:(UIButton *)sender{
    
}

//轨迹
- (IBAction)click_track:(UIButton *)sender{
    
}

//删除
- (IBAction)click_delete:(UIButton *)sender{
    
}

//设置
- (IBAction)click_setting:(UIButton *)sender{
    
}

@end
