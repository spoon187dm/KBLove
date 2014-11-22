//
//  ShareLocationViewController.m
//  KBLove
//
//  Created by cinderalla on 14-11-18.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "ShareLocationViewController.h"
#import "BMapKit.h"
#import <MAMapKit/MAMapKit.h>
#import "SendMessageView.h"
#import "ZWL_MapViewTool.h"

@interface ShareLocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate>

{
    //百度地图
    BMKMapView *_baiduView;
    //高德地图
    MAMapView *_gaodeView;
    

}
@end

@implementation ShareLocationViewController

-(void)addMapViewToViewController:(UIViewController *)controller frame:(CGRect)rect location:(CLLocationCoordinate2D)location

{
    self.view = controller.view;
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]){
        
        if (!_baiduView) {
            _baiduView = [[BMKMapView alloc]init];
            _baiduView.delegate = self;
            
        }
        _baiduView.showsUserLocation = YES;
        [_baiduView setRegion:BMKCoordinateRegionMake(location, BMKCoordinateSpanMake(0.1, 0.1))];
        //创建大头针
        
        
        [controller.view addSubview:_baiduView];
    }else{
    
        if (!_gaodeView) {
            _gaodeView = [[MAMapView alloc]init];
            _gaodeView.delegate =self;
            
        }
        _gaodeView.showsUserLocation = YES;
        [_gaodeView setRegion:MACoordinateRegionMake(location, MACoordinateSpanMake(0.1,0.1))];
        
        
        //创建大头针
        
        [controller.view addSubview:_gaodeView];
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
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
