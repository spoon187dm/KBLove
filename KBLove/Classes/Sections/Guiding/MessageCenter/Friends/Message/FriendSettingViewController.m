//
//  FriendSettingViewController.m
//  KBLove
//
//  Created by 1124 on 14/11/7.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "FriendSettingViewController.h"
#import "FriendSetHeadView.h"
#import <UIImageView+AFNetworking.h>
#import "KBHttpRequestTool.h"
@interface FriendSettingViewController ()
{
    KBFriendInfo *_friendinf;
    FriendSetHeadView *_headerView;
}
@end

@implementation FriendSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)createUI
{
    //返回
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 25, 25) Target:self Selector:@selector(BackClick:) isLeft:YES];
    self.navigationItem.titleView=[self makeTitleLable:@"好友设置" AndFontSize:18 isBold:YES];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorColor=[UIColor whiteColor];
    UIImageView *bgimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圈子1"]];
    bgimgv.frame=_tableView.bounds;
    _tableView.backgroundView=bgimgv;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //创建头视图
    _headerView=[[[NSBundle mainBundle]loadNibNamed:@"FriendSetHeadView" owner:self options:nil]lastObject];
   // NSString *headurl=[NSString stringWithFormat:@""];
    [_headerView.FriendImageView setImageWithURL:[NSURL URLWithString:kUserImageFromName([KBUserInfo sharedInfo].user_id)] placeholderImage:[UIImage imageNamed:@"页面列表1_22"]];
    _headerView.RemarkLable.text=_friendinf.nick;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"圈子1"]];
    _tableView.tableHeaderView=_headerView;
    //创建底部视图
    UIView *BottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    UIButton *bottomBtn=[UIButton buttonWithFrame:CGRectMake(ScreenWidth/2-125, 20, 250, 40) title:@"删除好友" target:self Action:@selector(DeleteClick:)];
    [bottomBtn setTitleColor:[UIColor colorWithRed:19/255.0 green:136/255.0 blue:141/255.0 alpha:1] forState:UIControlStateNormal];
    //bottomBtn.titleLabel.textColor=[UIColor colorWithRed:19/255.0 green:136/255.0 blue:141/255.0 alpha:1];
    bottomBtn.backgroundColor=[UIColor whiteColor];
    bottomBtn.layer.cornerRadius=20;
    bottomBtn.layer.masksToBounds=YES;
    [BottomView addSubview:bottomBtn];
    // BottomView.backgroundColor=[UIColor redColor];
    _tableView.tableFooterView=BottomView;

    
}
- (void)setModel:(KBFriendInfo *)friendModel
{
    _friendinf=friendModel;
    [self createUI];
    [self loadDate];
    
}
- (void)loadDate
{
    //下载好友 所有 分享 信息,接口未给出
    
    
}
#pragma mark - DeleteFriend
- (void)DeleteClick:(UIButton *)btn
{
    //执行删除操作 删除后 进行 跳转
    KBUserInfo *user=[KBUserInfo sharedInfo];
    
    //KBFriendInfo *finf= _friendsListArray[cellIndexNum];
    NSDictionary *deldic=@{@"user_id":user.user_id,@"token":user.token,@"friend_id":_friendinf.id,@"app_name":app_name};
    [[KBHttpRequestTool sharedInstance]request:[DeleteFriendUrl] requestType:KBHttpRequestTypePost params:deldic cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            if([result isKindOfClass:[NSDictionary class]])
            {
                NSNumber *ret=[result objectForKey:@"ret"];
                if ([ret integerValue]==1) {
                    //成功
                    //[_friendsListArray removeObjectAtIndex:cellIndexNum];
                   // [self.tableView reloadData];
                    [UIAlertView showWithTitle:@"提示" Message:@"删除成功!" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                        
                    }];

                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else
                {
                    [UIAlertView showWithTitle:@"警告" Message:@"删除失败!" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                        
                    }];
                    
                }
            }else
            {
                NSLog(@"非字典类型");
            }
        }else
        {
            NSError *error=(NSError *)result;
            [UIAlertView showWithTitle:@"警告" Message:error.localizedDescription cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                
            }];
        }
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  nil;
}
- (void)BackClick:(UIButton *)btn
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
