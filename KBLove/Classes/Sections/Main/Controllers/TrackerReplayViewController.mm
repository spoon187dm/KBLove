//
//  TrackerReplayViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TrackerReplayViewController.h"
#import "BMapKit.h"
#import "CCDeviceStatus.h"
#import "ZWL_MapUtils.h"
#import "KBTracePart.h"
#import "ZWL_Utils.h"
#import "ZWL_TimeUtils.h"
#import "ZWL_TimeUtils.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "TrackSearchViewController.h"

@interface TrackerReplayViewController ()

@property (nonatomic, assign) NSInteger speedMode;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger allReplayIndex;
@property (nonatomic, assign) BOOL useSingleColor;

@property (nonatomic, strong) NSMutableArray* allReplayInfo;    // // 查看全部
@property (nonatomic, strong) NSMutableArray* statusArray;      //

@property (nonatomic, assign) long long currentStartTime;
@property (nonatomic, assign) long long currentEndTime;

@property (nonatomic, assign) BOOL hasSetMapZoom;
@property (nonatomic, assign) BOOL pauseForMoveMap;
@property (nonatomic, assign) BOOL pauseBeforeDeactive;
@property (nonatomic, assign) BOOL hasSetup;

@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) dispatch_source_t playTimer;

@property (nonatomic, assign) NSInteger mapZoomLevel;
@end

@implementation TrackerReplayViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isViewAllTrack = NO;
        _colorsTrack = [[NSMutableArray alloc] init];
        _allStayedPoints = [[NSMutableArray alloc] init];
        _redTrack = [[NSMutableArray alloc] init];
        _greenTrack = [[NSMutableArray alloc] init];
        _yellowTrack = [[NSMutableArray alloc] init];
        _statusArray = [[NSMutableArray alloc] init];
        _allTrackPath = [[NSMutableArray alloc] init];
        _playState = STOP;
        _pauseForMoveMap = NO;
        _hasSetMapZoom = NO;
        _pauseBeforeDeactive = NO;
        _hasSetup = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView.delegate=self;
    
    
    [self requestData];
//    [self loadDataOnMap];
    
    [_slider setThumbImage:[UIImage imageNamed:@"未标题-1.png"] forState:UIControlStateNormal];
    [_slider setMinimumValue:0];
    [_slider setMaximumValue:100];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderDidStartSliding:) forControlEvents:UIControlEventTouchDown];
    [_slider addTarget:self action:@selector(sliderDidEndSliding:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStartAndEndTime:_startTime endTime:_endTime];
    
    [self createNav];
}

-(void)createNav
{
    self.navigationItem.title = @"轨迹播放";
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"NVBar_arrow_left.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon_home.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


-(void)requestData
{
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"14" forKey:@"cmd"];
    [dic setObject:[KBUserInfo sharedInfo].token forKey:@"token"];
    [dic setObject:[KBUserInfo sharedInfo].user_id forKey:@"user_id"];
    [dic setObject:self.device_sn forKey:@"device_sn"];
    [dic setObject:[NSNumber numberWithDouble:self.startTime] forKey:@"begin"];
    [dic setObject:[NSNumber numberWithDouble:self.endTime] forKey:@"end"];
    [dic setObject:@"1" forKey:@"page_number"];
    [dic setObject:@"20" forKey:@"page_size"];
    [dic setObject:@"M2616_BD" forKey:@"app_name"];
    //
    [manager GET:Url_GetTrack parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"%@",responseObject);
            NSDictionary *data=(NSDictionary *)responseObject;
            NSArray *data_Array=data[@"track"];
            for (int i=0; i< data_Array.count; i++) {
                CCDeviceStatus * device=[[CCDeviceStatus alloc]init];
                NSString *lngstr=data_Array[i][@"lng"];
                device.lang=[lngstr doubleValue]*1e6;
                device.lat=[data_Array[i][@"lat"] doubleValue]*1e6;
                device.speed=[data_Array[i][@"speed"] floatValue];
                device.receive=[data_Array[i][@"receive"] longLongValue];
                device.sn=data_Array[i][@"deviceSn"];
                device.stayed=[data_Array[i][@"stayed"] floatValue];
                device.heading=[data_Array[i][@"direction"] floatValue];
                BMKGeoPoint point={(int)device.lat,(int)device.lang};
                device.point=point;
                [_statusArray addObject:device];
                
            }
            [self loadDataOnMap];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error :%@",error.localizedDescription);
        
    }];
    
}
-(void) loadDataOnMap
{
    [self reset];

    [self updateStartAndEndTime];

    [self updateSliderPopover:_currentTime];

    [self addAllStayedPoints];
    
    [self addStartAndEnd];

    [self addDevicePoint];

    // 添加轨迹
    [self addTrackPath];
}

-(void) addTrackPath
{
    _lastPoint = _startStatus.point;
    
    [_mapView removeOverlay:_trackPath];
    [_mapView removeOverlays:_allTrackPath];
    [_mapView removeOverlays:_colorsTrack];
    
    [_allTrackPath removeAllObjects];
    
    [_colorsTrack removeAllObjects];
    [_redTrack removeAllObjects];
    [_greenTrack removeAllObjects];
    [_yellowTrack removeAllObjects];
    
    if (_isViewAllTrack) {
        [_mapView addOverlays:_allTrackPath];
        
    } else {
        NSInteger size = _statusArray.count;
        CLLocationCoordinate2D* points = new CLLocationCoordinate2D[size];
        
        for(int idx = (int)size - 1; idx >= 0; idx--)
        {
            CCDeviceStatus* current = [_statusArray objectAtIndex:idx];
            points[idx] = [ZWL_MapUtils geoPoint2Coordinate2D:current.point];
        }
        //添加
        _trackPath = [BMKPolyline polylineWithCoordinates:points count:size];
        [_mapView addOverlay:_trackPath];
        
    }
}

#pragma mark navClick

-(void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightItemClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma  mark  addDevicePoint

-(void) addDevicePoint
{
    _currentPoint = [[BMKPointAnnotation alloc] init];
    CCDeviceStatus* status = [_statusArray lastObject];
    _currentPoint.coordinate = [ZWL_MapUtils geoPoint2Coordinate2D:status.point];
    [_mapView addAnnotation:_currentPoint];
}

#pragma  mark  addStartAndEnd

-(void) addStartAndEnd
{
    if (_statusArray.count <= 0 && _allReplayInfo.count <= 0) {
        return;
    }
    
    BMKGeoPoint start;
    BMKGeoPoint end;
    // 查看全部记录
    //    if (_isViewAllTrack) {
    //        CCSeqReplayInfo* replayInfoStart = [_allReplayInfo lastObject];
    //        CCDeviceStatus* startStatus = [replayInfoStart.statusList lastObject];
    //        start = startStatus.point;
    //
    //        CCSeqReplayInfo* replayInfoEnd = [_allReplayInfo objectAtIndex:0];
    //        CCDeviceStatus* endStatus = [replayInfoEnd.statusList objectAtIndex:0];
    //        end = endStatus.point;
    //
    //        // 缩放地图到合适的尺寸
    //        [self calcCenterPointAll:_allReplayInfo];
    
    //    } else {
    _startStatus = [_statusArray lastObject];
    start = _startStatus.point;
    _endStatus = [_statusArray objectAtIndex:0];
    end = _endStatus.point;
    
    
    [ZWL_MapUtils adjustMapCenterAndSpan:_mapView statusInfo:_statusArray];
    //    }
    
    if (_startPoint) {
        [_mapView removeAnnotation:_startPoint];
    }
    
    _startPoint = [[BMKPointAnnotation alloc] init];
    _startPoint.coordinate =[ZWL_MapUtils geoPoint2Coordinate2D:start];
    _startPoint.title= [NSString stringWithFormat:@"%f %f",_startPoint.coordinate.latitude,_startPoint.coordinate.longitude];
    _startPoint.subtitle=@"2sdvc24";
    [_mapView addAnnotation:_startPoint];
    
    if (_endPoint) {
        [_mapView removeAnnotation:_endPoint];
    }
    
    _endPoint = [[BMKPointAnnotation alloc] init];
    
    _endPoint.subtitle=@"sjdfklwje";
    _endPoint.coordinate =[ZWL_MapUtils geoPoint2Coordinate2D:end];
    _endPoint.title=[NSString stringWithFormat:@"%f %f",_endPoint.coordinate.latitude,_endPoint.coordinate.longitude];
    [_mapView addAnnotation:_endPoint];
}
#pragma  mark  addAllStayedPoints

-(void) addAllStayedPoints
{
    /**
     *  用于多条轨迹情况
     */
    NSInteger size = _allReplayInfo.count;
    if (!_isViewAllTrack || size <= 0) {
        return;
    }
    
    [_mapView removeAnnotations:_allStayedPoints];
    [_allStayedPoints removeAllObjects];
    
    //    for (NSInteger i = size - 1; i > 0; i--) {
    //        CCSeqReplayInfo* replayInfo = [_allReplayInfo objectAtIndex:i];
    //        CCDeviceStatus* deviceStatus = [replayInfo.statusList objectAtIndex:0];
    //
    //        CCStayedPointAnnotation* ann = [[CCStayedPointAnnotation alloc] init];
    //        ann.coordinate = [MapUtils geoPoint2Coordinate2D:deviceStatus.point];
    //        ann.text = [NSString stringWithFormat:@"----%d***", size - i];
    //        ann.status = deviceStatus;
    //        [_allStayedPoints addObject:ann];
    //    }
    
    [_mapView addAnnotations:_allStayedPoints];
}
#pragma  mark updateSliderPopover

-(void) updateSliderPopover:(long long)currTime
{
    //显示文字
    long long currentTime = _currentStartTime + currTime;
    NSString* timeString = [ZWL_TimeUtils getDayAndTime:currentTime];
    [_slider setPopoverText:timeString];
}

#pragma  mark updateStartAndEndTime

-(void) updateStartAndEndTime
{
    NSArray* statusArray = [self getCurrentStatusArray];
    if (statusArray.count > 0) {
        CCDeviceStatus* startStatus = [statusArray lastObject];
        CCDeviceStatus* endStatus = [statusArray objectAtIndex:0];
        [self setStartAndEndTime:startStatus.receive endTime:endStatus.receive];
    }
}

-(void) setStartAndEndTime:(long long)startTime endTime:(long long)endTime
{
    _currentStartTime = startTime;
    _currentEndTime = endTime;
    _totalTime = _currentEndTime - _currentStartTime;
    
    _startTimeLabel.text = [ZWL_TimeUtils getDayAndTime:_currentStartTime];
    _endTimeLabel.text = [ZWL_TimeUtils getDayAndTime:_currentEndTime];
    [_slider setPopoverText:_startTimeLabel.text];
    //    debugLog(@"startTime = %lld, endTime = %lld, totalTime = %lld", _currentStartTime, _currentEndTime, _totalTime);
}
#pragma mark  reset

-(void) reset
{
    _currentTime = 0;

    NSArray* statusArray = [self getCurrentStatusArray];
    _currentIndex = statusArray.count - 1;

    _startStatus = [statusArray lastObject];
    _endStatus = [statusArray objectAtIndex:0];
    
    _lastPoint = _startStatus.point;
    _currentPoint.coordinate = [ZWL_MapUtils geoPoint2Coordinate2D:_lastPoint];
    [_mapView setCenterCoordinate:[ZWL_MapUtils geoPoint2Coordinate2D:_lastPoint] animated:YES];
    
    //    [_mapView removeAnnotations:_allStayedPoints];
    //    [_allStayedPoints removeAllObjects];

    [self resetDevicePoint];
    
    [self cleanColorTrackLine];
    [_slider setValue:0];
}
-(void) resetDevicePoint
{
    
    NSArray* statusArray = [self getCurrentStatusArray];
    NSInteger lastIndex = statusArray.count - 1;
    CCDeviceStatus* start = [statusArray objectAtIndex:lastIndex];
    BMKGeoPoint point;
    point.longitudeE6 = (int)start.lang;
    point.latitudeE6 = (int)start.lat;
    _currentPointView.content = [self getStatusInfo:lastIndex];
    
    // 初始化角度
    CCDeviceStatus* next = [statusArray objectAtIndex:lastIndex - 1];
    CCDeviceStatus* current = [statusArray objectAtIndex:lastIndex];
    _currentPointView.angle = [ZWL_MapUtils getAngel:next.point p2:current.point];
    
    NSString* iconName = @"replay_pos";
    if (_device.type == DEVICE_PERSON) {
        iconName = @"replay_pos_person";
    } else if (_device.type == DEVICE_PET) {
        iconName = @"replay_pos_pet";
    }
    _currentPointView.icon =[UIImage imageNamed:iconName];
}

-(NSString*) getStatusInfo:(NSInteger)index
{
    NSArray* statusArray = [self getCurrentStatusArray];
    if (index < 0 || index >= statusArray.count) {
        return @"";
    }
    
    CCDeviceStatus* status = [statusArray objectAtIndex:index];
    if (status.stayed != 0) {
        return [self getStayedTime:status.stayed];
    }
    return [NSString stringWithFormat:@"速度:%.02f km/h", status.speed];
}
-(void) cleanColorTrackLine
{
    [_mapView removeOverlays:_colorsTrack];
    [_colorsTrack removeAllObjects];//清除数组中得数据
    [_redTrack removeAllObjects];
    [_greenTrack removeAllObjects];
    [_yellowTrack removeAllObjects];
}
-(NSString*) getStayedTime:(NSInteger)stayed
{
    NSMutableString* str = [NSMutableString stringWithString:@"停留:"];
    NSInteger hour = stayed / 60 / 60;
    if (hour > 0) {
        [str appendFormat:@"%ld小时", (long)hour];
    }
    
    NSInteger min = stayed / 60 %60;
    if (min > 0) {
        [str appendFormat:@"%ld分", (long)min];
    }
    
    NSInteger sec = stayed % 60;
    if (sec > 0) {
        [str appendFormat:@"%ld秒", (long)sec];
    }
    return [NSString stringWithString:str];
}

-(NSArray*) getCurrentStatusArray
{
//        if (_isViewAllTrack) {
//            CCSeqReplayInfo* currPlayInfo = [_allReplayInfo objectAtIndex:_allReplayIndex];
//            return currPlayInfo.statusList;
//        }
    return _statusArray;
}

#pragma mark buttonClick

- (IBAction)startPlay:(id)sender
{
    // 完成播放
    if (_currentTime == _totalTime) {
        [self stopPlay:nil];
    }
    
    
    if (_playState == STOP) {
        if (_currentTime > 0 && _currentTime < _totalTime) {
            [_mapView setCenterCoordinate:_currentPoint.coordinate];
            [self checkTimerAndMapZoom];
            _playState = PAUSE;
            [self resumePlay];
        } else {
            _playState = PLAY;
            [self startTrack];
        }
    } else if (_playState == PAUSE) {
        [self resumePlay];
    } else if (_playState == PLAY) {
        [self pausePlay];
    }
}

-(void) startTrack
{
    [self reset];
    
    [_startBtn setImage:[UIImage imageNamed:@"pause.png"]forState:UIControlStateNormal];
    
    if (_currentPoint) {
        [_mapView removeAnnotation:_currentPoint];
    }
    
    _currentPoint = [[BMKPointAnnotation alloc] init];
    NSArray* statusArray = [self getCurrentStatusArray];
    CCDeviceStatus* status = [statusArray objectAtIndex:_currentIndex];
    _currentPoint.coordinate = [ZWL_MapUtils geoPoint2Coordinate2D:status.point];
    
    [_mapView addAnnotation:_currentPoint];
    [_mapView setCenterCoordinate:_currentPoint.coordinate];
    
    [self checkTimerAndMapZoom];
}

-(void)resumePlay
{
    if (_playState == STOP) {
        return;
    }
    
    // 已经播放完成
    if (_currentTime == _totalTime) {
        [self reset];
    }
    _playState = PLAY;
    [_startBtn setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    /**
     *  currentTime	long long	1413246555250	1413246555250
     *  @return _r	long long	1413246750000	1413246750000
     */
}

-(void)pausePlay
{
    if (_playState == STOP) {
        return;
    }
    
    _playState = PAUSE;
    [_startBtn setImage:[UIImage imageNamed:@"dt_replay_start.png"] forState:UIControlStateNormal];
}

- (IBAction)stopPlay:(id)sender
{
    [self stopTimer];
    _playState = STOP;
    [_startBtn setImage:[UIImage imageNamed:@"dt_replay_start.png"] forState:UIControlStateNormal];
    
    [self reset];
}

-(void) startTimer
{
    [self stopTimer];
    
    __weak TrackerReplayViewController *vc = self;
    self.playTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_playTimer, DISPATCH_TIME_NOW,  0.05* NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_playTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc didMoveAnnotation];
        });
    });
    dispatch_resume(_playTimer);
    
}

- (void) didMoveAnnotation
{
    if (_playState == PLAY && _currentTime < _totalTime) {
        //        long long currentTime = [CCTimeUtils getCurrentTime];
        _currentTime += 900;//[self getTimeInterval];
        
        if (_currentTime >= _totalTime) {
            _currentTime = _totalTime;
        }
        
        CGFloat progress = _currentTime / (CGFloat)_totalTime * 100;
        [_slider setValue:progress];
        [self calcCurrentPosition:NO];
        
        if (_currentTime == _totalTime) {
            [self finishPlay];
        }
    }
}
-(void) finishPlay
{
    _currentPointView.content = @"已停止";
    [self pausePlay];
    
    if (_isViewAllTrack && _allReplayIndex > 0) {
        //        [self schedualNextTrack];//多条轨迹播放
    }
}
-(void) calcCurrentPosition:(BOOL)cleanLastTrack
{
    NSInteger lastIndex = _currentIndex;
    _currentIndex = [self calcCurrentIndex];//根据currentTime  而currentTime由slider滑动设置
    NSLog(@"%ld",(long)_currentIndex);
    [self updateSliderPopover:_currentTime];
    
    NSArray* statusArray = [self getCurrentStatusArray];
    BOOL shouldCleanColorTrack = NO;
    if (cleanLastTrack || lastIndex < _currentIndex) {
        [self cleanColorTrackLine];
        lastIndex = statusArray.count - 1;
        _lastPoint = ((CCDeviceStatus*)[statusArray objectAtIndex:_currentIndex]).point;
        shouldCleanColorTrack = YES;
    }
    
    BMKGeoPoint currentPoint = [self getCurrentPoint];
    if (!_useSingleColor) {
        // 对于多轨迹显示的情况需要重新添加颜色轨迹
        if (shouldCleanColorTrack) {
            [self addMultiColorTrackPath];
        }
        // 从上一个节点补充线段到当前节点
        if (lastIndex!=_currentIndex) {
            [self addColorTrack:lastIndex toIndex:_currentIndex];
            
        }else{
            CCDeviceStatus *currentD=statusArray[_currentIndex];
            BMKGeoPoint  p=currentD.point;
            if ((currentPoint.latitudeE6!=p.latitudeE6)||(currentPoint.longitudeE6!=p.longitudeE6)) {
                [self addColorPointTrack:currentPoint toIndex:p status:currentD];
            }
        }
    }
    
    if (_currentIndex > 0 && lastIndex != _currentIndex) {
        CCDeviceStatus* next = [statusArray objectAtIndex:_currentIndex - 1];
        CCDeviceStatus* current = [statusArray objectAtIndex:_currentIndex];
        CGFloat angle = [ZWL_MapUtils getAngel:next.point p2:current.point];
        _currentPointView.angle = angle;
        NSString* content = [self getStatusInfo:_currentIndex];
        _currentPointView.content = content;
        
    }
    
    _lastPoint = currentPoint;
    CLLocationCoordinate2D coord = [ZWL_MapUtils geoPoint2Coordinate2D:currentPoint];
    [self moveMapTo:coord];
    
    // 更新位置
    NSLog(@"%f  %f",coord.longitude,coord.latitude);
    _currentPoint.coordinate = coord;
    
}

// 从上一个节点添加路径到当前节点  -节点与节点之间
-(void) addColorTrack:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    NSArray* statusArray = [self getCurrentStatusArray];
    for (int i = (int)fromIndex; i > toIndex; i--) {
        CCDeviceStatus* current = [statusArray objectAtIndex:i];
        CCDeviceStatus* next = [statusArray objectAtIndex:i - 1];
        if (current && next) {
            [self addColorPointTrack:current.point toIndex:next.point status:current];
        }
    }
}
// 从一个BMKGeoPoint 到另一个BMKGeoPoint 的连线    点与点之间的
-(void)addColorPointTrack:(BMKGeoPoint )beginPoint toIndex:(BMKGeoPoint )endPoint status:(CCDeviceStatus *)current
{
    CLLocationCoordinate2D* coords = new CLLocationCoordinate2D[2];
    coords[0] = [ZWL_MapUtils geoPoint2Coordinate2D:beginPoint];
    coords[1] = [ZWL_MapUtils geoPoint2Coordinate2D:endPoint];
    BMKPolyline* trackLine = [BMKPolyline polylineWithCoordinates:coords count:2];
    [self addTrackLine:trackLine status:current addToMap:YES];
}

-(void) addTrackLine:(BMKPolyline*) line status:(CCDeviceStatus*)status addToMap:(BOOL)addToMap
{
    if ([_colorsTrack containsObject:line]) {
        return;
    }
    
    if (status.speed < UNDER_RED) {
        [_redTrack addObject:line];
    } else if (status.speed > UNDER_GREEN) {
        [_greenTrack addObject:line];
    } else {
        [_yellowTrack addObject:line];
    }
    [_colorsTrack addObject:line];
    
    if (addToMap) {
        [_mapView addOverlay:line];
    }
}

// 从起始轨迹添加颜色轨迹到当前播放的轨迹（不包含当前正在播放的轨迹）
-(void) addMultiColorTrackPath
{
    NSInteger size = _allReplayInfo.count;
    for (NSInteger i = size - 1; i > _allReplayIndex; i--) {
        //                CCSeqReplayInfo* replayInfo = [_allReplayInfo objectAtIndex:i];
        //                NSArray* statusList = replayInfo.statusList;
        //                NSInteger statusCount = statusList.count;
        //                for (int i = statusCount - 1; i > 0; i--) {
        //                    CCDeviceStatus* current = [statusList objectAtIndex:i];
        //                    CCDeviceStatus* next = [statusList objectAtIndex:i - 1];
        //                    if (current && next) {
        //                        CLLocationCoordinate2D* coords = new CLLocationCoordinate2D[2];
        //                        coords[0] = [MapUtils geoPoint2Coordinate2D:current.point];
        //                        coords[1] = [MapUtils geoPoint2Coordinate2D:next.point];
        //                        BMKPolyline* trackLine = [BMKPolyline polylineWithCoordinates:coords count:2];
        //                        [self addTrackLine:trackLine status:current addToMap:YES];
        //                    }
        //                }
    }
}

-(BMKGeoPoint) getCurrentPoint
{
    
    NSArray* statusArray = [self getCurrentStatusArray];
    CCDeviceStatus* currentStatus = [statusArray objectAtIndex:_currentIndex];
    BMKGeoPoint point = currentStatus.point;
    // 终点
    if (_currentIndex == 0) {
        return point;
    }
    
    CCDeviceStatus* nextStatus = [statusArray objectAtIndex:_currentIndex - 1];
    long long currentTime = _currentStartTime + _currentTime;
    if (currentTime < nextStatus.receive) {
        // 停留时间的单位是秒，需要转成毫秒
        //        NSInteger stayedTime = currentStatus.stayed * 1000;
        /**
         *   自定义调试stayedTime=200
         */
        if (currentTime <= currentStatus.receive + currentStatus.stayed) {
            return point;
        }
        /**
         *  duration  下一个节点和当前节点   到达的时间间隔
         offset    当前时间和 当前节点到达时间的  间隔
         */
        long long duration = nextStatus.receive - currentStatus.receive;
        long long offset = currentTime - currentStatus.receive;
        if (duration <= 0 || offset <= 0) {
            return point;
        }
        
        float percent = (float) offset / duration;
        point = [ZWL_MapUtils getPositionByRatio:currentStatus.point end:nextStatus.point ratio:percent];
        //        debugLog(@"getCurrentPoint percent = %f, [%d, %d]", percent, point.latitudeE6, point.longitudeE6);
        return point;
    }
    
    return  nextStatus.point;
}

-(void) moveMapTo:(CLLocationCoordinate2D)point
{
    
    BMKCoordinateRegion regon = _mapView.region;
    CGFloat spanX = regon.span.longitudeDelta;
    CGFloat spanY = regon.span.latitudeDelta;
    
    CLLocationCoordinate2D center = regon.center;
    
    CGFloat ratio = 3;
    CGFloat left = center.longitude - spanX / ratio;
    CGFloat right = center.longitude + spanX / ratio;
    CGFloat top = center.latitude - spanY / ratio;
    CGFloat bottom = center.latitude + spanY / ratio;
    
    if (point.longitude < left || point.longitude > right
        || point.latitude < top || point.latitude > bottom) {
        _playState = PAUSE;
        _pauseForMoveMap = YES;
        //        [_mapView setRegion:regon animated:YES];
        [_mapView setCenterCoordinate:point animated:YES];
        
        // FIXME: regionDidChangeAnimated 无效，所以在此延迟一定时间重新启动播放轨迹
        [ZWL_Utils postBlock:^{
            if (_pauseForMoveMap) {
                _pauseForMoveMap = NO;
                if (_playTimer) {
                    _playState = PLAY;
                }
            }
        } delay:0.35f];
    }
}
//_receive	long long	1413246372000	1413246372000
//currentTime	long l	1413246491800	1413246491800
-(NSInteger) calcCurrentIndex
{
    long long currentTime = _currentStartTime + _currentTime;
    NSArray* statusArray = [self getCurrentStatusArray];
    NSInteger size = statusArray.count;
    for (int i = (int)size - 1; i >= 1; i--) {
        CCDeviceStatus* first = [statusArray objectAtIndex:i];
        CCDeviceStatus* second = [statusArray objectAtIndex:i - 1];
        if(second.receive-first.receive>1200000)
        {
            _currentTime=second.receive;
            return i-1;
        }
        if (currentTime >= first.receive && currentTime < second.receive) {
            return i;
        }
    }
    return 0;
}

-(NSInteger) getTimeInterval
{
    switch (_speedMode) {
        case SPEED_MEDIUM:
            return SPEED_MEDIUM_VALUE;
            
        case SPEED_HIGH:
            return SPEED_HIGH_VALUE;
            
        default:
            return SPEED_LOW_VALUE;
    }
}
-(void) stopTimer
{
    if (_playTimer) {
        dispatch_source_cancel(_playTimer);
        _playTimer = nil;
    }
}
-(void) checkTimerAndMapZoom
{
    [self startTimer];
    
    if (!_hasSetMapZoom) {
        _hasSetMapZoom = YES;
        _mapView.zoomLevel = 16;
    }
}


#pragma mark slider

- (void) sliderValueChanged:(id)sender{
    UISlider* control = (UISlider*)sender;
    CGFloat value = control.value;
    [self updateSliderPopover:_totalTime * value / 100];
}

- (void) sliderDidEndSliding:(id)sender{
    UISlider* control = (UISlider*)sender;
    CGFloat value = control.value;
    _currentTime = _totalTime * value / 100;
    [self calcCurrentPosition:YES];
    [self resumePlay];
}

- (void) sliderDidStartSliding:(id)sender{
    [self pausePlay];
}

-(void)onPause
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    self.mapZoomLevel = _mapView.zoomLevel;
    
    if (_playState == PLAY) {
        [self pausePlay];
        _pauseBeforeDeactive = YES;
    }
}

-(void)onResume
{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _mapView.zoomLevel = self.mapZoomLevel;
    
    if (_playTimer == nil) {
        [self startTimer];
    }
    if (_pauseBeforeDeactive) {
        [self resumePlay];
        _pauseBeforeDeactive = NO;
    }
}

- (IBAction)playfrontItem:(id)sender {
    if (self.selectIndex==0) {
        [UIAlertView showWithTitle:@"提示" Message:@"当前已经是第一条数据了！" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
        return;
    }
    KBTracePart *part = self.dataarray[self.selectIndex];
    self.startTime=[part.endSpot.receive longLongValue];
    self.endTime=[part.startSpot.receive longLongValue];
    [self viewWillAppear:YES];
}

- (IBAction)playnextItem:(id)sender {
    if (self.selectIndex==self.dataarray.count-1) {
        [UIAlertView showWithTitle:@"提示" Message:@"当前已经是最后一条数据了！" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
        return;
    }
    KBTracePart *part = self.dataarray[--self.selectIndex];
    self.startTime=[part.endSpot.receive longLongValue];
    self.endTime=[part.startSpot.receive longLongValue];
    [self viewWillAppear:YES];
    
}

- (IBAction)zoomInMap:(id)sender
{
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        float zoomlevel=_mapView.zoomLevel;
        _mapView.zoomLevel=++zoomlevel;
    }else{
        float zoomlevel=_mapView.zoomLevel;
        _mapView.zoomLevel=++zoomlevel;
    }
}
- (IBAction)zoomOutMap:(id)sender
{
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        float zoomlevel=_mapView.zoomLevel;
        _mapView.zoomLevel=--zoomlevel;
    }else{
        float zoomlevel=_mapView.zoomLevel;
        _mapView.zoomLevel=--zoomlevel;
    }
}


#pragma BKMapView delegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    //    // 检查是否有重用的缓存
    //    BMKAnnotationView* newAnnotation = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    /**
     
     */
    //    if (newAnnotation == nil) {
    //        newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] ;
    //        // 设置颜色
    //		((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
    //        // 从天上掉下效果
    //		((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
    //        // 设置可拖拽
    //		((BMKPinAnnotationView*)newAnnotation).draggable = YES;
    //		return newAnnotation;
    //    }
    
    //	return nil;
    
    static NSString* annotationIdentifier = @"warningPin";
    //    if ([annotation isKindOfClass:[CCStayedPointAnnotation class]]) {
    //        CCStayedPointAnnotationView* annView = [[CCStayedPointAnnotationView alloc] initWithAnnotation:annotation
    //                                                                                       reuseIdentifier:annotationIdentifier];
    //
    //        CCStayedPointAnnotation* point =  (CCStayedPointAnnotation*)annotation;
    //        annView.text = point.text;
    //        annView.coord = point.coordinate;
    //        annView.content = [self getStayedTime:point.status.stayed];
    //        return annView;
    //    }
    //    else
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        if (annotation == _startPoint) {
            BMKPinAnnotationView* annView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                             reuseIdentifier:annotationIdentifier];
            annView.image =  [UIImage imageNamed:@"dt_start.png"];
            return annView;
            
        } else if (annotation == _endPoint) {
            BMKPinAnnotationView* annView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                             reuseIdentifier:annotationIdentifier];
            annView.image =  [UIImage imageNamed:@"dt_end.png"];
            return annView;
        } else if (annotation == _currentPoint) {
            _currentPointView = [[CCReplayAnnotationView alloc] initWithAnnotation:annotation
                                                                   reuseIdentifier:annotationIdentifier];
            
            [self resetDevicePoint];
            return _currentPointView;
        }
    }
    return nil;
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    //    if ([view isKindOfClass:[CCStayedPointAnnotationView class]]) {
    //        CCStayedPointAnnotationView* annView = (CCStayedPointAnnotationView*)view;
    //        annView.showPopup = YES;
    //        [_mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
    //    }
}

-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    //    if ([view isKindOfClass:[CCStayedPointAnnotationView class]]) {
    //        CCStayedPointAnnotationView* annView = (CCStayedPointAnnotationView*)view;
    //        annView.showPopup = NO;
    //    }
}

-(void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id )overlay
{
    if (overlay == _trackPath || [_allTrackPath containsObject:overlay]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = GRAY_LINE_COLOR;
        polylineView.lineWidth = TRACK_LINE_SIZE;
        return polylineView;
    } else if ([_redTrack containsObject:overlay]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = RED_LINE_COLOR;
        polylineView.lineWidth = TRACK_LINE_SIZE;
        return polylineView;
    } else if ([_greenTrack containsObject:overlay]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = GREEN_LINE_COLOR;
        polylineView.lineWidth = TRACK_LINE_SIZE;
        return polylineView;
    } else if ([_yellowTrack containsObject:overlay]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = YELLOW_LINE_COLOR;
        polylineView.lineWidth = TRACK_LINE_SIZE;
        return polylineView;
    }
    return nil;
}

-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //    debugLog(@"regionDidChangeAnimated");
}

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    //    debugLog(@"regionWillChangeAnimated");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}/*
  #pragma mark - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
  {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */

- (IBAction)search_click:(id)sender {
    TrackSearchViewController *trackSearch = [[TrackSearchViewController alloc] init];
    [self.navigationController pushViewController:trackSearch animated:YES];
}
@end
