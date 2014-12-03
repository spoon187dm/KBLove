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
#import "TraceListViewController.h"
#import "SettingTableViewController.h"
#import "CarDataViewController.h"
#import "PetAndPersonDataViewController.h"

@interface DeviceDetailViewController ()
{
    BMKMapView *baidu_MapView;
    MAMapView *gaode_MapView;
    BMKPointAnnotation *baidu_SelfLocation;
    MAPointAnnotation *gaode_SelfLocation;

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
    NSLog(@"device_sn = %@", _device.sn);
    [KBDeviceManager getDeviceStatus:_device.sn finishBlock:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            _deviceStatus = result;
        }
    }];

    [self mapViewLoad];
}

-(void)mapViewLoad
{
    UIView *blank=[self.view viewWithTag:123];

    if ([[[KBUserInfo sharedInfo] mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        //百度地图
        baidu_MapView=[[BMKMapView alloc]init];
        UIScreen *screen=[UIScreen mainScreen];
        baidu_MapView.frame=CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height-46);
        [blank addSubview:baidu_MapView];
        baidu_MapView.delegate=self;
    }else {
        /**
         高德地图
         */
        gaode_MapView=[[MAMapView alloc]init];
        UIScreen *mainscreen=[UIScreen mainScreen];
        gaode_MapView.frame=CGRectMake(0, 0,mainscreen.bounds.size.width, mainscreen.bounds.size.height-46);
        [blank addSubview:gaode_MapView];
        gaode_MapView.delegate=self;
    }
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    [self addAnnotationViewToMap:coor titleStr:@"小小酥" subtitle:@"12：30北京市海淀区创业大厦" isMyselfLocation:NO];
    
}

-(UIView *)mapView:(UIView *)mapView viewForAnnotation:(id)annotation
{
    static NSString* annotationIdentifier = @"warningPin";
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView* annView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:annotationIdentifier];
        if (annotation ==baidu_SelfLocation) {
            annView.image =  [UIImage imageNamed:@"car_warning.png"];
            return annView;
        }
        annView.image =  [UIImage imageNamed:@"car.png"];
        return annView;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
  
        MAAnnotationView * annView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:annotationIdentifier];
        if (annotation ==gaode_SelfLocation) {
            annView.image =  [UIImage imageNamed:@"car.png"];
            return annView;
        }
        annView.image =  [UIImage imageNamed:@"endPoint.png"];
        
        annView.canShowCallout               = YES;
        annView.draggable                    = YES;
        return annView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addAnnotationViewToMap:(CLLocationCoordinate2D)coordinate titleStr:(NSString *)title subtitle:(NSString *)subtitle  isMyselfLocation:(Boolean)type
{
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        if (type) {
            baidu_SelfLocation=[[BMKPointAnnotation alloc]init];
            baidu_SelfLocation.coordinate=coordinate;
            baidu_SelfLocation.title=title;
            baidu_SelfLocation.subtitle=subtitle;
            [baidu_MapView addAnnotation:baidu_SelfLocation];
            return;
        }
        BMKPointAnnotation *p=[[BMKPointAnnotation alloc]init];
        p.coordinate = coordinate;
        p.title = title;
        p.subtitle =subtitle;
        [baidu_MapView addAnnotation:p];
    }else{
        if (type) {
            gaode_SelfLocation=[[MAPointAnnotation alloc]init];
            gaode_SelfLocation.coordinate=coordinate;
            gaode_SelfLocation.title=title;
            gaode_SelfLocation.subtitle=subtitle;
            [gaode_MapView addAnnotation:gaode_SelfLocation];
            return;
        }
        MAPointAnnotation *p=[[MAPointAnnotation alloc]init];
        p.coordinate = coordinate;
        p.title = title;
        p.subtitle =subtitle;
        [gaode_MapView addAnnotation:p];
    }
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
    CLLocationCoordinate2D coor;
    coor.latitude = 39.815;
    coor.longitude = 116.374;
    [self addAnnotationViewToMap:coor titleStr:@"当前位置" subtitle:@"当前位置"  isMyselfLocation:YES];
}
//地图放大
- (IBAction)click_zoomin:(UIButton *)sender
{
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        float zoomlevel=baidu_MapView.zoomLevel;
        baidu_MapView.zoomLevel=++zoomlevel;
    }else{
        float zoomlevel=gaode_MapView.zoomLevel;
        gaode_MapView.zoomLevel=++zoomlevel;
    }
}
//地图缩小
- (IBAction)click_zoomout:(UIButton *)sender
{
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        float zoomlevel=baidu_MapView.zoomLevel;
        baidu_MapView.zoomLevel=--zoomlevel;
    }else{
        float zoomlevel=gaode_MapView.zoomLevel;
        gaode_MapView.zoomLevel=--zoomlevel;
    }
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
    UIStoryboard * std  = [UIStoryboard storyboardWithName:@"Device_data" bundle:nil];
    //[_device.type isEqualToNumber:@(DEVICE_CAR)]
    
    if ([_device.type isEqualToNumber:@(DEVICE_CAR)]) {
        CarDataViewController * carData = [std instantiateViewControllerWithIdentifier:@"CarDataViewController"];
        carData.device = _device;
        carData.deviceStatus = _deviceStatus;
        
        [self.navigationController pushViewController:carData animated:YES];
    }else{
        PetAndPersonDataViewController * petAndPerson = [std instantiateViewControllerWithIdentifier:@"PetAndPersonDataViewController"];
        petAndPerson.device = _device;
        petAndPerson.deviceStatus = _deviceStatus;
        [self.navigationController pushViewController:petAndPerson animated:YES];
    }
    
}

//轨迹
- (IBAction)click_track:(UIButton *)sender{
    TraceListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TraceListViewController"];
    vc.device = _device;
    [self.navigationController pushViewController:vc animated:YES];
}

//删除
- (IBAction)click_delete:(UIButton *)sender{
    
}

//设置
- (IBAction)click_setting:(UIButton *)sender{
    
}

#pragma mark -
#pragma mark storyboard 界面跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toTraceListViewController"]) {
        TraceListViewController *vc = [segue destinationViewController];
        vc.device = _device;
    }else if([segue.identifier isEqualToString:@"toSettingViewController"]){
        SettingTableViewController *vc = [segue destinationViewController];
        vc.device = _device;
    }
}

@end
