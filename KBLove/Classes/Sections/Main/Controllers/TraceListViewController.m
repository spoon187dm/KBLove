//
//  TraceListViewController.m
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TraceListViewController.h"
#import "TraceCell.h"
#import "KBDeviceManager.h"
@interface TraceListViewController (){
    NSMutableArray *_dataArray;
}

@end

@implementation TraceListViewController

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
    self.isAllowScroll = TableIsForbiddenScroll;
    [self replaceSelfViewToNormal];
    [self setUpView];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark View 操作

- (void)setUpView{
    UIImageView *imageView = [UIImageView imageViewWithFrame:self.view.bounds image:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
}

#pragma mark -
#pragma mark Data 操作

- (void)loadData{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *current = [NSDate date];
    NSString *currentDate = [formatter stringFromDate:current];
    
    NSDate *date = [formatter dateFromString:currentDate];
    
    long form = [date timeIntervalSince1970];
    long to = [current timeIntervalSince1970];
    [KBDeviceManager getDevicePart:_device.sn from:form to:to block:^(BOOL isSuccess, id result) {
        
    }];
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

- (IBAction)click_home:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count;
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"alarmcell";
    
    TraceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[TraceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.menuActionDelegate = self;
    }
    NSMutableArray *menuImgArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"icon_trash",@"stateNormal",@"icon_trash",@"stateHighLight", nil];
        [menuImgArr addObject:dic];
    }
    
    //    KBAlarm *device = _dataArray[indexPath.row];
    //    [cell setEditing:YES];
    [cell configWithData:indexPath menuData:menuImgArr cellFrame:CGRectMake(0, 0, 320, 150)];
//    [cell startMyEdit:_editing];
//    [cell setMySelected:[_selectedArray[indexPath.row] boolValue]];
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
}



@end
