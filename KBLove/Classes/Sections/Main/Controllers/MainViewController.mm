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
#import <MAMapKit/MAMapKit.h>


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
}

- (NSArray *)getFriendDeviceArray;
- (NSArray *)getCarDeviceArray;
- (NSArray *)getPetDeviceArray;
- (NSArray *)getPersonDeviceArray;


- (IBAction)click_car:(id)sender;
- (IBAction)click_person:(id)sender;
- (IBAction)click_pet:(id)sender;
- (IBAction)click_allDevices:(id)sender;
- (IBAction)click_friends:(id)sender;
- (IBAction)click_circle:(id)sender;
- (IBAction)click_devicesList:(id)sender;
- (IBAction)click_message:(id)sender;
- (IBAction)click_mine:(id)sender;

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
//    [[KBScoketManager ShareManager]startScoket];

    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    [self setupData];
    [self setupView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 功能方法

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
    [KBDeviceManager getDeviceList:^(BOOL isSuccess, NSArray *resultArray) {
        if (isSuccess) {
            _allDeviceArray = resultArray;
            [self setupDeviceArray];
        }
    }];
}

//初始化界面
- (void)setupView{
    [self setupMapView];
    _petButton.enabled = false;
    [_petButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _carButton.enabled = false;
    [_carButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _personButton.enabled = false;
    [_personButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

//初始化地图
- (void)setupMapView{
    
    /**
     百度地图
     */

    baidu_MapView=[[BMKMapView alloc]init];
    UIScreen *mainscreen=[UIScreen mainScreen];
    baidu_MapView.frame=CGRectMake(0, 0,mainscreen.bounds.size.width, mainscreen.bounds.size.height-135);
    [self.view addSubview:baidu_MapView];
    baidu_MapView.delegate=self;
    
    /**
     高德地图
     */
//    gaode_MapView=[[MAMapView alloc]init];
//    UIScreen *mainscreen=[UIScreen mainScreen];
//    gaode_MapView.frame=CGRectMake(0, 0,mainscreen.bounds.size.width, mainscreen.bounds.size.height-135);
//    [self.view addSubview:gaode_MapView];
//    gaode_MapView.delegate=self;
//    
//    MAPointAnnotation *p=[[MAPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 39.915;
//    coor.longitude = 116.404;
//    p.coordinate = coor;
//    p.title = @"test";
//    p.subtitle = @"此Annotation可拖拽!";
//    [gaode_MapView addAnnotation:p];
    
    
    
    BMKPointAnnotation *p=[[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    p.coordinate = coor;
    p.title = @"test";
    p.subtitle = @"此Annotation可拖拽!";
    [baidu_MapView addAnnotation:p];
    CLLocationCoordinate2D cl2d = CLLocationCoordinate2DMake(40.035139, 116.311655);
    BMKPointAnnotation *point=[[BMKPointAnnotation alloc]init];
    point.coordinate=cl2d;
    [baidu_MapView addAnnotation:point];
    
    
    
    
    //设置地图显示区域
//    CLLocationCoordinate2D cl2d = CLLocationCoordinate2DMake(40.035139, 116.311655);
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
//    MKCoordinateRegion re = MKCoordinateRegionMake(cl2d, span);
//    [baidu_mapview setRegion:re];
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
#pragma mark 地图操作

- (NSArray *)getLastAnnotationArray{
    return _pointArray;
}

- (void)setLastAnnotationArray:(NSArray *)array{
    _pointArray = [NSMutableArray arrayWithArray:array];
}

- (void)clearMap{
    
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:@""]) {
        
    }
}

- (void)addPoints:(NSArray *)array{
    [_pointArray addObjectsFromArray:array];
}

- (void)showPoints:(NSArray *)array{
    [self clearMap];
}

- (void)addPoint:(CGPoint)point toMap:(id)map{
    
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
        MAPinAnnotationView * annView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:annotationIdentifier];
        annView.image =  [UIImage imageNamed:@"endPoint.png"];
        return annView;
//        }
        
        
    }
    return nil;
}



#pragma mark -
#pragma mark 界面点击事件
- (IBAction)click_car:(id)sender {
}


- (IBAction)click_person:(id)sender{
}

- (IBAction)click_pet:(id)sender{
}

- (IBAction)click_allDevices:(id)sender{
    
    [KBDeviceManager getDeviceList:^(BOOL isSuccess, NSArray *resultArray) {
        
    }];
    
}

- (IBAction)click_friends:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"FriendsListTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:^{
//        
//    }];
}

- (IBAction)click_circle:(id)sender{
    CircleViewController *vc = [[CircleViewController alloc]init];
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

@end
