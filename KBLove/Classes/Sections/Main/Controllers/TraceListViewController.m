//
//  TraceListViewController.m
//  KBLove
//
//  Created by Ming on 14-11-20.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TraceListViewController.h"
#import "TraceCell.h"
#import "KBDeviceManager.h"
#import "TableRefresh.h"
#import "TrackerReplayViewController.h"
#import "DatePickerView.h"

@interface TraceListViewController ()

{
    NSMutableArray *_dataArray;
    UIButton *selectAllbutton;
    UIView *searchView;
    UIView *pickerViewbgView;
}

@end

@implementation TraceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpView];
    
//    __weak typeof(self) weakSelf = self;
//    [self.tableView addHeaderWithCallback:^{
//        [weakSelf loadData];
//    }];
    
//    [self.tableView headerBeginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication].keyWindow addSubview:selectAllbutton];
    
    [self createSearchView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [selectAllbutton removeFromSuperview];
}

#pragma mark -
#pragma mark View 操作

- (void)setUpView{
    selectAllbutton=[UIButton buttonWithFrame:CGRectMake(0, kScreenHeight-45, kScreenWidth, 45) title:@"显示全部轨迹" target:self Action:@selector(click_showAllTracker)];
    [selectAllbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectAllbutton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"总_02.png"]]];
}

-(void)createSearchView
{
    searchView = [[UIView alloc] init];
    searchView.frame = CGRectMake(0, 64, kScreenWidth * 1.5, 0);
    searchView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"总_02.png"]];
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 8 + i*25, 60, 25)];
        switch (i) {
            case 0:
                label.text = @"起始时间";
                break;
            case 1:
                label.text = @"结束时间";
                break;
                
            default:
                break;
        }
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        [searchView addSubview:label];
    }
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 8 + i*25, 90, 25);
        NSString *title;
        switch (i) {
            case 0:
                title = @"2014-08-16";
                break;
            case 1:
                title = @"1992-12-26";
                break;
                
            default:
                break;
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 1;
        [button addTarget:self action:@selector(ymdButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //        button setBackgroundImage:[UIImage imageNamed:] forState:<#(UIControlState)#>
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [searchView addSubview:button];
    }
    
    for ( int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = button.frame = CGRectMake(200, 8 + i*25, 50, 25);
        NSString *title;
        switch (i) {
            case 0:
                title = @"10:30";
                break;
            case 1:
                title = @"12:00";
                break;
                
            default:
                break;
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i + 100;
        [button addTarget:self action:@selector(hmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:button];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth*0.8 , 12, 40, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"data_search.png"] forState:UIControlStateNormal];
    [searchView addSubview:button];
    
    [self.view addSubview:searchView];
    
    [self.view insertSubview:searchView atIndex:0];
}

-(void)ymdButtonClick:(UIButton *)button
{
    [self createPickerViewbgView];
    DatePickerView *picker = [[DatePickerView alloc] init];
    [picker setType:YMD dateBlock:^(NSArray *dateArray) {
        [pickerViewbgView removeFromSuperview];
        NSString *title = [NSString stringWithFormat:@"%@-%@-%@",dateArray[0],dateArray[1],dateArray[2]];
        [button setTitle:title forState:UIControlStateNormal];
    }];
    [self.view addSubview:picker];
}

-(void)hmButtonClick:(UIButton *)button
{
    [self createPickerViewbgView];
    DatePickerView *picker = [[DatePickerView alloc] init];
    [picker setType:HM dateBlock:^(NSArray *dateArray) {
        [pickerViewbgView removeFromSuperview];
        NSString *title = [NSString stringWithFormat:@"%@:%@",dateArray[0],dateArray[1]];
        [button setTitle:title forState:UIControlStateNormal];
    }];
    [self.view addSubview:picker];
}

-(void)createPickerViewbgView
{
    pickerViewbgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    pickerViewbgView.backgroundColor = [UIColor blackColor];
    pickerViewbgView.alpha = 0.5;
    [self.view addSubview:pickerViewbgView];
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

//- (void)deleteCell:(TableMenuCell *)cell{
//    
//}

- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_home:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)click_search:(id)sender {
    static BOOL isShowSearch = YES;
    if (isShowSearch) {
        isShowSearch = !isShowSearch;
        [UIView animateWithDuration:0.3 animations:^{
            searchView.frame = CGRectMake(0, 64, kScreenWidth  *1.5, 64);
            self.tableView.frame = CGRectMake(0, 64 * 2, kScreenWidth, kScreenHeight - 45 - 64 * 2);
        } completion:^(BOOL finished) {
        }];
    } else {
        isShowSearch = !isShowSearch;
        [UIView animateWithDuration:0.3 animations:^{
            [UIView animateWithDuration:0.3 animations:^{
                searchView.frame = CGRectMake(0, 64, kScreenWidth * 1.5, 0);
                self.tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 45 - 64);
            }];
        } completion:^(BOOL finished) {
//            searchView.hidden = YES;
        }];
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count;
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"alarmcell";
    
    TraceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[TraceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
        KBTracePart *part = _dataArray[indexPath.row];
        [cell setUpViewWithModel:part selectedBlock:^(BOOL isSelected) {
            self.isSelected = isSelected;
        }];
    cell.bottomImageview.image = [UIImage imageNamed:@"bj.png"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSelected) {
        return;
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

@end
