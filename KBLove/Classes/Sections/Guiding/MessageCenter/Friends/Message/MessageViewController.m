//
//  MessageViewController.m
//  KBLove
//
//  Created by 1124 on 14/11/8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "MessageViewController.h"
#import "KBHttpRequestTool.h"
#import "KBFriendInfo.h"
#import "DxConnection.h"
#import "KBCircleInfo.h"
#import "CircleCell.h"
#import "MessageListCell.h"
#import "CircleTalkViewController.h"
@interface MessageViewController ()
{
    NSMutableArray *_friendsListArray;
    NSMutableArray *_circle_listArray;
    NSMutableArray *_MsgListArray;
    BOOL isloadfriend;
    BOOL isloadCircle;
}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadData];
    // Do any additional setup after loading the view.
}
- (void)createUI
{
    self.isAllowScroll=TableIsForbiddenScroll;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav_Circle"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden=NO;
    //返回
    
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 25, 25) Target:self Selector:@selector(BackClick:) isLeft:YES];
    self.navigationItem.titleView=[self makeTitleLable:@"消息" AndFontSize:18 isBold:YES];
    UIImageView *bgimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圈子1"]];
    bgimgv.frame=self.tableView.bounds;
    self.tableView.backgroundView=bgimgv;
    self.tableView.separatorColor=[UIColor whiteColor];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //注册cell
//    UINib *nib=[UINib nibWithNibName:@"CircleCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"CircleCell"];
}
- (void)loadData
{
    isloadfriend=NO;
    isloadCircle=NO;
    if (!_friendsListArray) {
        _friendsListArray=[[NSMutableArray alloc]init];
    }
    if (!_circle_listArray) {
        _circle_listArray=[[NSMutableArray alloc]init];
    }
    if (!_MsgListArray) {
        _MsgListArray=[[NSMutableArray alloc]init];
    }
    [_MsgListArray addObjectsFromArray:[[KBDBManager shareManager] getMessageList]];
    
    [_friendsListArray removeAllObjects];
    [_circle_listArray removeAllObjects];
    //拿到user_id
    NSString *user_id = [KBUserInfo sharedInfo].user_id;
    //拿到token
    NSString *token = [KBUserInfo sharedInfo].token;
    //请求好友列表
    [KBFreash startRefreshWithTitle:@"加载..." inView:self.view];
    NSString *friendlisturl=[NSString stringWithFormat:FriendList_URL,user_id,token,53];
    NSLog(@"%@",friendlisturl);
    [[KBHttpRequestTool sharedInstance] request:[NSString stringWithFormat:FriendList_URL,user_id,token,53] requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
        isloadfriend=YES;
        if (isloadfriend&&isloadCircle) {
            [KBFreash StopRefreshinView:self.view];
        }
        
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
    //加载圈子数据
    KBUserInfo *user=[KBUserInfo sharedInfo];
    NSLog(@"%@",[Circle_URL,user.user_id,user.token]);
    // [KBFreash startRefreshWithTitle:@"努力加载中..." inView:self.view];
    [[KBHttpRequestTool sharedInstance] request:[Circle_URL,user.user_id,user.token] requestType:KBHttpRequestTypeGet params:nil cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        isloadCircle=YES;
        if (isloadCircle&&isloadfriend) {
            [KBFreash StopRefreshinView:self.view];
        }
        
        if (IsSuccess) {
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic=(NSDictionary *)result;
                NSLog(@"%@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
                NSArray *CircleList=[dic objectForKey:@"group"];
                for (NSDictionary *sdic in CircleList) {
                    KBCircleInfo *cinf=[[KBCircleInfo alloc]init];
                    [cinf setValuesForKeysWithDictionary:sdic];
                    [_circle_listArray addObject:cinf];
                    
                }
                [self.tableView reloadData];
            }else
            {
                NSLog(@"非字典类型");
            }
        }else
        {
            NSError *error=(NSError *)result;
            NSLog(@"%@",error.localizedDescription);
        }
    }];

}
//从好友列表中获取相应模型
- (KBFriendInfo *)getFriendInfWithID:(NSString *)user_id
{
    for (KBFriendInfo *friend in _friendsListArray) {
        if ([[NSString stringWithFormat:@"%@",friend.id] isEqualToString:[NSString stringWithFormat:@"%@",user_id]]) {
            return friend;
        }
    }
    return nil;
}
//从圈子列表中获取相应模型
- (KBCircleInfo *)getCircleInfWithID:(NSString *)circle_id
{
    for (KBCircleInfo *circle in _circle_listArray) {
        if ([[NSString stringWithFormat:@"%@",[circle.id stringValue] ] isEqualToString:[NSString stringWithFormat:@"%@",circle_id]]) {
            return circle;
        }
 
    }
    return nil;
}


- (void)BackClick:(UIButton *)btn
{
[self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addBarItemWithImageName:(NSString *)img frame:(CGRect)frame  Target:(id) tar Selector:(SEL)selector isLeft:(BOOL)isleft
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    if (isleft) {
        self.navigationItem.leftBarButtonItem=item;
    }else
    {
        self.navigationItem.rightBarButtonItem=item;
    }
    
}
#pragma mark * Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MsgListArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier=@"Cell";
    KBMessageInfo *msginf=_MsgListArray[indexPath.row];
    MessageListCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
        cell=[[MessageListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.menuActionDelegate=self;


    }
    NSMutableArray *menuImgArr = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"icon_trash",@"stateNormal",@"icon_trash",@"stateHighLight", nil];
    if (msginf.MessageType==KBMessageTypeAddFriend||msginf.MessageType==KBMessageTypeAgreeFriend||msginf.MessageType==KBMessageTypeRejectFriend) {}{
    [menuImgArr addObject:dic];
    }
    // [menuImgArr addObject:dic1];
    
    
    //KBDevices *device = _dataArray[indexPath.row];
    
    [cell configWithData:indexPath menuData:menuImgArr cellFrame:CGRectMake(0, 0, 320, 70)];
    if (msginf.TalkEnvironmentType==KBTalkEnvironmentTypeCircle) {
        KBCircleInfo *circleinf=[self getCircleInfWithID:msginf.Circle_id];
        [cell configDateWithCircleModel:circleinf];
        
    }else
    {
        if (msginf.MessageType==KBMessageTypeAddFriend||msginf.MessageType==KBMessageTypeAgreeFriend||msginf.MessageType==KBMessageTypeRejectFriend) {
            [cell configDateWithAddFrienMsg:msginf];
        }else
        {
            NSString *fromId=[NSString stringWithFormat:@"%@",msginf.FromUser_id];
            
            NSString *friendid;
            if ([fromId isEqualToString:[NSString stringWithFormat:@"%@",[KBUserInfo sharedInfo].user_id]]) {
                friendid=[NSString stringWithFormat:@"%@",msginf.ToUser_id];
            }else
            {
                friendid=fromId;
            }
            [cell configDateWithFriendModel:[self getFriendInfWithID:friendid]];
        }
    }
    
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
    KBMessageInfo *msginf=_MsgListArray[indexPath.row];
    
    if (msginf.TalkEnvironmentType==KBTalkEnvironmentTypeCircle) {
        KBCircleInfo *circleinf=[self getCircleInfWithID:msginf.Circle_id];
        CircleTalkViewController *cvc=[[CircleTalkViewController alloc]init];
        [cvc setTalkEnvironment:KBTalkEnvironmentTypeCircle andModel:circleinf];
        [self.navigationController pushViewController:cvc animated:YES];
        
    }else
    {
        if (msginf.MessageType==KBMessageTypeAddFriend||msginf.MessageType==KBMessageTypeAgreeFriend||msginf.MessageType==KBMessageTypeRejectFriend) {
            //跳转到请求消息界面
        }else
        {
            NSString *fromId=[NSString stringWithFormat:@"%@",msginf.FromUser_id];
            
            NSString *friendid;
            if ([fromId isEqualToString:[NSString stringWithFormat:@"%@",[KBUserInfo sharedInfo].user_id]]) {
                friendid=[NSString stringWithFormat:@"%@",msginf.ToUser_id];
            }else
            {
                friendid=fromId;
            }
            CircleTalkViewController *cvc=[[CircleTalkViewController alloc]init];
            [cvc setTalkEnvironment:KBTalkEnvironmentTypeFriend andModel:[self getFriendInfWithID:friendid]];
            [self.navigationController pushViewController:cvc animated:YES];
            
        }
    }

    //[self.tableView reloadData];


    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
#pragma mark - menuActionDelegate
- (void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum
{
    NSLog(@"%d",menuIndexNum);

    
    KBMessageInfo *msginf=_MsgListArray[cellIndexNum];
    
    if (msginf.TalkEnvironmentType==KBTalkEnvironmentTypeCircle) {
        [[KBDBManager shareManager] DeleteKBMessageWithEnvironment:msginf.TalkEnvironmentType AndUserID:msginf.Circle_id];
    }else
    {
        if (msginf.MessageType==KBMessageTypeAddFriend||msginf.MessageType==KBMessageTypeAgreeFriend||msginf.MessageType==KBMessageTypeRejectFriend) {
            //跳转到请求消息界面
            
        }else
        {
            NSString *fromId=[NSString stringWithFormat:@"%@",msginf.FromUser_id];
            
            NSString *friendid;
            if ([fromId isEqualToString:[NSString stringWithFormat:@"%@",[KBUserInfo sharedInfo].user_id]]) {
                friendid=[NSString stringWithFormat:@"%@",msginf.ToUser_id];
            }else
            {
                friendid=fromId;
            }
            NSLog(@"%@",friendid);
            [[KBDBManager shareManager] DeleteKBMessageWithEnvironment:msginf.TalkEnvironmentType AndUserID:friendid];
            
            
        }
    }
    [_MsgListArray removeObject:msginf];
    [self.tableView reloadData];
    
}
- (UILabel *)makeTitleLable:(NSString *)title AndFontSize:(NSInteger)size isBold:(BOOL)isb
{
    UILabel *lable=[[UILabel alloc]init];
    lable.text=title;
    [lable setTextColor:[UIColor whiteColor]];
    if (isb) {
        lable.font=[UIFont boldSystemFontOfSize:size];
    }else{
        lable.font=[UIFont systemFontOfSize:size];
    }
    
    CGSize lsize=[title sizeWithAttributes:@{NSFontAttributeName:lable.font}];
    lable.frame=CGRectMake(0, 0, lsize.width, lsize.height);
    return lable;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
