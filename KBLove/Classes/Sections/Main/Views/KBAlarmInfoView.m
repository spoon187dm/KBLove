//
//  KBAlarmInfoView.m
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBAlarmInfoView.h"

@interface KBAlarmInfoView()



@end

@implementation KBAlarmInfoView

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setupView];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UILabel *titileLabel = [UILabel labelWithFrame:CGRectMake(80, 5, 200, 30) text:@"title" font:15];
    titileLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *contentLabel = [UILabel labelWithFrame:CGRectMake(80, 5+30+5, 200, 30) text:@"content" font:15];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *timeLabel = [UILabel labelWithFrame:CGRectMake(kScreenWidth-100-10, 5, 100, 30) text:@"20:20" font:15];
    timeLabel.textAlignment = NSTextAlignmentRight;
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 5, 60, 60)];
    headImageView.backgroundColor = [UIColor greenColor];
    
    UIImageView *selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    selectImageView.center = CGPointMake(12, self.height/2);
    selectImageView.backgroundColor = [UIColor clearColor];
    selectImageView.layer.masksToBounds = YES;
    selectImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    selectImageView.layer.borderWidth = 1;
    selectImageView.layer.cornerRadius = selectImageView.width/2;
//    selectImageView.hidden = YES;
    
    [self addSubview:titileLabel];
    [self addSubview:contentLabel];
    [self addSubview:timeLabel];
    [self addSubview:headImageView];
    [self addSubview:selectImageView];
    
    _alarmImageView = headImageView;
    _alarmTypeLabel = titileLabel;
    _alarmLocationLabel = contentLabel;
    _alarmTImeLabel = timeLabel;
    _selectCicleImageView = selectImageView;
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)setMySelected:(BOOL)selected{
    if (selected) {
        _selectCicleImageView.backgroundColor = [UIColor whiteColor];
    }else{
        _selectCicleImageView.backgroundColor = [UIColor clearColor];
    }
}

@end
