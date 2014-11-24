//
//  PetAndPersonDataVIew.m
//  KBLove
//
//  Created by qianfeng on 14-11-24.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "PetAndPersonDataVIew.h"
#import "WLPieView.h"

@implementation PetAndPersonDataVIew

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setupViewLineChart:(NSArray *)lineData andPieCurrent:(NSNumber *)current andYesterday:(NSString *)yesterdayLabel andAverage:(NSString *)averageLabel
{
    //画饼状图
    WLPieView * wlPieView = [[WLPieView alloc] initWithFrame:self.pieVIew.bounds andTotal:@(100) andCurrent:@(89) andClockwise:NO andShadow:YES andBgColor:[UIColor orangeColor] andStart:-90.00f andEnd:-89.99f andredius:(self.pieVIew.bounds.size.width-15)/2 andWidth:13 andLabel:YES];
    
    [wlPieView strokeChart];
    
    [self.pieVIew addSubview:wlPieView];
  
    
   //画折线图
    PNLineChart * lineChat = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 20, self.lineChartVIew.width, self.lineChartVIew.height-20)];
    lineChat.backgroundColor = [UIColor clearColor];
    [lineChat setYLabelFormat:@"%1.0f"];
    [lineChat setXLabels:@[@"00:00",@"04:00",@"08:00",@"12:00",@"16:00",@"20:00",@"24:00"]];
    
    
    lineChat.showCoordinateAxis = YES;
    
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.itemCount = lineChat.xLabels.count;
    data01.inflexionPointStyle = PNLineChartPointStyleCycle;
    data01.color = PNBlue;
    data01.getData = ^(NSUInteger index){
        CGFloat fvaue = [lineData[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:fvaue];
    };
    lineChat.chartData = @[data01];
    [lineChat strokeChart];
    [self.lineChartVIew addSubview:lineChat];
    //昨日运动量
    self.yesterdayLabel.text = yesterdayLabel;
    //30天平均运动量
    self.averageLabel.text = averageLabel;
}
@end
