//
//  DeviceTableHeadView.m
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DeviceTableHeadView.h"

@implementation DeviceTableHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    _backGroundView.layer.masksToBounds = YES;
    _backGroundView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _backGroundView.layer.borderWidth = 1;
    _backGroundView.layer.cornerRadius = 5;
    
    [self selectButton:_allDeviceButton];
}

- (void)selectButton:(UIButton *)button{
    [_allDeviceButton setBackgroundImage:[UIImage imageNamed:@"RegisterFisihed2.png"] forState:UIControlStateNormal];
    [_mineDeviceButton setBackgroundImage:[UIImage imageNamed:@"RegisterFisihed2.png"] forState:UIControlStateNormal];
    [_frienDeviceButton setBackgroundImage:[UIImage imageNamed:@"RegisterFisihed2.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"RegisterFisihed1.png"] forState:UIControlStateNormal];
    [self setValue:@(button.tag-100) forKey:@"selectedIndex"];
}

- (IBAction)click_button:(UIButton *)sender {
    [self selectButton:sender];
}
@end
