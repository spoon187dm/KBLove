//
//  FriendsListTableViewController.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "FriendsListTableViewController.h"
#import "KBFriendInfo.h"
#import "KBHttpRequestTool.h"
#import "CircleTalkViewController.h"


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
    self.isAllowScroll = TableIsForbiddenScroll;
//    //向tableView注册cell
//    UINib *nib = [UINib nibWithNibName:@"FriendListCell" bundle:[NSBundle mainBundle]];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"FriendListCell"];
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
    [KBFreash startRefreshWithTitle:@"加载..." inView:self.view];
    [[KBHttpRequestTool sharedInstance] request:[NSString stringWithFormat:FriendList_URL,user_id,token,53] requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
        [KBFreash StopRefreshinView:self.view];
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
    static NSString *CellIdentifier = @"FriendListCell";
    FriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell=[[FriendListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.menuActionDelegate=self;
    }

    KBFriendInfo *friendInfo = _friendsListArray[indexPath.row];
    NSMutableArray *menuImgArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"icon_trash",@"stateNormal",@"icon_trash",@"stateHighLight", nil];
        [menuImgArr addObject:dic];
    }
    
    //KBDevices *device = _dataArray[indexPath.row];
    
    [cell configWithData:indexPath menuData:menuImgArr cellFrame:CGRectMake(0, 0, 320, 70)];
    [cell configDateWithModel:friendInfo];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isAllowScroll != TableIsScroll && self.isEditing) {
        return;
    }
    if (self.isAllowScroll == TableIsScroll && self.isEditing) {
        if (self.editingCellNum != -1 && indexPath.row == self.editingCellNum) {
            return;
        }
    }

    CircleTalkViewController *cvc=[[CircleTalkViewController alloc]init];
    [cvc setTalkEnvironment:KBTalkEnvironmentTypeFriend andModel:_friendsListArray[indexPath.row]];
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark - menuActionDelegate
- (void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum
{
    NSLog(@"%d",menuIndexNum);
}


//返回item点击事件
- (IBAction)leftItemClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addItemClicked:(id)sender {
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:nil];
    UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"AddFriendViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
