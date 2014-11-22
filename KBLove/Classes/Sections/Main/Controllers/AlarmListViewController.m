//
//  AlarmListViewController.m
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AlarmListViewController.h"
#import <ReactiveCocoa.h>
#import "AlarmCell.h"
#import "KBAlarm.h"
#import "KBAlarmManager.h"
#import "KBDeviceManager.h"
#import "BottomSelectView.h"
#import "TableRefresh.h"
typedef NS_ENUM(NSInteger, AlarmOperationMode) {
    AlarmOperationModeRead   =  1,
    AlarmOperationModeDelete =  2
};
@interface AlarmListViewController (){

//    底部选择视图，用于选择全部删除，已读，全选
    BottomSelectView *_bottomSelectView;
    
//    警报信息数据源
    NSMutableArray *_dataArray;

//    标识当前是否处于mutable编辑模式
    BOOL _editing;

//    记录在mutable编辑模式下已选的cell，使用YES表示选中，NO表示未选中
    NSMutableArray *_selectedArray;
    
//    最后提交时是使用删除还是已读
    NSNumber *_alarmOperationMode;
    BOOL _isAllSelected;
}

@end

@implementation AlarmListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAllowScroll = TableIsForbiddenScroll;
    [self setUpBottomSelectView];
    
    __weak typeof(self)weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        [weakSelf loadData];
    }];
    
    [self.tableView headerBeginRefreshing];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView setBackgroundView:[UIImageView imageViewWithFrame:self.view.bounds image:[UIImage imageNamed:@"bg1"]]];
    [self changeNavigationBarFromImage:@"bg1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 数据与界面加载

- (void)loadData{
    if (_device) {
//        存在设备，获取对应设备的警报
//        [[KBAlarmManager sharedManager] getAlarmInfoForDevice:_device finishblock:^(BOOL isSuccess, id result) {
            //        _dataArray = [NSMutableArray arrayWithArray:result];
//        }];
        [KBDeviceManager getAlarmListForDevice:_device.sn finishBlock:^(BOOL isSuccess, NSArray *resultArray) {
            _dataArray = [NSMutableArray arrayWithArray:resultArray];
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }];
    }else{
//        不存在设备，直接获取所有的警报信息
        [KBDeviceManager getAllAlarmList:^(BOOL isSuccess, NSArray *resultArray) {
            _dataArray = [NSMutableArray arrayWithArray:resultArray];
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }];
    }
    
    _dataArray = [NSMutableArray array];
    _selectedArray = [NSMutableArray array];
    for (NSInteger i = 0; i<10; i++) {
        [_dataArray addObject:@1];
        [_selectedArray addObject:@(NO)];
    }
    
}

- (void)setUpBottomSelectView{
    
    _bottomSelectView = [[[NSBundle mainBundle]loadNibNamed:@"BottomSelectView" owner:self options:nil] lastObject];
    [_bottomSelectView setFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    [_bottomSelectView setBackgroundColor:[UIColor grayColor]];
    _bottomSelectView.readImageView.backgroundColor = [UIColor whiteColor];
    _bottomSelectView.deleteImageView.backgroundColor = [UIColor clearColor];
    _alarmOperationMode = @(AlarmOperationModeRead);
    _isAllSelected = NO;
//    [[UIApplication sharedApplication].keyWindow addSubview:_bottomSelectView];

#pragma mark mutable编辑时底部菜单事件
    [[_bottomSelectView.allSelectButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *sender){
        [self setAllCellSelected:!_isAllSelected];
        _isAllSelected = !_isAllSelected;
        _bottomSelectView.allSelectImageView.backgroundColor = _isAllSelected?[UIColor whiteColor]:[UIColor clearColor];
    }];
    
    [[_bottomSelectView.readButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *sender){
        _bottomSelectView.readImageView.backgroundColor = [UIColor whiteColor];
        _bottomSelectView.deleteImageView.backgroundColor = [UIColor clearColor];
        _alarmOperationMode = @(AlarmOperationModeRead);
    }];
    [[_bottomSelectView.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *sender){
        _bottomSelectView.readImageView.backgroundColor = [UIColor clearColor];
        _bottomSelectView.deleteImageView.backgroundColor = [UIColor whiteColor];
        _alarmOperationMode = @(AlarmOperationModeRead);
    }];

}

#pragma mark -
#pragma mark 数据处理

- (void)setAllCellSelected:(BOOL)select{
    for (NSInteger i = 0; i<_selectedArray.count; i++) {
        NSNumber *value =  _selectedArray[i];
        value = @(select);
        [_selectedArray replaceObjectAtIndex:i withObject:value];
    }
    [self.tableView reloadData];
}

#pragma mark - 界面处理

- (void)endMutableEditing{
    _editing = !_editing;
    [self changeNavigationItem];
    [self showButtomSelectView:NO];
    [self.tableView reloadData];
}

- (void)showButtomSelectView:(BOOL)shouldShow{
    if (shouldShow) {
        [[UIApplication sharedApplication].keyWindow addSubview:_bottomSelectView];
    }else{
        [_bottomSelectView removeFromSuperview];
    }
}


#pragma mark 临时navigationbar
- (void)changeNavigationItem{
    if (_editing) {
        //        ;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 50, 30);
        [btn addTarget:self action:@selector(click_cancel:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btn]];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setTitle:@"确定" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn2.frame = CGRectMake(0, 0, 50, 30);
        [btn2 addTarget:self action:@selector(click_sure:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:btn2]]];
    }else{
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"navileft"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btn]];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"icon_home"] forState:UIControlStateNormal];
        btn1.frame = CGRectMake(0, 0, 30, 30);
        [btn1 addTarget:self action:@selector(click_home:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
        btn2.frame = CGRectMake(0, 0, 30, 30);
        [btn2 addTarget:self action:@selector(click_menu:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:btn1];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:btn2];
        [self.navigationItem setRightBarButtonItems:@[item1,item2]];
    }
}

#pragma mark -
#pragma mark click 点击事件
-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum{
    NSLog(@"你选择了第 %ld 行第 %ld 个菜单",cellIndexNum+1,menuIndexNum+1);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"你选择了第 %ld 行第 %ld 个菜单",cellIndexNum+1,menuIndexNum+1] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)deleteCell:(TableMenuCell *)cell{
    
}
- (IBAction)click_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//进入mutable编辑模式
- (IBAction)click_menu:(id)sender {
//    如果正在侧滑编辑模式，直接结束策划编辑
    [self hideMenuActive:YES];
    
//    如果当前是正在Mutable编辑模式，则直接结束，并且将选择记录数组初始化
//    否则会展示底部选择栏
    if (_editing) {
        [self setAllCellSelected:NO];
    }else{
        [self showButtomSelectView:YES];
    }
    
    _editing = !_editing;
    [self.tableView reloadData];
    [self changeNavigationItem];
}

- (IBAction)click_home:(UIButton *)sender {
}

#pragma mark 顶部菜单

- (void)click_cancel:(UIButton *)sender{
    [self endMutableEditing];
}

- (void)click_sure:(UIButton *)sender {
    //TODO:需要加入网络处理
    [self endMutableEditing];
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
//    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"alarmcell";
    
    AlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[AlarmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.menuActionDelegate = self;
    }
    NSMutableArray *menuImgArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"icon_trash",@"stateNormal",@"icon_trash",@"stateHighLight", nil];
    [menuImgArr addObject:dic];

    [cell configWithData:indexPath menuData:menuImgArr cellFrame:CGRectMake(0, 0, 320, 70)];
    [cell startMyEdit:_editing];
    [cell setMySelected:[_selectedArray[indexPath.row] boolValue]];
    
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
    if (_editing) {
        NSNumber *value =  _selectedArray[indexPath.row];
        value = @([value boolValue]?NO:YES);
        [_selectedArray replaceObjectAtIndex:indexPath.row withObject:value];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmDetailViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
