//
//  shareLocationBaiduViewController.m
//  KBLove
//
//  Created by cinderalla on 14-11-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "shareLocationBaiduViewController.h"
#import "BMapKit.h"

@interface shareLocationBaiduViewController ()

{
    BMKMapView *_baiduMapView;
    BMKLocationService *_locationService;

}
@end

@implementation shareLocationBaiduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_baiduMapView) {
        _baiduMapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
        [_baiduMapView setRegion:BMKCoordinateRegionMake(CLLocationCoordinate2DMake(1, 1), BMKCoordinateSpanMake(0.1, 0.1))];
        
        [self.view addSubview:_baiduMapView];
        
        _baiduMapView.zoomEnabled = YES;
        _baiduMapView.zoomLevel = 1;
        
        [self.view addSubview:_baiduMapView];
        _locationService = [[BMKLocationService alloc]init];
        [_locationService startUserLocationService];
        _baiduMapView.showsUserLocation = YES;
        _baiduMapView.userTrackingMode = BMKUserTrackingModeNone;
        
         
        
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [_baiduMapView viewWillAppear];
    _baiduMapView.delegate = self;
    _locationService.delegate = self;

}
- (void)viewWillDisappear:(BOOL)animated
{
    [_baiduMapView viewWillDisappear];
    _baiduMapView.delegate = nil;
    _locationService.delegate = nil;

}

#pragma mark 自定义大头针的代理方法

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    BMKAnnotationView *BMKannotation = [mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    if (!BMKannotation) {
        BMKannotation = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ID"];
        
    }
    
    //设置图片
    
    BMKannotation.image = [UIImage imageNamed:@""];
    BMKannotation.frame = CGRectMake(90, 90, 30, 30);
    [UIView animateWithDuration:1 animations:^{
        BMKannotation.frame = CGRectMake(100, 100, 30, 30);
    }];
    
    return BMKannotation;

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
