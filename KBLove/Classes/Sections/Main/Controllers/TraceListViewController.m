//
//  TraceListViewController.m
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TraceListViewController.h"
#import "TraceCell.h"
#import "KBDeviceManager.h"
#import "TableRefresh.h"
#import "TrackerReplayViewController.h"

@interface TraceListViewController (){
    NSMutableArray *_dataArray;
    UIButton *selectAllbutton;
}

@end

@implementation TraceListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAllowScroll = TableIsForbiddenScroll;
    [self replaceSelfViewToNormal];

    
    [self setUpView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        [weakSelf loadData];
    }];
    [self.tableView headerBeginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication].keyWindow addSubview:selectAllbutton];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [selectAllbutton removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark View 操作

- (void)setUpView{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]]];
    [self changeNavigationBarFromImage:@"bg1"];
    
    selectAllbutton=[UIButton buttonWithFrame:CGRectMake(5, kScreenHeight-45, kScreenWidth-10, 45) title:@"显示全部轨迹" target:self Action:@selector(click_showAllTracker)];
}


#pragma mark -
#pragma mark Data 操作

- (void)loadData{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *current = [NSDate date];
    NSString *currentDate = [formatter stringFromDate:current];
    
    NSDate *date = [formatter dateFromString:currentDate];
    
    long form = [date timeIntervalSince1970];
    long to = [current timeIntervalSince1970];
    [KBDeviceManager getDevicePart:_device.sn from:form to:to block:^(BOOL isSuccess, id result) {
        _dataArray = [result mutableCopy];
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    }];
}

#pragma mark -
#pragma mark click 点击事件
-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum{
    NSLog(@"你选择了第 %ld 行第 %ld 个菜单",cellIndexNum+1,menuIndexNum+1);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"你选择了第 %ld 行第 %ld 个菜单",cellIndexNum+1,menuIndexNum+1] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

//显示全部轨迹信息
-(void)click_showAllTracker
{
    TrackerReplayViewController *tracker=[[TrackerReplayViewController alloc]initWithNibName:@"ReplayMapView" bundle:nil];
    tracker.dataarray=_dataArray;
    
    KBTracePart *endpart = [_dataArray firstObject];
    KBTracePart *beginpart=[_dataArray lastObject];
    tracker.endTime=[endpart.startSpot.receive longLongValue];
    tracker.startTime=[beginpart.endSpot.receive longLongValue];
    tracker.device_sn=self.device.sn;
    tracker.isAllPlayTracker=YES;
    [self.navigationController pushViewController:tracker animated:YES];
    
}

- (void)deleteCell:(TableMenuCell *)cell{
    
}

- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_home:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
//    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"alarmcell";
    
    TraceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[TraceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.menuActionDelegate = self;
    }
    NSMutableArray *menuImgArr = [[NSMutableArray alloc] init];
    for (int i = 0; i <1; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"icon_trash",@"stateNormal",@"icon_trash",@"stateHighLight", nil];
        [menuImgArr addObject:dic];
    }
    
    KBTracePart *part = _dataArray[indexPath.row];
    [cell configWithData:indexPath menuData:menuImgArr cellFrame:CGRectMake(0, 0, 320, 200)];
    [cell setUpViewWithModel:part];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isAllowScroll != TableIsScroll && self.isEditing) {
        return;
    }
    if (self.isAllowScroll == TableIsScroll && self.isEditing) {
        if (self.editingCellNum != -1 && indexPath.row == self.editingCellNum) {
            return;
        }
    }
    TrackerReplayViewController *tracker=[[TrackerReplayViewController alloc]initWithNibName:@"ReplayMapView" bundle:nil];
    tracker.dataarray=_dataArray;
    tracker.selectIndex=indexPath.row;
    
    KBTracePart *part = _dataArray[indexPath.row];
    NSLog(@"%@",part.startSpot.receive);
    tracker.startTime=[part.endSpot.receive longLongValue];
    tracker.endTime=[part.startSpot.receive longLongValue];
    tracker.device_sn=self.device.sn;
    [self.navigationController pushViewController:tracker animated:YES];
    
}



@end
