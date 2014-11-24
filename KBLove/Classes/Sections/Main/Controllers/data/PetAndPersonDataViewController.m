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
#import "PetAndPersonDataVIew.h"

@interface PetAndPersonDataViewController ()<CKCalendarViewDelegate,PNChartDelegate>
{
    CKCalendarView * calendarView;
    NSString * dateString;
    
}

@end

@implementation PetAndPersonDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self changeNavigationBarFromImage:@"数据01"];
  
    
     PetAndPersonDataVIew * _ppView = [[[NSBundle mainBundle] loadNibNamed:@"PetAndPersonDataVIew" owner:self options:nil] lastObject];
    PetAndPersonDataVIew * _ppView1 = [[[NSBundle mainBundle] loadNibNamed:@"PetAndPersonDataVIew" owner:self options:nil] lastObject];
    PetAndPersonDataVIew * _ppView2 = [[[NSBundle mainBundle] loadNibNamed:@"PetAndPersonDataVIew" owner:self options:nil] lastObject];
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

- (IBAction)calendarButton:(id)sender {
    
    
    calendarView = [[CKCalendarView alloc] init];
    calendarView.delegate = self;
    [calendarView setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] animated:NO];
    [calendarView setDisplayMode:CKCalendarViewModeMonth animated:NO];
    
    
    
}


#pragma mark-CKCalendarDelegate
- (void)calendarView:(CKCalendarView *)CalendarView didSelectDate:(NSDate *)date
{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"%@",[formatter stringFromDate:date]);
    dateString = [formatter stringFromDate:date];
    
    
    
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
