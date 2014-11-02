//
//  TraceInfoView.h
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraceInfoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *customHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelDistanceLabel;
@end
