//
//  WLPieView.h
//  KBLove
//
//  Created by qianfeng on 14-11-19.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
#import "UICountingLabel.h"


#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface WLPieView : UIView

@property (strong, nonatomic) UICountingLabel *countingLabel;
@property (nonatomic) UIColor *strokeColor;
@property (nonatomic) UIColor *strokeColorGradientStart;
@property (nonatomic) NSNumber *total;
@property (nonatomic) NSNumber *current;
@property (nonatomic) NSNumber *lineWidth;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) PNChartFormatType chartType;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat width;
@property (nonatomic) CAShapeLayer *circle;
@property (nonatomic) CAShapeLayer *circleBG;

-(id)initWithFrame:(CGRect)frame andTotal:(NSNumber *)total andCurrent:(NSNumber *)current andClockwise:(BOOL)clockwise andShadow:(BOOL)hasBackgroundShadow andBgColor:(UIColor *)color andStart:(CGFloat)start andEnd:(CGFloat)end andredius:(CGFloat)radius andWidth:(CGFloat)widthand andLabel:(BOOL)isLabel;
-(void)strokeChart;

@end
