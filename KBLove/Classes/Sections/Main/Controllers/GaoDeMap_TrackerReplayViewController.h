//
//  ZWLGaoDeMap_TrackerReplayViewController.h
//  baiDuTest
//
//  Created by qianfeng on 14-10-20.
//  Copyright (c) 2014年 zhangwenlong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "CCDevice.h"
#import "NYSliderPopover.h"
#import "HexColor.h"
#import "CCReplayGaoDeAnnotationView.h"



#define REPLAY_CONTROL_HEIGHT 110
#define BUTTON_WIDTH 40
#define BUTTON_HEGHT 46
#define BUTTON_MARGIN_RIGHT 12
#define BUTTON_MARGIN_BOTTOM 5
#define BUTTON_PADDING 10

#define BG_PADDING_TOP      5
#define BG_PADDING_LEFT     5
#define BG_PADDING_RIGHT    5
#define BG_PADDING_BOTTOM   5

#define SPEED_LOW        0
#define SPEED_MEDIUM     1
#define SPEED_HIGH       2

#define SPEED_LOW_VALUE        15 * 50///修改过后   15 *50
#define SPEED_MEDIUM_VALUE     30 * 50
#define SPEED_HIGH_VALUE       90 * 50

#define STOP             1
#define PAUSE            2
#define PLAY             3

#define UNDER_GREEN     20
#define UNDER_RED       15

#define TRACK_LINE_SIZE     3.0f
#define GRAY_LINE_COLOR     [UIColor colorWith8BitRed:131 green:154 blue:192]
#define RED_LINE_COLOR      [UIColor colorWith8BitRed:234 green:7 blue:7]
#define GREEN_LINE_COLOR    [UIColor colorWith8BitRed:132 green:200 blue:0]
#define YELLOW_LINE_COLOR   [UIColor colorWith8BitRed:255 green:120 blue:0]

#define kObjectMovedNotification			@"Object Moved Notification"

// 轨迹播放间隔（单位s）
#define kTrackInterval      5

@interface ZWLGaoDeMap_TrackerReplayViewController : UIViewController<MAMapViewDelegate>
{
//    MAPointAnnotation *
    MAPointAnnotation* _startPoint;
    MAPointAnnotation* _endPoint;
    MAPointAnnotation* _currentPoint;
    CCReplayGaoDeAnnotationView* _currentPointView;
    
    NSMutableArray*     _allStayedPoints;           // CCStayedPointAnnotation


    MAPolyline*        _trackPath;
    NSMutableArray*     _allTrackPath;              //
    
    NSMutableArray*     _colorsTrack;
    NSMutableArray*     _redTrack;
    NSMutableArray*     _greenTrack;
    NSMutableArray*     _yellowTrack;
    
    NSInteger           _playState;
    long long           _currentTime;
    long long           _totalTime;
    
    CCDeviceStatus*     _startStatus;
    CCDeviceStatus*     _endStatus;
    
//    BMKGeoPoint         _lastPoint;
    MAMapPoint          _lastPoint;
    
    
}
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *zoomOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *zoomInBtn;
@property (weak, nonatomic) IBOutlet UIView *replayCtrl;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;


@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet NYSliderPopover *slider;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (nonatomic, copy) NSString* trackStartAddr;
@property (nonatomic, copy) NSString* trackEndAddr;

@property (nonatomic, assign) long long startTime;
@property (nonatomic, assign) long long endTime;
@property (nonatomic, assign) BOOL isViewAllTrack;
@property (nonatomic, strong) CCDevice* device;
- (IBAction)switchToNormalSpeed:(id)sender;
- (IBAction)switchToFasterSpeed:(id)sender;
- (IBAction)switchToFatestSpeed:(id)sender;

- (IBAction)changeLineColorState:(id)sender;
- (IBAction)zoomInMap:(id)sender;
- (IBAction)zoomOutMap:(id)sender;
- (IBAction)startPlay:(id)sender;
- (IBAction)stopPlay:(id)sender;
- (IBAction)share:(id)sender;
@end
