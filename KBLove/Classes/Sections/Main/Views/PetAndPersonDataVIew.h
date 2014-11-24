//
//  PetAndPersonDataVIew.h
//  KBLove
//
//  Created by qianfeng on 14-11-24.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLPieView.h"

@interface PetAndPersonDataVIew : UIView
//折线图
@property (strong, nonatomic) IBOutlet UIView *lineChartVIew;
//饼状图
@property (strong, nonatomic) IBOutlet WLPieView *pieVIew;
//昨日运动量
@property (strong, nonatomic) IBOutlet UILabel *yesterdayLabel;
//30日平均运动量
@property (strong, nonatomic) IBOutlet UILabel *averageLabel;


-(void)setupViewLineChart:(NSArray *)lineData andPieCurrent:(NSNumber *)current andYesterday:(NSString *)yesterdayLabel andAverage:(NSString *)averageLabel;
@end
