//
//  PersonSettingViewController.m
//  KBLove
//
//  Created by block on 14/10/22.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "PersonSettingViewController.h"
#import "DXSwitch.h"
#import "KBDevices.h"
@interface PersonSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField_Frequency;
@property (weak, nonatomic) IBOutlet UITextField *textField_OverSpeed;
@property (weak, nonatomic) IBOutlet DXSwitch *switch_OverSpeedAlarm;
@property (weak, nonatomic) IBOutlet DXSwitch *switch_FenceAlarm;
@property (weak, nonatomic) IBOutlet UIButton *button_FenceSetting;

@end

@implementation PersonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hasValueChanged = NO;
    [self setUpView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 界面初始化
- (void)setUpView{
    [_switch_FenceAlarm setON:![self isZero:self.device.fence_warning_switch] animation:YES];
    [_switch_OverSpeedAlarm setON:![self isZero:self.device.speeding_switch] animation:YES];
    
    [_switch_FenceAlarm setValueChangeBlock:^(BOOL value){
        if (!value) {
            [_button_FenceSetting setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else{
            [_button_FenceSetting setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        _button_FenceSetting.enabled = value;
        self.device.fence_warning_switch = value?@1:@0;
        _hasValueChanged = YES;
    }];
    
    [_switch_OverSpeedAlarm setValueChangeBlock:^(BOOL value){
        if (!value) {
            _textField_OverSpeed.textColor = [UIColor lightGrayColor];
        }else{
            _textField_OverSpeed.textColor = [UIColor whiteColor];
        }
        _textField_OverSpeed.enabled = value;
        self.device.fence_warning_switch = value?@1:@0;
        _hasValueChanged = YES;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
