//
//  AlarmListViewController.m
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AlarmListViewController.h"
#import "AlarmCell.h"
#import "KBAlarm.h"
#import "KBAlarmManager.h"
@interface AlarmListViewController (){
    NSMutableArray *_dataArray;
    BOOL _editing;
    NSMutableArray *_selectedArray;
}

@end

@implementation AlarmListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAllowScroll = TableIsForbiddenScroll;
    [self loadData];
    [self.view setBackgroundColor:SYSTEM_COLOR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
//    [[KBAlarmManager sharedManager] getAlarmInfoForDevice:_device finishblock:^(BOOL isSuccess, id result) {
//        _dataArray = [NSMutableArray arrayWithArray:result];
//    }];
    
    _dataArray = [NSMutableArray array];
    _selectedArray = [NSMutableArray array];
    for (NSInteger i = 0; i<10; i++) {
        [_dataArray addObject:@1];
        [_selectedArray addObject:@(NO)];
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

- (IBAction)click_menu:(id)sender {
    _editing = !_editing;
    [self.tableView reloadData];
    [self changeNavigationItem];
}

- (IBAction)click_home:(UIButton *)sender {
}

- (void)click_sure:(UIButton *)sender {
    _editing = !_editing;
    [self changeNavigationItem];
}

#pragma mark -
#pragma mark 临时navigationbar

- (void)changeNavigationItem{
    if (_editing) {
//        ;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 50, 30);
        [btn addTarget:self action:@selector(click_menu:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btn]];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setTitle:@"确定" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn2.frame = CGRectMake(0, 0, 50, 30);
        [btn2 addTarget:self action:@selector(click_menu:) forControlEvents:UIControlEventTouchUpInside];
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
    for (int i = 0; i < 1; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"icon_trash",@"stateNormal",@"icon_trash",@"stateHighLight", nil];
        [menuImgArr addObject:dic];
    }
    
//    KBAlarm *device = _dataArray[indexPath.row];
//    [cell setEditing:YES];
    [cell configWithData:indexPath menuData:menuImgArr cellFrame:CGRectMake(0, 0, 320, 70)];
    [cell startMyEdit:_editing];
    [cell setMySelected:[_selectedArray[indexPath.row] boolValue]];
//    [cell setData:device];
    
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
    NSNumber *value =  _selectedArray[indexPath.row];
    value = @([value boolValue]?NO:YES);
    [_selectedArray replaceObjectAtIndex:indexPath.row withObject:value];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
