//
//  DeviceTableViewController.m
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DeviceTableViewController.h"
#import "DevicesCell.h"
@interface DeviceTableViewController ()

@end

@implementation DeviceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark 分组数设置
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}
#pragma mark 行数设置
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 ;
}
#pragma mark 表格单元数据填充
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* CellIdentifier = @"deviceCell" ;
    //d从缓存池中回收
    DevicesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //未找到可重用对象，实例化新的cell
    if (cell == nil) {
        cell = [[DevicesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //设置表格单元格内容
    // TODO: 设置单元格
    cell.delegate = self;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//row中删除按钮和设置按钮的代理方法
#pragma mark * DAContextMenuCell delegate
//删除
- (void)contextMenuCellDidSelectDeleteOption:(DAContextMenuCell *)cell
{
    [super contextMenuCellDidSelectDeleteOption:cell];
    //删除cell所对应的数据
//    [_friendsListArray removeObjectAtIndex:[self.tableView indexPathForCell:cell].row];
    //删除相应cell
//    [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationAutomatic];
#warning 同时向服务器发送消息删除该好友
    //目前暂时没有接口
    
}
//设置
- (void)contextMenuCellDidSelectMoreOption:(DAContextMenuCell *)cell
{
    
}

@end
