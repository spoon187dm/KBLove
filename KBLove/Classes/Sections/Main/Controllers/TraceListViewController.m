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
#import "BMapKit.h"
#import <MAMapKit/MAMapKit.h>
#import "GaoDeMap_TrackerReplayViewController.h"

@interface TraceListViewController ()

{
    NSMutableArray *_dataArray;
    UIButton *selectAllbutton;
    UIView *searchView;
    UIView *pickerViewbgView;
    UITableView *_tableView;
    NSString *startTimeTitleYMD;
    NSString *startTimeTitleHM;
    NSString *endTimeTitleYMD;
    NSString *endTimeTitleHM;
    BOOL isShowSearch;
    
    long long           _currentTime;

}

@end

@implementation TraceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.view addSubview:selectAllbutton];
    
    [self createSearchView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    startTimeTitleYMD = @"2014-11-27";
    startTimeTitleHM = @"10:30";
    endTimeTitleYMD = @"2014-11-28";
    endTimeTitleHM = @"12:00";
    
    searchView = [[UIView alloc] init];
    searchView.frame = CGRectMake(0, 64, kScreenWidth * 1.5, 64);
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
                title = startTimeTitleYMD;
                break;
            case 1:
                title = endTimeTitleYMD;
                break;
                
            default:
                break;
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 100 + i;
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
                title = startTimeTitleHM;
                break;
            case 1:
                title = endTimeTitleHM;
                break;
                
            default:
                break;
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 1000 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(hmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:button];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth*0.8 , 12, 40, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"data_search.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:button];
    
    [self.view insertSubview:searchView atIndex:0];
}

-(void)ymdButtonClick:(UIButton *)button
{
    [self createPickerViewbgView];
    DatePickerView *picker = [[DatePickerView alloc] init];
    [picker setType:YMD dateBlock:^(NSArray *dateArray) {
        [pickerViewbgView removeFromSuperview];
        if (100 == button.tag) {
            startTimeTitleYMD = [NSString stringWithFormat:@"%@-%@-%@",dateArray[0],dateArray[1],dateArray[2]];
            [button setTitle:startTimeTitleYMD forState:UIControlStateNormal];
        } else {
            endTimeTitleYMD = [NSString stringWithFormat:@"%@-%@-%@",dateArray[0],dateArray[1],dateArray[2]];
            [button setTitle:endTimeTitleYMD forState:UIControlStateNormal];
        }
    }];
    [self.view addSubview:picker];
}

-(void)hmButtonClick:(UIButton *)button
{
    [self createPickerViewbgView];
    DatePickerView *picker = [[DatePickerView alloc] init];
    [picker setType:HM dateBlock:^(NSArray *dateArray) {
        [pickerViewbgView removeFromSuperview];
        if (1000 == button.tag) {
            startTimeTitleHM = [NSString stringWithFormat:@"%@:%@",dateArray[0],dateArray[1]];
            [button setTitle:startTimeTitleHM forState:UIControlStateNormal];
        } else {
            endTimeTitleHM = [NSString stringWithFormat:@"%@:%@",dateArray[0],dateArray[1]];
            [button setTitle:endTimeTitleHM forState:UIControlStateNormal];
        }
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
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];

    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",startTimeTitleYMD,startTimeTitleHM]];
    NSDate *current = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",endTimeTitleYMD,endTimeTitleHM]];
    long form = [date timeIntervalSince1970];
    long to = [current timeIntervalSince1970];
    [KBDeviceManager getDevicePart:_device.sn from:form to:to block:^(BOOL isSuccess, id result) {
        _dataArray = [result mutableCopy];
        NSLog(@"qqqq%@",result);
        [_tableView reloadData];
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
    if (!isShowSearch) {
        isShowSearch = !isShowSearch;
        [UIView animateWithDuration:0.3 animations:^{
//            searchView.frame = CGRectMake(0, 64, kScreenWidth  *1.5, 64);
            _tableView.frame = CGRectMake(0, 64 * 2, kScreenWidth, kScreenHeight - 45 - 64 * 2);
        } completion:^(BOOL finished) {
        }];
    } else {
        isShowSearch = !isShowSearch;
            [UIView animateWithDuration:0.3 animations:^{
//                searchView.frame = CGRectMake(0, 64, kScreenWidth * 1.5, 0);
                _tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 45 - 64);
            }];
    }
}

-(void)searchClick
{
    isShowSearch = !isShowSearch;
    [UIView animateWithDuration:0.3 animations:^{
        //                searchView.frame = CGRectMake(0, 64, kScreenWidth * 1.5, 0);
        _tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 45 - 64);
    }];
    [self loadData];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
//    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"alarmcell";
    
    TraceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[TraceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    KBTracePart *part = _dataArray[indexPath.row];
    cell.device_sn = self.device.sn;
    [cell setUpViewWithModel:part selectedBlock:^(int isSelected) {
        self.isSelected += isSelected;
    }];
    
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 135)];
        cell.baidu_MapView = mapView;
        [cell.bottomImageview addSubview:mapView];
        
    }else{
        
    MAMapView *mapView=[[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 135)];
    [cell.bottomImageview addSubview:mapView];
    cell.gaode_MapView = mapView;
    [cell.bottomImageview addSubview:mapView];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 != self.isSelected) {
        return;
    }

    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        
        TrackerReplayViewController *tracker=[[TrackerReplayViewController alloc]initWithNibName:@"ReplayMapView" bundle:nil];
        tracker.dataarray=_dataArray;
        tracker.selectIndex=indexPath.row;
        
        KBTracePart *part = _dataArray[indexPath.row];
        NSLog(@"%@",part.startSpot.receive);
        tracker.startTime =[part.endSpot.receive longLongValue];
        tracker.endTime =[part.startSpot.receive longLongValue];
        tracker.device_sn=self.device.sn;
        
        [self.navigationController pushViewController:tracker animated:YES];
        
    }else{
        
        GaoDeMap_TrackerReplayViewController *tracker=[[GaoDeMap_TrackerReplayViewController alloc] init];
        tracker.dataarray=_dataArray;
        tracker.selectIndex=indexPath.row;
        
        KBTracePart *part = _dataArray[indexPath.row];
        NSLog(@"%@",part.startSpot.receive);
        tracker.startTime =[part.endSpot.receive longLongValue];
        tracker.endTime =[part.startSpot.receive longLongValue];
        tracker.device_sn=self.device.sn;
        
        [self.navigationController pushViewController:tracker animated:YES];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addStartAndEnd
{
//    if (_statusArray.count <= 0 && _allReplayInfo.count <= 0) {
//        return;
//    }
    
    BMKGeoPoint start;
    BMKGeoPoint end;
    
//    _startStatus = [_statusArray lastObject];
//    start = _startStatus.point;
//    _endStatus = [_statusArray objectAtIndex:0];
//    end = _endStatus.point;
//    
//    
//    [ZWL_MapUtils adjustMapCenterAndSpan:_mapView statusInfo:_statusArray];
//    //    }
//    
//    if (_startPoint) {
//        [_mapView removeAnnotation:_startPoint];
//    }
//    
//    _startPoint = [[BMKPointAnnotation alloc] init];
//    _startPoint.coordinate =[ZWL_MapUtils geoPoint2Coordinate2D:start];
//    _startPoint.title= [NSString stringWithFormat:@"%f %f",_startPoint.coordinate.latitude,_startPoint.coordinate.longitude];
//    _startPoint.subtitle=@"2sdvc24";
//    [_mapView addAnnotation:_startPoint];
//    
//    if (_endPoint) {
//        [_mapView removeAnnotation:_endPoint];
//    }
//    
//    _endPoint = [[BMKPointAnnotation alloc] init];
//    
//    _endPoint.subtitle=@"sjdfklwje";
//    _endPoint.coordinate =[ZWL_MapUtils geoPoint2Coordinate2D:end];
//    _endPoint.title=[NSString stringWithFormat:@"%f %f",_endPoint.coordinate.latitude,_endPoint.coordinate.longitude];
//    [_mapView addAnnotation:_endPoint];
}

-(void) addTrackPath
{
//    _lastPoint = _startStatus.point;
//    
//    [_mapView removeOverlay:_trackPath];
//    [_mapView removeOverlays:_allTrackPath];
//    [_mapView removeOverlays:_colorsTrack];
//    
//    [_allTrackPath removeAllObjects];
//    
//    [_colorsTrack removeAllObjects];
//    [_redTrack removeAllObjects];
//    [_greenTrack removeAllObjects];
//    [_yellowTrack removeAllObjects];
    
//    if (_isViewAllTrack) {
//        [_mapView addOverlays:_allTrackPath];
//        
//    } else {
//        NSInteger size = _statusArray.count;
//        CLLocationCoordinate2D* points = new CLLocationCoordinate2D[size];
//        
//        for(int idx = (int)size - 1; idx >= 0; idx--)
//        {
//            CCDeviceStatus* current = [_statusArray objectAtIndex:idx];
//            points[idx] = [ZWL_MapUtils geoPoint2Coordinate2D:current.point];
//        }
//        //添加
//        _trackPath = [BMKPolyline polylineWithCoordinates:points count:size];
//        [_mapView addOverlay:_trackPath];
//        
//    }
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
