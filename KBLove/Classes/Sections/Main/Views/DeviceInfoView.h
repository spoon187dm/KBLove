//
//  DevecieInfoView.h
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceInfoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *deviceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *deviceTypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *alarmStatusImageView;
@property (weak, nonatomic) IBOutlet UIImageView *deviceMoveStatuImageView;
@property (weak, nonatomic) IBOutlet UILabel *deveiceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceSnLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
