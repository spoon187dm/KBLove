
//
//  FenceSettingViewController.m
//  KBLove
//
//  Created by qianfeng on 14-11-4.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "FenceSettingViewController.h"

@interface FenceSettingViewController ()
{
    BMKCircle* baidu_circle;
    MACircle * gaode_circle;
    
    BMKPolygon* baidu_polygon;
    MAPolygon *gaode_polygon;
    
    BMKMapView *baidu_map;
    MAMapView *gaode_map;
    
    BOOL isCircle;
}
@end

@implementation FenceSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isCircle=YES;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSliderView];
    [self mapviewInit];
    // Do any additional setup after loading the view.
}
-(void)setupSliderView
{
    self.fenceSlider.minimumValue=1;
    self.fenceSlider.maximumValue=100;
    self.fenceSlider.value=50;
    [self.fenceSlider addTarget:self action:@selector(silderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.fenceSlider addTarget:self action:@selector(sliderValueEndChanged:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark sliderDelegate

-(void)silderValueChanged:(id)slider
{
    UISlider* control = (UISlider*)slider;
    CGFloat value = control.value;
    
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    [self drawFenceRegion:1900*value/100+100 location:coor];
}

-(void)sliderValueEndChanged:(id)slider
{
    NSLog(@"slider end  changing!!");
    UISlider* control = (UISlider*)slider;
    CGFloat value = control.value;
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    [self drawFenceRegion:1900*value/100+100 location:coor];
}

-(void)mapviewInit
{
    UIView *view=[self.view viewWithTag:321];
    CGRect mainscreen=[UIScreen mainScreen].bounds;
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
       
        baidu_map=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, mainscreen.size.width, mainscreen.size.height)];
        [view addSubview:baidu_map];
        baidu_map.delegate=self;
        baidu_map.zoomLevel=15;
       
    }else{
        gaode_map=[[MAMapView alloc]initWithFrame:CGRectMake(0, 0, mainscreen.size.width, mainscreen.size.height)];
        [view addSubview:gaode_map];
        gaode_map.delegate=self;
        gaode_map.zoomLevel=15;
    }
}

//根据overlay生成对应的View
- (UIView *)mapView:(UIView *)mapView viewForOverlay:(id)overlay
{
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        if ([overlay isKindOfClass:[BMKCircle class]])
        {
            BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay] ;
            circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
            circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
            circleView.lineWidth = 5.0;
            return circleView;
        }
        if ([overlay isKindOfClass:[BMKPolygon class]])
        {
            BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
            polygonView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
            polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
            polygonView.lineWidth =5.0;
            return polygonView;
        }
    }else{
        
        
    
    }
	
	return nil;
}


-(void)drawFenceRegion:(NSInteger)distence location:(CLLocationCoordinate2D )location
{
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        if (isCircle) {
            if (baidu_polygon) {
                [baidu_map removeOverlay:baidu_polygon];
            }
            if (baidu_circle) {
                [baidu_map removeOverlay:baidu_circle];
            }
            baidu_circle = [BMKCircle circleWithCenterCoordinate:location radius:distence];
            [baidu_map addOverlay:baidu_circle];
        }else{
            //
            if (baidu_circle) {
                [baidu_map removeOverlay:baidu_circle];
            }
            if (baidu_polygon) {
                [baidu_map removeOverlay:baidu_polygon];
            }
            //0.01  近似   1千米  经纬度比例显示  5：4
            CLLocationCoordinate2D coords[4] = {0};
            coords[0].latitude = location.latitude+0.8*distence*0.01/1000;
            coords[0].longitude = location.longitude+distence*0.01/1000;
            coords[1].latitude = location.latitude+0.8*distence*0.01/1000;
            coords[1].longitude = location.longitude-distence*0.01/1000;
            coords[2].latitude =location.latitude-0.8*distence*0.01/1000;

            coords[2].longitude = location.longitude-distence*0.01/1000;
            coords[3].latitude = location.latitude-0.8*distence*0.01/1000;
            coords[3].longitude = location.longitude+distence*0.01/1000;

            baidu_polygon = [BMKPolygon polygonWithCoordinates:coords count:4];
            [baidu_map addOverlay:baidu_polygon];
        }
    }else{
        if (isCircle) {
            if (gaode_circle) {
                [gaode_map removeOverlay:gaode_circle];
            }
            gaode_circle = [MACircle circleWithCenterCoordinate:coor radius:distence];
            [gaode_map addOverlay:gaode_circle];
        }else{
            
        
        }
       
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击 进围栏报警
- (IBAction)Click_inSendwarning:(id)sender {
    
}
// 点击出围栏报警
- (IBAction)Click_outSendwarning:(id)sender {
    
}

- (IBAction)Click_down:(id)sender {
    float value=self.fenceSlider.value;
    if (value<=5) {
        value=0;
    }else{
        value-=5;
    }
    self.fenceSlider.value=value;
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    [self drawFenceRegion:1900*value/100+100 location:coor];
}

- (IBAction)Click_up:(id)sender {
    float value=self.fenceSlider.value;
    if (value>=95) {
        value=100;
    }else{
        value+=5;
    }
    self.fenceSlider.value=value;
    
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    
    [self drawFenceRegion:1900*value/100+100 location:coor];
}

- (IBAction)Click_setup:(id)sender {
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    [self drawFenceRegion:1000 location:coor];
}

- (IBAction)Click_selectRectType:(id)sender {
    isCircle=NO;
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    float value=self.fenceSlider.value;
    [self drawFenceRegion:1900*value/100+100 location:coor];
}

- (IBAction)Click_selectCircleType:(id)sender {
    isCircle=YES;
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    float value=self.fenceSlider.value;

    [self drawFenceRegion:1900*value/100+100 location:coor];
}

@end
