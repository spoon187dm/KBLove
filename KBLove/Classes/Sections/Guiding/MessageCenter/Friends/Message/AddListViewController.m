//
//  AddListViewController.m
//  KBLove
//
//  Created by 1124 on 14/11/12.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AddListViewController.h"
#import "KBHttpRequestTool.h"
#import "AddListTableViewCell.h"
#import "isAgreeViewController.h"
@interface AddListViewController ()
{
    NSMutableArray *_addFriendList;
    NSMutableArray *_friendsListArray;
}
@end

@implementation AddListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadData];
    // Do any additional setup after loading the view.
}
- (void)createUI
{
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav_Circle"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView=[self makeTitleLable:@"新朋友" AndFontSize:16 isBold:YES];
    //返回
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 20, 20) Target:self Selector:@selector(BackClick:) isLeft:YES];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorColor=[UIColor whiteColor];
    UIImageView *bgimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圈子1"]];
    bgimgv.frame=_tableView.bounds;
    _tableView.backgroundView=bgimgv;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    UINib *nib=[UINib nibWithNibName:@"AddListTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"AddListTableViewCell"];
    
}
- (void)loadData
{
    if (!_friendsListArray) {
        _friendsListArray=[[NSMutableArray alloc]init];
    }
    if (!_addFriendList) {
        _addFriendList=[[NSMutableArray alloc]init];
    }
    //获取所有添加请求
    [_addFriendList addObjectsFromArray:[[KBDBManager shareManager] getAllRequestList]];
    for (int i=0; i<_addFriendList.count; i++) {
        KBMessageInfo *msgin=_addFriendList[i];
        msgin.status=KBMessageStatusHaveRead;
        [[KBDBManager shareManager]updateKBMessageWithModel:msgin];
    }
    //下载好友信息
    NSString *user_id = [KBUserInfo sharedInfo].user_id;
    //拿到token
    NSString *token = [KBUserInfo sharedInfo].token;
    //请求好友列表
    [KBFreash startRefreshWithTitle:@"加载..." inView:self.view];
    //NSLog(@"%@",friendlisturl);
    [[KBHttpRequestTool sharedInstance] request:[NSString stringWithFormat:FriendList_URL,user_id,token,53] requestType:KBHttpRequestTypeGet params:nil overBlock:^(BOOL IsSuccess, id result) {
        //isloadfriend=YES;
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
                [_tableView reloadData];
            } else {//如果返回的结果不是dic
                
            }
        } else { //如果失败
            
        }
    }];

    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addFriendList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellTag=@"AddListTableViewCell";
    AddListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellTag forIndexPath:indexPath];
    [cell configUIWithMesageModel:_addFriendList[indexPath.row] AndFriendModel:[self getFriendModelWith:_addFriendList[indexPath.row]] WithBlock:^(UIButton *btn) {
        NSLog(@"你同意了");
        //添加同意链接修改对应状态
        
    }];
    cell.backgroundColor=[UIColor clearColor];
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (KBFriendInfo *)getFriendModelWith:(KBMessageInfo *)msgModel
{
    NSString *fromid=[NSString stringWithFormat:@"%@",msgModel.FromUser_id];
    for (KBFriendInfo *find in _friendsListArray) {
        NSString *fid=[NSString stringWithFormat:@"%@",find.id];
        if ([fid isEqualToString:fromid]) {
            return find;
        }
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KBMessageInfo *msginf=_addFriendList[indexPath.row];
    isAgreeViewController *ivc=[[isAgreeViewController alloc]initWithNibName:@"isAgreeViewController" bundle:nil];
    [ivc configUIWithMesageModel:msginf AndFriendModel:[self getFriendModelWith:msginf]];
    [self.navigationController pushViewController:ivc animated:YES];
    
}
- (void)BackClick:(UIButton *)brn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
