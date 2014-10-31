//
//  DevecieInfoView.m
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DeviceInfoView.h"

@implementation DeviceInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{

    _deviceImageView.layer.masksToBounds = YES;
    _deviceImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _deviceImageView.layer.borderWidth = 1;
    _deviceImageView.layer.cornerRadius = _deviceImageView.width/2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
