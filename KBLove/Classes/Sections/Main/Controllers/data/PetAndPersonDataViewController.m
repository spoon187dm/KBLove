//
//  PetAndPersonDataViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "PetAndPersonDataViewController.h"
#import "PetAndPersonDataVIew.h"


@interface PetAndPersonDataViewController ()<PNChartDelegate,CalendarDelegate>
{
    PetAndPersonDataVIew *_ppView;
    PetAndPersonDataVIew * _ppView1;
    PetAndPersonDataVIew * _ppView2;
    
    int _pieViewHidden;
}

@end



@implementation PetAndPersonDataViewController

/**
 *  创建日历
 */
- (void)createCalendar
{
    CalendarView *calendar = [[CalendarView alloc] initWithStartDay:startMonday];
    calendar.frame = CGRectMake(50, 160, self.view.bounds.size.width-100, 10);
    [calendar setDayOfWeekTextColor:[UIColor whiteColor]];  /** 选中字体颜色 */
    
    
    [calendar setTitleColor:[UIColor whiteColor]];   /** 年月字体颜色 */
    [calendar setDateBorderColor:[UIColor clearColor]];
    [calendar setDayOfWeekBottomColor:[UIColor clearColor] topColor:[UIColor clearColor]];/**  周几背景*/
    [calendar setCurrentDateBackgroundColor:[UIColor clearColor]];  /** 当前日期背景色 */
    [calendar setDateBackgroundColor:[UIColor clearColor]];
    [calendar setBackgroundColor:[UIColor clearColor]];
    [calendar setDateTextColor:[UIColor whiteColor]];
    calendar.delegate = self;
    [self.view addSubview:calendar];
    
    calendar.hidden = YES;
    self.calen = calendar;
}

/**
 *  代理事件
 *  获得点击日历的日期
 */
- (void)calendar:(CalendarView *)calendar didSelectDate:(NSDate *)date
{
    NSCalendar *calen = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calen components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSInteger year = dateComponents.year;
    NSInteger month = dateComponents.month;
    NSInteger day = dateComponents.day;
    
    NSLog(@"年-%lu月-%lu日-%lu",year,month,day);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeNavigationBarFromImage:@"数据01"];
    _pieViewHidden = 0;
    
    _ppView = [[[NSBundle mainBundle] loadNibNamed:@"PetAndPersonDataVIew" owner:self options:nil] lastObject];
    _ppView1 = [[[NSBundle mainBundle] loadNibNamed:@"PetAndPersonDataVIew" owner:self options:nil] lastObject];
    _ppView2 = [[[NSBundle mainBundle] loadNibNamed:@"PetAndPersonDataVIew" owner:self options:nil] lastObject];
    NSArray *arr = @[@20, @160, @126, @262, @186, @127, @176];
    [_ppView setupViewLineChart:arr andPieCurrent:@(89) andYesterday:@"930" andAverage:@"1130"];
    _ppView.center = CGPointMake(_ppView.width*0,_ppView.height/2);
    [_petScrollVIew addSubview:_ppView];
    
    
    [_ppView1 setupViewLineChart:arr andPieCurrent:@(89) andYesterday:@"930" andAverage:@"1130"];
    _ppView.center = CGPointMake(_ppView1.width*3/2, _ppView1.height/2);
    [_petScrollVIew addSubview:_ppView1];
    
    [_ppView2 setupViewLineChart:arr andPieCurrent:@(89) andYesterday:@"930" andAverage:@"1130"];
    _ppView2.center = CGPointMake(_ppView2.width*5/2, _ppView2.height/2);
    [_petScrollVIew addSubview:_ppView2];
    
    [self createCalendar];
    
    
    
    _petScrollVIew.contentSize = CGSizeMake(_ppView.width*3, _petScrollVIew.height);
    
    
    
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

/**
 *  点击打开日历
 */
- (IBAction)calendarButton:(id)sender {
    
    _ppView.pieVIew.alpha = _pieViewHidden;
    _ppView1.pieVIew.alpha = _pieViewHidden;
    _ppView2.pieVIew.alpha = _pieViewHidden;
    
    
    /** 隐藏百分图 */
    if (_pieViewHidden == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            _pieViewHidden = 1;
        }];
        
        /** 显示日历 */
        self.calen.hidden = NO;
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _pieViewHidden = 0;
        }];
        
        /** 隐藏日历 */
        self.calen.hidden = YES;
    }
    
    
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
