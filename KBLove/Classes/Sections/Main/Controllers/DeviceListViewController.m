//
//  DeviceListViewController.m
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DeviceListViewController.h"
#import "DevicesCell.h"
#import <ReactiveCocoa.h>
#import "DeviceTableHeadView.h"
#import "KBUserManager.h"
#import "DropListView.h"
#import "DeviceDetailViewController.h"
#import "KBDeviceManager.h"
@interface DeviceListViewController (){
    NSMutableArray *_dataArray;
    DeviceTableHeadView *_headView;
//    下拉菜单是否显示

    DropListView *_dropListView;
}

@property (nonatomic, assign) BOOL isDrop;
@property (nonatomic, strong) DropListView *dropListView;

@end
#define CELLFRAME CGRectMake(0, 0, 320, 100)
@implementation DeviceListViewController

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
    self.isAllowScroll = TableIsForbiddenScroll;
    [self loadData];
    
    _dropListView = [[[NSBundle mainBundle]loadNibNamed:@"DropListView" owner:self options:nil] lastObject];
    _dropListView.origin = CGPointMake(220, 45);
    _dropListView.hidden = YES;
    [self.view addSubview:_dropListView];
    
    [RACObserve(_dropListView, index) subscribeNext:^(NSNumber *index){
        NSLog(@"选择 %@",index);
        if ([index isEqualToNumber:@0] && _isDrop) {
            UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Regist_Login_Storyboard" bundle:nil];
            UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"BoundAddEquipmentController"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
        }
        self.isDrop = NO;
        self.dropListView.hidden = YES;
        
    }];
    self.view.backgroundColor = SYSTEM_COLOR;
    
    [self changeNavigationBarToClear];
    
}

- (void)loadData{
    [KBDeviceManager getDeviceList:^(BOOL isSuccess, NSArray *resultArray) {
        if (isSuccess) {
            _dataArray = [resultArray mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark -
#pragma mark click 点击事件
-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum{
    
}

- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)click_dropList:(id)sender {
    self.isDrop = !_isDrop;
    self.dropListView.hidden = !_isDrop;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 51;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_headView) {
        _headView = [[[NSBundle mainBundle]loadNibNamed:@"DeviceTableHeadView" owner:self options:nil] lastObject];
        _headView.backgroundColor = SYSTEM_COLOR;
        [RACObserve(_headView, selectedIndex) subscribeNext:^(NSNumber *index){
            NSLog(@"%@",index);
        }];
    }
    [self.view bringSubviewToFront:_dropListView];
    return _headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    
    DevicesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[DevicesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.menuActionDelegate = self;
    }
    NSMutableArray *menuImgArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"页面列表3_09",@"stateNormal",@"页面列表3_09",@"stateHighLight", nil];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"页面列表3_06",@"stateNormal",@"页面列表3_06",@"stateHighLight", nil];

    [menuImgArr addObject:dic1];
    [menuImgArr addObject:dic2];
    
    KBDevices *device = _dataArray[indexPath.row];

    [cell configWithData:indexPath menuData:menuImgArr cellFrame:CGRectMake(0, 0, 320, 100)];
    [cell setData:device];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isAllowScroll != TableIsScroll && self.isEditing) {
        return;
    }
    if (self.isAllowScroll == TableIsScroll && self.isEditing) {
        if (self.editingCellNum != -1 && indexPath.row == self.editingCellNum) {
            return;
        }
    }
    
    DeviceDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DeviceDetailViewController"];
    vc.device = _dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark 功能函数


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
