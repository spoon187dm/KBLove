//
//  TraceCell.m
//  KBLove
//
//  Created by Ming on 14-11-21.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TraceCell.h"
#import <UIImageView+AFNetworking.h>
#import "TraceInfoView.h"
#import "KBTracePart.h"

@implementation TraceCell

{
    TraceInfoView *infoView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)createImageView
{
    self.bottomImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, kScreenWidth, 135)];
    [self.contentView insertSubview:self.bottomImageview atIndex:0];
}

-(void)addLocusListViewSwipe
{    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeClick:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [infoView.locusListView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeClick:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [infoView.locusListView addGestureRecognizer:rightSwipe];
}

-(void)swipeClick:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [UIView animateWithDuration:0.3 animations:^{
            infoView.locusListView.frame = CGRectMake(-160, 0, kScreenWidth, 65);
            selectBlock(YES);
            }];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [UIView animateWithDuration:0.3 animations:^{
            infoView.locusListView.frame = CGRectMake(0, 0, kScreenWidth, 65);
            selectBlock(NO);
        }];
    }
}

- (void)setUpViewWithModel:(KBTracePart *)part selectedBlock:(void (^)(BOOL))block{
    
    infoView = [[[NSBundle mainBundle] loadNibNamed:@"TraceInfoView" owner:self options:nil] lastObject];
    [self.contentView addSubview:infoView];
    
    [self addLocusListViewSwipe];
    
    [self createImageView];

    selectBlock = [block copy];

//        infoView.startPlaceLabel.text = part.startSpot.addr;
//        infoView.endPlaceLabel.text = part.endSpot.addr;
//    
//        infoView.startTimeLabel.text = [NSString stringFromDateNumber:part.startTime];
//        infoView.endTimeLabel.text = [NSString stringFromDateNumber:part.endTime];
//
//        infoView.travelDistanceLabel.text = [NSString stringWithFormat:@"%@ km",part.distance];
//        float traveltravel = (-[part.endTime floatValue]+[part.startTime floatValue])/1000.0;
//        traveltravel /=60.0*60.0;
//        infoView.travelLastTimeLabel.text = [NSString stringWithFormat:@"%.1f 小时",traveltravel];
}

@end
