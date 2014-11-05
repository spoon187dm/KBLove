//
//  MainViewController.m
//  KBLove
//
//  Created by block on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "MainViewController.h"
#import <ReactiveCocoa.h>
#import "KBDevices.h"
#import "KBUserManager.h"
#import "CircleViewController.h"
#import "KBDeviceManager.h"
#import <SVProgressHUD.h>
#import <MAMapKit/MAMapKit.h>
#import "CircleAndFriendListViewController.h"

@interface MainViewController (){
    //百度地图
    BMKMapView *baidu_MapView;
    //高德地图
    MAMapView *gaode_MapView;
    
    CLLocationManager *_manager;
//    三种设备类型按钮
    UIButton *_petButton;
    UIButton *_carButton;
    UIButton *_personButton;
//    所有设备数组
    NSArray *_allDeviceArray;
//    三种类型设备数组
    NSMutableArray *_carDeviceArray;
    NSMutableArray *_petDeviceArray;
    NSMutableArray *_personDeviceArray;
//    三种类型设备是否含有
    BOOL _hasCarDevice;
    BOOL _hasPetDevice;
    BOOL _hasPersonDevice;
    
//    地图上点
    NSMutableArray *_pointArray;
    
//    下拉菜单选项
    UIView *_dropListView;
}

//- (NSArray *)getFriendDeviceArray;
//- (NSArray *)getCarDeviceArray;
//- (NSArray *)getPetDeviceArray;
//- (NSArray *)getPersonDeviceArray;


- (IBAction)click_car:(id)sender;
- (IBAction)click_person:(id)sender;
- (IBAction)click_pet:(id)sender;
- (IBAction)click_allDevices:(id)sender;
- (IBAction)click_friends:(id)sender;
//- (IBAction)click_circle:(id)sender;
- (IBAction)click_devicesList:(id)sender;
- (IBAction)click_message:(id)sender;
- (IBAction)click_mine:(id)sender;
- (IBAction)click_dropList:(id)sender;
- (IBAction)click_alarm:(id)sender;

@end

@implementation MainViewController

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
    
    //Scoket登陆服务器
    [[KBScoketManager ShareManager]startScoket];

    [self changeNavigationBarToClear];
    [self setupData];
    [self setupView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 界面与数据初始化

//初始化一些界面参数
- (void)setupData{
    
    _personButton = (UIButton *)[self.view viewWithTag:100];
    _carButton = (UIButton *)[self.view viewWithTag:101];
    _petButton = (UIButton *)[self.view viewWithTag:102];
    
    _allDeviceArray = nil;
    
    _petDeviceArray = [NSMutableArray array];
    _personDeviceArray = [NSMutableArray array];
    _carDeviceArray = [NSMutableArray array];
    
    _hasPetDevice = NO;
    _hasCarDevice = NO;
    _hasPersonDevice = NO;
    
    _pointArray = [NSMutableArray array];
}

//加载设备数据
- (void)loadData{
    [SVProgressHUD showWithStatus:@"设备获取,.."];
    [KBDeviceManager getDeviceList:^(BOOL isSuccess, NSArray *resultArray) {
        if (isSuccess) {
            _allDeviceArray = resultArray;
            [self setupDeviceArray];
            [self showDevices:_allDeviceArray];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD dismiss];
            [UIAlertView showWithTitle:@"设备获取失败" Message:@"请检查网络连接后重试" cancle:@"取消" otherbutton:@"重试" block:^(NSInteger index) {
                if (1 == index) {
                    [self loadData];
                }
            }];
        }
    }];
}

//初始化界面
- (void)setupView{
    [self setupMapView];
    [self setupDropListView];
    _petButton.enabled = false;
    [_petButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _carButton.enabled = false;
    [_carButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _personButton.enabled = false;
    [_personButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

//初始化地图
- (void)setupMapView{
    
    UIView *blank=[self.view viewWithTag:21];
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        baidu_MapView=[[BMKMapView alloc]init];
        baidu_MapView.frame=blank.bounds;
        [blank addSubview:baidu_MapView];
        baidu_MapView.delegate=self;
    }else{
        gaode_MapView=[[MAMapView alloc]init];
        gaode_MapView.frame=blank.bounds;
        [blank addSubview:gaode_MapView];
        gaode_MapView.delegate=self;
    }
    
    //设置地图显示区域
//    CLLocationCoordinate2D cl2d = CLLocationCoordinate2DMake(40.035139, 116.311655);
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
//    MKCoordinateRegion re = MKCoordinateRegionMake(cl2d, span);
//    [baidu_mapview setRegion:re];
}

- (void)setupDropListView{
    _dropListView = [[UIView alloc]init];
    _dropListView.frame = CGRectMake(kScreenWidth-100, 64, 100, 30*4);
    _dropListView.backgroundColor = [UIColor clearColor];
    
    NSArray *titles = @[@"所有设备",@"好友设备",@"我的设备",@"绑定设备"];
    for (NSInteger i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithFrame:CGRectMake(0, 30*i, 100, 30) title:titles[i] target:self Action:@selector(click_dropListItem:)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"RegisterFisihed2"] forState:UIControlStateNormal];
        btn.tag = 300+i;
        [_dropListView addSubview:btn];
    }
    [self.view addSubview:_dropListView];
    _dropListView.hidden = YES;
}

- (void)setupDeviceArray{
    for (KBDevices *device in _allDeviceArray) {
        if ([device.type isEqualToNumber:@1]) {
            [_carDeviceArray addObject:device];
            _hasCarDevice = YES;
            _carButton.enabled = YES;
            [_carButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if([device.type isEqualToNumber:@2]){
            [_petDeviceArray addObject:device];
            _hasPetDevice = YES;
            _petButton.enabled = YES;
            [_petButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if([device.type isEqualToNumber:@3]){
            [_personDeviceArray addObject:device];
            _hasPersonDevice = YES;
            _personButton.enabled = YES;
            [_personButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

#pragma mark -
#pragma mark 私有功能方法

- (void)hideDropListView{
    [UIView animateWithDuration:.5 animations:^{
        _dropListView.hidden = YES;
    }];
}

#pragma mark -
#pragma mark 地图操作

- (void)clearMap{
    
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        [baidu_MapView removeAnnotations:_pointArray];
    }else{
        [gaode_MapView removeAnnotations:_pointArray];
    }
    [_pointArray removeAllObjects];
}

- (void)showDevices:(NSArray *)array{
    [self clearMap];
//    [_pointArray addObjectsFromArray:array];

    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        for (KBDevices *device in array) {
            BMKPointAnnotation *point = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coordination2d = CLLocationCoordinate2DMake([device.devicesStatus.lat doubleValue], [device.devicesStatus.lng doubleValue]);
            point.coordinate = coordination2d;
            point.title = device.name;
            [_pointArray addObject:point];
        }
    }else{
        for (KBDevices *device in array) {
            MAPointAnnotation *point = [[MAPointAnnotation alloc]init];
            CLLocationCoordinate2D coordination2d = CLLocationCoordinate2DMake([device.devicesStatus.lat floatValue], [device.devicesStatus.lng floatValue]);
            point.coordinate = coordination2d;
            point.title = device.name;
            [_pointArray addObject:point];
        }
    }
    [self showPointInMapView];
}

- (void)showPointInMapView{
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        [baidu_MapView addAnnotations:_pointArray];
    }else{
        [gaode_MapView addAnnotations:_pointArray];
    }
}

#pragma mammapview Delegate

-(UIView *)mapView:(UIView *)mapView viewForAnnotation:(id)annotation
{
    static NSString* annotationIdentifier = @"warningPin";
//    百度
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        if (annotation == Point) {
        BMKPinAnnotationView* annView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:annotationIdentifier];
        annView.image =  [UIImage imageNamed:@"car.png"];
        return annView;
//        }
        
       
    }
//    高德地图
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
//        if (annotation == Point) {
        MAAnnotationView * annView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:annotationIdentifier];
        annView.image =  [UIImage imageNamed:@"endPoint.png"];
        return annView;
//        }
        
        
    }
    return nil;
}


-(void)addAnnotationViewToMap:(CLLocationCoordinate2D)coordinate titleStr:(NSString *)title subtitle:(NSString *)subtitle  isMyselfLocation:(Boolean)type
{
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        BMKPointAnnotation *p=[[BMKPointAnnotation alloc]init];
        p.coordinate = coordinate;
        p.title = title;
        p.subtitle =subtitle;
        [baidu_MapView addAnnotation:p];
    }else{
        MAPointAnnotation *p=[[MAPointAnnotation alloc]init];
        p.coordinate = coordinate;
        p.title = title;
        p.subtitle =subtitle;
        [gaode_MapView addAnnotation:p];
    }
}

#pragma mark -
#pragma mark 界面点击事件

- (IBAction)click_fresh:(UIButton *)sender
{
    
}
- (IBAction)click_Location:(UIButton *)sender
{
    CLLocationCoordinate2D coor;
    coor.latitude = 39.615;
    coor.longitude = 116.344;
    [self addAnnotationViewToMap:coor titleStr:@"当前位置" subtitle:@"当前位置"  isMyselfLocation:YES];
}
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

- (IBAction)click_car:(id)sender {
    [self showDevices:_carDeviceArray];
}


- (IBAction)click_person:(id)sender{
    [self showDevices:_personDeviceArray];
}

- (IBAction)click_pet:(id)sender{
    [self showDevices:_petDeviceArray];
}

- (IBAction)click_allDevices:(id)sender{
    [self showDevices:_allDeviceArray];
}

- (IBAction)click_friends:(id)sender{
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:[NSBundle mainBundle]];
//    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"FriendsListTableViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
    CircleAndFriendListViewController *vc = [[CircleAndFriendListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click_circle:(id)sender{
    CircleAndFriendListViewController *vc = [[CircleAndFriendListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click_devicesList:(id)sender{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DeviceListViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click_message:(id)sender{
}

- (IBAction)click_mine:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Me_StoryBoardN" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"MineViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click_dropList:(id)sender {
    [UIView animateWithDuration:.5 animations:^{
        _dropListView.hidden = !_dropListView.hidden;
    }];
}

- (IBAction)click_alarm:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmListViewController"];
//    vc.device = _device;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)click_dropListItem:(UIButton *)button{
    
    NSInteger index = button.tag-300;
    switch (index) {
        case 0:
        {
//            所有设备
            [self showDevices:_allDeviceArray];
        }
            break;
        case 1:{
//            好友设备
            
        }
            break;
        case 2:{
//            我的设备
        }
            break;
        case 3:{
//            绑定设备
            UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Regist_Login_Storyboard" bundle:nil];
            UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"BoundAddEquipmentController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    [self hideDropListView];
}

@end
