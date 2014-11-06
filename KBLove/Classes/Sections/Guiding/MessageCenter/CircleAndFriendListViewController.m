//
//  CircleAndFriendListViewController.m
//  KBLove
//
//  Created by 1124 on 14/11/3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleAndFriendListViewController.h"
#import "KBFriendInfo.h"
#import "KBHttpRequestTool.h"
#import "CircleTalkViewController.h"
#import "CreateCircleViewController.h"
#import "KBCircleInfo.h"
#import "CircleCell.h"
#import "CircleTalkViewController.h"

@interface CircleAndFriendListViewController ()
{
    UIView *_titleView;
    UIView *_listView;
    NSMutableArray *_friendsListArray;
    NSMutableArray *_circle_listArray;
    UIButton *_circleBtn;
    UIButton *_FriendBtn;
    UIButton *_createBtn;
    UIButton *_addBtn;
    BOOL isloadfriend;
    BOOL isloadCircle;

}
@end

@implementation CircleAndFriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    //[self loadData];
    // Do any additional setup after loading the view.
}
- (void)CreateUI
{
    self.isAllowScroll=TableIsForbiddenScroll;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav_Circle"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.titleView=_titleView;
    //返回
    
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 25, 25) Target:self Selector:@selector(BackClick:) isLeft:YES];
    //添加群组按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:[self MakeButtonWithBgImgName:@"Nav_down_arrow" SelectedImg:@"Nav_up_arrow " Frame:CGRectMake(0, 0, 25, 25) target:self Sel:@selector(AddClick:) AndTag:100]];
    //_headerView
    _titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    _titleView.userInteractionEnabled=YES;
    _FriendBtn=[UIButton buttonWithFrame:CGRectMake(0, 10, 80, 30) title:@"朋友" target:self Action:@selector(SelectClick:)];
    _FriendBtn.tag=200;
    _FriendBtn.selected=YES;
    _circleBtn=[UIButton buttonWithFrame:CGRectMake(80, 10, 80, 30) title:@"圈子" target:self Action:@selector(SelectClick:)];
    _circleBtn.tag=201;
    
    UIImage *Circle_image=[UIImage imageNamed:@"手机注册_04"];
    //我们需要把图像翻转180度
    UIImage *Friend_image=[UIImage imageWithCGImage:Circle_image.CGImage scale:2 orientation:UIImageOrientationUpMirrored];
    UIImage *friend_selected_image=[UIImage imageNamed:@"手机注册_03"];
    UIImage *circle_selected_image=[UIImage imageWithCGImage:friend_selected_image.CGImage scale:2 orientation:UIImageOrientationUpMirrored];
    [_circleBtn setBackgroundImage:Circle_image forState:UIControlStateNormal];
    [_circleBtn setBackgroundImage:circle_selected_image forState:UIControlStateSelected];
    [_FriendBtn setBackgroundImage:Friend_image forState:UIControlStateNormal];
    [_FriendBtn setBackgroundImage:friend_selected_image forState:UIControlStateSelected];
    //_circleBtn setTitleColor:[uicor] forState:<#(UIControlState)#>
    [_titleView addSubview:_FriendBtn];
    [_titleView addSubview:_circleBtn];
    self.navigationItem.titleView=_titleView;
    
    _listView=[[UIView alloc]initWithFrame:CGRectMake(0,44,self.view.frame.size.width , 40)];
    _listView.userInteractionEnabled=YES;
    _addBtn=[UIButton buttonWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 40) title:@"添加朋友" target:self Action:@selector(SelectClick:)];
    _addBtn.tag=202;
    _addBtn.selected=YES;
    _createBtn=[UIButton buttonWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 40) title:@"创建圈子" target:self Action:@selector(SelectClick:)];
    _createBtn.tag=203;
    _listView.backgroundColor=[UIColor whiteColor];
    [_listView addSubview:_createBtn];
    [_listView addSubview:_addBtn];
    
    //self.tableView.tableHeaderView=_listView;

    UIImageView *bgimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圈子1"]];
    bgimgv.frame=self.tableView.bounds;
    self.tableView.backgroundView=bgimgv;
    self.tableView.separatorColor=[UIColor whiteColor];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    
}
- (void)SelectClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 200:{
         //好友
            _FriendBtn.selected=YES;
            _circleBtn.selected=NO;
            [self.tableView reloadData];
            //添加好友信息刷新视图
        }break;
        case 201:{
         //圈子
            _FriendBtn.selected=NO;
            _circleBtn.selected=YES;
            [self.tableView reloadData];
            //添加好友信息刷新视图

        }break;
        case 202:{
         //添加好友跳转到添加好友界面
            UIStoryboard *stb = [UIStoryboard storyboardWithName:@"FriendsStoryBoard" bundle:nil];
            UIViewController *vc = [stb instantiateViewControllerWithIdentifier:@"AddFriendViewController"];
            [self.navigationController pushViewController:vc animated:YES];

        }break;
        case 203:{
        //创建圈子跳转到创建界面
            CreateCircleViewController *cvc=[[CreateCircleViewController alloc]init];
            [self.navigationController pushViewController:cvc animated:YES];

        }break;
            
        default:
            break;
    }
}
- (void)AddClick:(UIButton *)btn
{
    if (btn.selected) {
        //_listView.hidden=YES;
        self.tableView.tableHeaderView=nil;
        [self.tableView reloadData];
    }else
    {
        self.tableView.tableHeaderView=_listView;
        [self.tableView reloadData];
    }
    btn.selected=!btn.selected;
}
- (void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - 下载数据 
- (void)loadData
{
    isloadfriend=NO;
    isloadfriend=NO;
    if (!_friendsListArray) {
        _friendsListArray=[[NSMutableArray alloc]init];
    }
    if (!_circle_listArray) {
        _circle_listArray=[[NSMutableArray alloc]init];
    }
    [_friendsListArray removeAllObjects];
    [_circle_listArray removeAllObjects];
    //拿到user_id
    NSString *user_id = [KBUserInfo sharedInfo].user_id;
    //拿到token
    NSString *token = [KBUserInfo sharedInfo].token;
    //请求好友列表
    [KBFreash startRefreshWithTitle:@"加载..." inView:self.view];
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
    if (_FriendBtn.selected) {
     return _friendsListArray.count;
    }else if (_circleBtn.selected)
    {
    return _circle_listArray.count;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if (_FriendBtn.selected) {
       CellIdentifier = @"FriendListCell";
    }else
    {
       CellIdentifier=@"CircleCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        if (_FriendBtn.selected) {
            cell=[[FriendListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            FriendListCell *fcell=(FriendListCell *)cell;
            fcell.menuActionDelegate=self;
        }else
        {
          cell=[[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil]lastObject];
        }

    }
    if (_FriendBtn.selected) {
        FriendListCell *fcell=(FriendListCell *)cell;
        KBFriendInfo *friendInfo = _friendsListArray[indexPath.row];
        NSMutableArray *menuImgArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 2; i++) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"icon_trash",@"stateNormal",@"icon_trash",@"stateHighLight", nil];
            [menuImgArr addObject:dic];
        }
        
        //KBDevices *device = _dataArray[indexPath.row];
        
        [fcell configWithData:indexPath menuData:menuImgArr cellFrame:CGRectMake(0, 0, 320, 70)];
        [fcell configDateWithModel:friendInfo];
    }else
    {
        CircleCell *ccell=(CircleCell *)cell;
        KBCircleInfo *cinf=_circle_listArray[indexPath.row];
        
        [ccell ConfigWithModel:cinf];
        
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
    if (_FriendBtn.selected) {
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
    }else
    {
        KBCircleInfo *cinf=_circle_listArray[indexPath.row];
        CircleTalkViewController *cvc=[[CircleTalkViewController alloc]init];
        
        [cvc setTalkEnvironment:KBTalkEnvironmentTypeCircle andModel:cinf];
        [self.navigationController pushViewController:cvc animated:YES];

    }
}

#pragma mark - menuActionDelegate
- (void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum
{
    NSLog(@"%d",menuIndexNum);
}

- (UIButton *)MakeButtonWithBgImgName:(NSString *)img SelectedImg:(NSString *)simg  Frame:(CGRect)frame target:(id)tar Sel:(SEL)selector AndTag:(NSInteger) tag
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:simg] forState:UIControlStateSelected];
    btn.tag=tag;
    [btn addTarget:tar action:selector forControlEvents:UIControlEventTouchUpInside];
    return  btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
  // [self.navigationController.navigationBar addSubview:_listView];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   // [_listView removeFromSuperview];
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
