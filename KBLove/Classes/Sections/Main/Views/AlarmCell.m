//
//  AlarmCell.m
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AlarmCell.h"

@implementation AlarmCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    //    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:0.000 green:0.481 blue:0.519 alpha:1.000];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

- (UIView *)ViewForCellContent{
    
//    DeviceInfoView *infoView = [[[NSBundle mainBundle]loadNibNamed:@"DeviceInfoView" owner:self options:nil] lastObject];
//    infoView.frame = self.bounds;
//    infoView.backgroundColor = SYSTEM_COLOR;
//    
    return nil;
}

- (UIView *)menuViewForMenuCount:(NSInteger)count{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(320 - 80*count, 0, 80*count, self.frame.size.height);
    view.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < count; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        menuBtn.frame = CGRectMake(80*i, 0, 80, 100);
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:i] objectForKey:@"stateNormal"]]] forState:UIControlStateNormal];
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:i] objectForKey:@"stateHighLight"]]] forState:UIControlStateHighlighted];
        [view addSubview:menuBtn];
    }
    
    return view;
}

- (void)setData:(KBAlarm *)alarm{
//    DeviceInfoView *view = (DeviceInfoView *)self.cellView;
//    view.deveiceNameLabel.text = devices.name;
//    view.deviceSnLabel.text = devices.sn;
//    view.deviceLocationLabel.text = @"";
//    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
//    [formate setDateFormat:@"hh-mm"];
//    NSDate *dateString = [NSDate dateWithTimeIntervalSince1970:[devices.devicesStatus.systime floatValue]];
//    view.timeLabel.text = [formate stringFromDate:dateString];
//    
    
}

@end
