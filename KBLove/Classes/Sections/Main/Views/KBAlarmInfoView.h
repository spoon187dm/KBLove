//
//  KBAlarmInfoView.h
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBAlarmInfoView : UIView

@property (nonatomic, assign) BOOL isChecked;


@property (nonatomic, strong) UIImageView *alarmImageView;
@property (nonatomic, strong) UILabel *alarmTypeLabel;
@property (nonatomic, strong) UILabel *alarmLocationLabel;
@property (nonatomic, strong) UILabel *alarmTImeLabel;
@property (nonatomic, strong) UIImageView *selectCicleImageView;
- (void)setMySelected:(BOOL)selected;

//- (void)startMyEdit:(BOOL)edit;

@end
