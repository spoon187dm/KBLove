//
//  PetAndPersonDataViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "PetAndPersonDataViewController.h"
#import "CKCalendarView.h"
#import "CKCalendarDelegate.h"

@interface PetAndPersonDataViewController ()<CKCalendarViewDelegate,PNChartDelegate>
{
    CKCalendarView * calendarView;
    NSString * dateString;
    WLPieView * wlPieView;
}
@end

@implementation PetAndPersonDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //画图
    wlPieView = [[WLPieView alloc] initWithFrame:_piePngView.bounds andTotal:@(100) andCurrent:@(89) andClockwise:NO andShadow:YES andBgColor:[UIColor orangeColor] andStart:-90.00f andEnd:-89.99f andredius:(_piePngView.bounds.size.width-15)/2 andWidth:13 andLabel:YES];
    
    [wlPieView strokeChart];
    
    [_piePngView addSubview:wlPieView];
    [self changeNavigationBarFromImage:@"数据01"];
    
    PNLineChart * lineChat = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 20, _countPngView.width, _countPngView.height-20)];
    lineChat.backgroundColor = [UIColor clearColor];
    [lineChat setYLabelFormat:@"%1.0f"];
    [lineChat setXLabels:@[@"00:00",@"04:00",@"08:00",@"12:00",@"16:00",@"20:00",@"24:00"]];
    
    
    lineChat.showCoordinateAxis = YES;
    
    NSArray *arr = @[@20, @160, @126, @262, @186, @127, @176];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.itemCount = lineChat.xLabels.count;
    data01.inflexionPointStyle = PNLineChartPointStyleCycle;
    data01.color = PNBlue;
    data01.getData = ^(NSUInteger index){
        CGFloat fvaue = [arr[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:fvaue];
    };
    
    
    
    lineChat.chartData = @[data01];
    [lineChat strokeChart];
    
    lineChat.delegate = self;

    [_countPngView addSubview:lineChat];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back_btn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)home_btn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)calendarButton:(id)sender {
    
    
    calendarView = [[CKCalendarView alloc] init];
    calendarView.delegate = self;
    [calendarView setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] animated:NO];
    [calendarView setDisplayMode:CKCalendarViewModeMonth animated:NO];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake((_pieView.size.width-calendarView.size.width)/2, 0, calendarView.size.width, _pieView.width)];
    
    [view addSubview:calendarView];

    [UIView animateWithDuration:2 animations:^{
        _calendar.hidden = YES;
        _piePngView.hidden = YES;
        
        [_pieView addSubview:view];
        
    }];
   
    
}


#pragma mark-CKCalendarDelegate
- (void)calendarView:(CKCalendarView *)CalendarView didSelectDate:(NSDate *)date
{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"%@",[formatter stringFromDate:date]);
    dateString = [formatter stringFromDate:date];
    
    [UIView animateWithDuration:2 animations:^{
        _calendar.hidden = NO;
        _piePngView.hidden = NO;
        
        [calendarView removeFromSuperview];
        
    }];
    
    
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex
{
    
}
-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex
{
    
}
-(void)userClickedOnBarCharIndex:(NSInteger)barIndex
{
    
}

@end
