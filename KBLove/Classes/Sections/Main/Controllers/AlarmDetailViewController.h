//
//  AlarmDetailViewController.h
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBAlarm;
@interface AlarmDetailViewController : UIViewController

// ui
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmInfoLabel;

//
@property (nonatomic, strong) KBAlarm *alarm;

- (IBAction)click_back:(UIButton *)sender;
- (IBAction)click_home:(id)sender;



@end
