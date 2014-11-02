//
//  DeviceDetailViewController.m
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "KBAlarmManager.h"
#import "AlarmListViewController.h"
#import "KBDeviceManager.h"

@interface DeviceDetailViewController ()
{
    BMKMapView *baidu_MapView;
    MAMapView *gaode_MapView;
}
@end

@implementation DeviceDetailViewController

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
#pragma mark -
#pragma mark 获取设备信息
    [KBDeviceManager getDeviceInfo:_device.sn finishBlock:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            _device = result;
        }
    }];

#pragma mark 获取设备状态
    [KBDeviceManager getDeviceStatus:_device.sn finishBlock:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            _deviceStatus = result;
        }
    }];
    
    [self mapViewLoad];
}
-(void)mapViewLoad
{
//    baidu_MapView=[[BMKMapView alloc]init];
//    UIScreen *screen=[UIScreen mainScreen];
//    baidu_MapView.frame=CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height-46);
//    [self.view addSubview:baidu_MapView];
//    baidu_MapView.delegate=self;
//    
//    
//    BMKPointAnnotation *p=[[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 39.915;
//    coor.longitude = 116.404;
//    p.coordinate = coor;
//    p.title = @"小小酥";
//    p.subtitle = @"12：30北京市海淀区创业大厦!";
//    [baidu_MapView addAnnotation:p];
//    CLLocationCoordinate2D cl2d =CLLocationCoordinate2DMake(40.035139, 116.311655);
//    BMKPointAnnotation *point=[[BMKPointAnnotation alloc]init];
//    point.coordinate=cl2d;
//    [baidu_MapView addAnnotation:point];
    
    /**
     高德地图
     */
    gaode_MapView=[[MAMapView alloc]init];
    UIScreen *mainscreen=[UIScreen mainScreen];
    gaode_MapView.frame=CGRectMake(0, 0,mainscreen.bounds.size.width, mainscreen.bounds.size.height-46);
    [self.view addSubview:gaode_MapView];
    gaode_MapView.delegate=self;
    
    
    MAPointAnnotation *p=[[MAPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    [self addAnnotationViewToMap:coor titleStr:@"小小酥" subtitle:@"12：30北京市海淀区创业大厦"];
    
}

-(UIView *)mapView:(UIView *)mapView viewForAnnotation:(id)annotation
{
    static NSString* annotationIdentifier = @"warningPin";
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        //        if (annotation == Point) {
        BMKPinAnnotationView* annView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:annotationIdentifier];
        annView.image =  [UIImage imageNamed:@"car.png"];
        return annView;
        //        }
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        //        if (annotation == Point) {

        MAAnnotationView * annView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:annotationIdentifier];
        annView.image =  [UIImage imageNamed:@"endPoint.png"];
        
        annView.canShowCallout               = YES;
        annView.draggable                    = YES;
        return annView;
        //        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addAnnotationViewToMap:(CLLocationCoordinate2D)coordinate titleStr:(NSString *)title subtitle:(NSString *)subtitle
{
    if (1) {
        MAPointAnnotation *p=[[MAPointAnnotation alloc]init];
        p.coordinate = coordinate;
        p.title = title;
        p.subtitle =subtitle;
        [gaode_MapView addAnnotation:p];
    }
    
//    [baidu_MapView addAnnotation:p];
}

#pragma mark -
#pragma mark 界面点击事件

//刷新数据
- (IBAction)click_refrash:(UIButton *)sender
{

}
//定位
- (IBAction)click_lacation:(UIButton *)sender
{
    
}
//地图放大
- (IBAction)click_zoomin:(UIButton *)sender
{
    float zoomlevel=baidu_MapView.zoomLevel;
    baidu_MapView.zoomLevel=++zoomlevel;
//    float zoomlevel=gaode_MapView.zoomLevel;
//    gaode_MapView.zoomLevel=++zoomlevel;
}
//地图缩小
- (IBAction)click_zoomout:(UIButton *)sender
{
    float zoomlevel=baidu_MapView.zoomLevel;
    baidu_MapView.zoomLevel=++zoomlevel;
//    float zoomlevel=gaode_MapView.zoomLevel;
//    gaode_MapView.zoomLevel=++zoomlevel;
}

- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_home:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//报警
- (IBAction)click_alarm:(UIButton *)sender{
    AlarmListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmListViewController"];
    vc.device = _device;
    [self.navigationController pushViewController:vc animated:YES];
}

//数据
- (IBAction)click_data:(UIButton *)sender{
    
}

//轨迹
- (IBAction)click_track:(UIButton *)sender{
    
}

//删除
- (IBAction)click_delete:(UIButton *)sender{
    
}

//设置
- (IBAction)click_setting:(UIButton *)sender{
    
}

@end
