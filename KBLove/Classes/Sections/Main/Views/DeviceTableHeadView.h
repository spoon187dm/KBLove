//
//  DeviceTableHeadView.h
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceTableHeadView : UIView

@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *allDeviceButton;
@property (weak, nonatomic) IBOutlet UIButton *mineDeviceButton;
@property (weak, nonatomic) IBOutlet UIButton *frienDeviceButton;

@property (nonatomic, assign) NSInteger selectedIndex;
- (IBAction)click_button:(UIButton *)sender;

@end
