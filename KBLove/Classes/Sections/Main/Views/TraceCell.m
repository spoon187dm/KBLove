//
//  TraceCell.m
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TraceCell.h"
#import <UIImageView+AFNetworking.h>
#import "TraceInfoView.h"
#import "KBTracePart.h"
@implementation TraceCell

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
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}

- (UIView *)ViewForCellContent{
    
    TraceInfoView *infoView = [[[NSBundle mainBundle]loadNibNamed:@"TraceInfoView" owner:self options:nil] lastObject];
    infoView.frame = self.bounds;
    self.backgroundColor = [UIColor clearColor];
    return infoView;
}

- (UIView *)menuViewForMenuCount:(NSInteger)count{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(320 - 80*count, 0, 80, 100);
    view.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < 2; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        menuBtn.frame = CGRectMake(0, 50*i, 80, 50);
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:0] objectForKey:@"stateNormal"]]] forState:UIControlStateNormal];
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:0] objectForKey:@"stateHighLight"]]] forState:UIControlStateHighlighted];
        [view addSubview:menuBtn];
    }
    
    return view;
}

- (void)configWithData:(NSIndexPath *)indexPath menuData:(NSArray *)menuData cellFrame:(CGRect)cellFrame{
    [super configWithData:indexPath menuData:menuData cellFrame:cellFrame];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 100)];
    [imageview setBackgroundColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:imageview];
}

- (void)setUpViewWithModel:(KBTracePart *)part{
    TraceInfoView *view = (TraceInfoView *)self.cellView;
    view.startPlaceLabel.text = part.startSpot.addr;
    view.endPlaceLabel.text = part.endSpot.addr;
    
    view.startTimeLabel.text = [NSString stringFromDateNumber:part.startTime];
    view.endTimeLabel.text = [NSString stringFromDateNumber:part.endTime];
    
    view.travelDistanceLabel.text = [NSString stringWithFormat:@"%@ km",part.distance];
    float traveltravel = (-[part.endTime floatValue]+[part.startTime floatValue])/1000.0;
    traveltravel /=60.0*60.0;
    view.travelLastTimeLabel.text = [NSString stringWithFormat:@"%.1f 小时",traveltravel];
}

@end
