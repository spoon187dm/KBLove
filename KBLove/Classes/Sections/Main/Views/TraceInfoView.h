//
//  TraceInfoView.h
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraceInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *startPlaceLabel;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *endPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;


@property (weak, nonatomic) IBOutlet UILabel *travelDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelLastTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *locusListView;
- (IBAction)locusListViewSearchButtonClick:(id)sender;
- (IBAction)locusListViewClearButtonClick:(id)sender;

@end
