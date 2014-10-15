//
//  DevicesCell.h
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TableMenuCell.h"
@class KBDevices;
@interface DevicesCell : TableMenuCell

@property (nonatomic, strong) UILabel *deviceNameLabel;
@property (nonatomic, strong) UILabel *deviceSnLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *deveiceImageView;
@property (nonatomic, strong) UIImageView *deveiceStatusImageView;

- (void)configData:(KBDevices *)devices;

@end
