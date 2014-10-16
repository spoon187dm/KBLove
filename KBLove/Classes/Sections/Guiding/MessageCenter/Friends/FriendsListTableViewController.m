//
//  FriendsListTableViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "FriendsListTableViewController.h"
#import "FriendsListCell.h"
#import "KBFriendInfo.h"
#import "KBHttpRequestTool.h"

@interface FriendsListTableViewController ()
{
    NSMutableArray *_friendsListArray;//好友列表数据源
}

@end

@implementation FriendsListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数组
    _friendsListArray = [[NSMutableArray alloc] init];
    
    //向tableView注册cell
    UINib *nib = [UINib nibWithNibName:@"FriendsListCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FriendsListCell"];
    //加载数据
    [self loadData];
    
}

#pragma mark - loadData
//获取好友数据
- (void)loadData {
    //拿到user_id
    NSString *user_id = [KBUserInfo sharedInfo].user_id;
    //拿到token
    NSString *token = [KBUserInfo sharedInfo].token;
    //请求好友列表
    [[KBHttpRequestTool sharedInstance] request:[NSString stringWithFormat:FriendList_URL,user_id,token,53] requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {//如果成功
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *root = (NSDictionary *)result;
                for (NSDictionary *dic in root[@"userList"]) {
                    KBFriendInfo *friendInfo = [[KBFriendInfo alloc] init];
                    [friendInfo setValuesForKeysWithDictionary:dic];
                    [_friendsListArray addObject:friendInfo];
                }
                //刷新表
                [self.tableView reloadData];
            } else {//如果返回的结果不是dic
            
            }
        } else { //如果失败
            
        }
    }];
}

#pragma mark * Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _friendsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendsListCell";
    FriendsListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    KBFriendInfo *friendInfo = _friendsListArray[indexPath.row];
    cell.friendNameLabel.text = friendInfo.name;
    [cell setMoreOptionsButtonBg:@"bluecircle.png" anddeleteButtonBg:@"yellowcircle.png"];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//row中删除按钮和设置按钮的代理方法
#pragma mark * DAContextMenuCell delegate
//删除
- (void)contextMenuCellDidSelectDeleteOption:(DAContextMenuCell *)cell
{
    [super contextMenuCellDidSelectDeleteOption:cell];
    //删除cell所对应的数据
    [_friendsListArray removeObjectAtIndex:[self.tableView indexPathForCell:cell].row];
    //删除相应cell
    [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationAutomatic];
#warning 同时向服务器发送消息删除该好友
    //目前暂时没有接口
    
}
//设置
- (void)contextMenuCellDidSelectMoreOption:(DAContextMenuCell *)cell
{
    
}


//返回item点击事件
- (IBAction)leftItemClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)addItemClicked:(id)sender {
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:nil];
    UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"AddFriendViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
