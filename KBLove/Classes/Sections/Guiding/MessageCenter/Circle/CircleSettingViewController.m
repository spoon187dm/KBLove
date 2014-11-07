//
//  CircleSettingViewController.m
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleSettingViewController.h"
#import "CreateCircleBottomView.h"
//#import "DeleteCircleManagerViewController.h"
#import "DXSwitch.h"
#import "KBCircleInfo.h"
#import "KBFriendInfo.h"
#import "KBHttpRequestTool.h"
#import "CreateCircleViewController.h"
@interface CircleSettingViewController ()
{
    NSString *_circleId;
    CreateCircleBottomView *_headerView;
    UILabel *Circle_Name_Lable;
    UILabel *Circle_NickName_Lable;
    DXSwitch *Circle_Switch;
    DXSwitch *Circle_TalkMessageSwitch;
    KBCircleInfo *circle_info;
    NSMutableArray *members;
    KBFriendInfo *myinf;
    //UIButton *QuitBtn;
    BOOL isDelete;
}
@end

@implementation CircleSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//初始化id
- (void)setCircle_id:(NSString *)cid
{
    _circleId=cid;
    [self CreateUI];
    
}
- (void)setCircleModel:(KBCircleInfo *)model
{
    circle_info=model;
    [self CreateUI];
    [self loadData];
}
#pragma mark - 初始化界面
- (void)CreateUI
{
    isDelete=NO;
    //self.view.backgroundColor=[UIColor redColor];
    //返回
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 25, 25) Target:self Selector:@selector(BackClick:) isLeft:YES];
//    [self addBarItemWithImageName:@"Circle_setting" frame:CGRectMake(0, 0, 20, 20) Target:self Selector:@selector(SettingClick:) isLeft:NO];
    self.navigationItem.titleView=[self makeTitleLable:circle_info.name AndFontSize:18 isBold:YES];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIImageView *bgimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圈子1"]];
    bgimgv.frame=_tableView.bounds;
    _tableView.backgroundView=bgimgv;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorColor=[UIColor
                               whiteColor];
   // _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIScrollView *scr=(UIScrollView *)_tableView;
    scr.bounces=NO;
    [self.view addSubview:_tableView];
    _headerView=[[CreateCircleBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    [_headerView.FinishedBtn setBackgroundImage:[UIImage imageNamed:@"圈子3_13"] forState:UIControlStateNormal];
    
    UIView *BottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    UIButton *bottomBtn=[UIButton buttonWithFrame:CGRectMake(ScreenWidth/2-125, 20, 250, 40) title:@"退出圈子" target:self Action:@selector(QuitClick:)];
    [bottomBtn setTitleColor:[UIColor colorWithRed:19/255.0 green:136/255.0 blue:141/255.0 alpha:1] forState:UIControlStateNormal];
    //bottomBtn.titleLabel.textColor=[UIColor colorWithRed:19/255.0 green:136/255.0 blue:141/255.0 alpha:1];
    bottomBtn.backgroundColor=[UIColor whiteColor];
    bottomBtn.layer.cornerRadius=20;
    bottomBtn.layer.masksToBounds=YES;
    [BottomView addSubview:bottomBtn];
   // BottomView.backgroundColor=[UIColor redColor];
    _tableView.tableFooterView=BottomView;
    

}
#pragma  mark - 退出
- (void)QuitClick:(UIButton *)btn
{
    KBUserInfo *info = [KBUserInfo sharedInfo];
    NSLog(@"点击了退出");
    NSString *Myid=[NSString stringWithFormat:@"%@",info.user_id];
   // NSLog(@"%@",Myid);
    NSString *createID=[NSString stringWithFormat:@"%@",[circle_info.userId stringValue]];
  //  NSLog(@"%@",createID);
    if ([Myid isEqualToString:createID]) {
        //是创建者 删除群
        [self DeleteCircle];
    }else
    {
        //不是创建者 退出群
        //判断是不是剩下一个人 如果是则删除群
        if (members.count>1) {
            //执行删除群组操作
            [self DeleteCircle];
        }else
        {
            //删除某个成员
            [self DeleteSeleFromCirclr];
        }
    }
    
}
- (void)DeleteCircle
{
    KBUserInfo *user=[KBUserInfo sharedInfo];
    NSString *deleteUrlStr=[Circle_Delete_URL,user.user_id,user.token,circle_info.id];
    NSLog(@"Delete:%@",deleteUrlStr);
    [[KBHttpRequestTool sharedInstance] request:deleteUrlStr requestType:KBHttpRequestTypeGet params:nil cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
         //成功删除 进行跳转
            [self goToCirclrListViewController];
        }else
        {
            NSError *error=(NSError *)result;
            [UIAlertView showWithTitle:@"温馨提示" Message:error.localizedDescription cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                
            }];
        }
    }];

}
#pragma mark - 退出方法
- (void)DeleteSeleFromCirclr
{
    KBUserInfo *user=[KBUserInfo sharedInfo];
    NSString *deletestr=[Circle_DeleteMember_URL,user.user_id,user.token,circle_info.id,user.user_id];
    [[KBHttpRequestTool sharedInstance] request:deletestr requestType:KBHttpRequestTypeGet params:nil cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            //删除好友成功
            if ([[result objectForKey:@"ret"] integerValue]==1) {
                //成功删除进行跳转
                [self goToCirclrListViewController];
            }else
            {
            }
        }else
        {
            NSError *error=(NSError *)result;
          [UIAlertView showWithTitle:@"温馨提示" Message:error.localizedDescription     cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
              
          }];
        }
    }];
}
#pragma mark - 跳转到圈子界面
- (void)goToCirclrListViewController
{
    
    [self.navigationController popToViewController: self.navigationController.childViewControllers[1] animated:YES];
}
#pragma mark - 返回
- (void)BackClick:(UIButton *)btn
{
    if (![Circle_Name_Lable.text isEqualToString:circle_info.name]||![Circle_NickName_Lable.text isEqualToString:myinf.nick]) {
        
        KBUserInfo *user=[KBUserInfo sharedInfo];
        NSDictionary *dic=@{@"user_id":user.user_id,@"token":user.token,@"group_id":[circle_info.id stringValue] ,@"group_name":Circle_Name_Lable.text,@"nick_name":@"Circle_NickName_Lable.text,",@"app_name":@"M2616_BD"};
        [[KBHttpRequestTool sharedInstance]request:[Circle_UpDate_URL] requestType:KBHttpRequestTypePost params:dic cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
            if (IsSuccess) {
                NSLog(@"修改成功");
            }else
            {
                //?user_id=%@&token=%@&group_id=%@&group_name=%@&nick_name=%@,app_name=%@
                NSError *error=(NSError *)result;
                
              [UIAlertView  showWithTitle:@"提示" Message:[NSString stringWithFormat:@"信息修改失败%@",error.localizedDescription]cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                  
              }];
            }
        }];
 
    }
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}
#pragma mark - 设置
//- (void)SettingClick:(UIButton *)btn
//{
//    //跳转到删除好友界面
//    DeleteCircleManagerViewController *dvc=[[DeleteCircleManagerViewController alloc]init];
//    [dvc setCircleModel:circle_info];
//    [self.navigationController pushViewController:dvc animated:YES];
//    
//    
//}

#pragma mark - 下载数据
- (void)loadData
{

    if (!members) {
        members=[[NSMutableArray alloc]init];
    }
    [KBFreash startRefreshWithTitle:@"加载中..." inView:self.view];
    //加载群成员信息
    NSString *urlPath=[Circle_GetAllMember_URL,[KBUserInfo sharedInfo].user_id,[KBUserInfo sharedInfo].token,[circle_info.id stringValue]];
    NSLog(@"%@",urlPath);
   [[KBHttpRequestTool sharedInstance]request:urlPath requestType:KBHttpRequestTypeGet params:nil cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
       [KBFreash StopRefreshinView:self.view];
       if (IsSuccess) {
           if([result isKindOfClass:[NSDictionary class]])
           {
             //  NSDictionary *dic=(NSDictionary *)result;
               if ([[result objectForKey:@"ret"] integerValue]==1) {
                   
                   NSArray *arr=[result objectForKey:@"member"];
                   for (NSDictionary *sdic in arr) {
                       KBFriendInfo *kf=[[KBFriendInfo alloc]init];
                       kf.id=[[sdic objectForKey:@"userId"] stringValue];
                       if ([kf.id isEqualToString:[KBUserInfo sharedInfo].user_id]) {
                           //circle_info
                           myinf =kf;
                           }
                       kf.nick=[sdic objectForKey:@"nickName"];
                       kf.name=kf.id;
                       [members addObject:kf];
                       
//                       if (members.count==11) {
//                           break;
//                       }
                   }
                   
                   [self refreashHeaderView];
               }
               
           }else
           {
               NSLog(@"非字典类型 in CircleSetting");
           }
       }else
       {
           NSError *error=(NSError *)result;
           [UIAlertView showWithTitle:@"温馨提示" Message:error.localizedDescription cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
               
           }];
       }
   }];
    
}
- (void)refreashHeaderView
{
    //
    NSMutableArray *FinishedArr=[[NSMutableArray alloc]init];
    NSString *createId=[NSString stringWithFormat:@"%@",circle_info.userId];
    NSString *myid=[NSString stringWithFormat:@"%@",[KBUserInfo sharedInfo].user_id];
    [FinishedArr addObject:@"圈子3_13"];
    if ([createId isEqualToString:myid]) {
      [FinishedArr addObject:@"圈子3_13"];
    }
    [_headerView configUIWithFriendArray:members FinishedBtnArray:FinishedArr AndBlock:^(NSInteger tag) {
        if (tag<members.count) {
            //好友详细信息
        }else
        {
            switch (tag-members.count) {
                case 0:{
                //添加好友
                    CreateCircleViewController *cvc=[[CreateCircleViewController alloc]init];
                    [cvc setMembers:members andCircleID:[circle_info.id stringValue]];
                    [self.navigationController pushViewController:cvc animated:YES];
                }break;
                case 1:{
                //删除好友
                    isDelete=!isDelete;
                    [self refreashHeaderView];
                }break;
                
                default:
                    break;
            }
        }
        
    } AndFinishedBlock:^(NSInteger tag) {
        NSLog(@"将要删除%ld位好友",(long)tag);
        KBFriendInfo *finf=members[tag];
        NSString *deleteUrl=[Circle_DeleteMember_URL,[KBUserInfo sharedInfo].user_id,[KBUserInfo sharedInfo].token,[circle_info.id stringValue],finf.id];
        NSLog(@"%@",deleteUrl);
        [KBFreash startRefreshWithTitle:@"删除中...." inView:self.view];
        [[KBHttpRequestTool sharedInstance]request:deleteUrl requestType:KBHttpRequestTypeGet params:nil cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
            if (IsSuccess) {
                [KBFreash StopRefreshinView:self.view];
                if([result isKindOfClass:[NSDictionary class]])
                {
                    //  NSDictionary *dic=(NSDictionary *)result;
                    if ([[result objectForKey:@"ret"] integerValue]==1) {
                        //删除成功
                        [members removeObject:finf];
                        [self refreashHeaderView];
                        
                        // [self loadData];
                    }else
                    {
                        [UIAlertView showWithTitle:@"温馨提示" Message:[result objectForKey:@"desc"] cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                            
                        }];
                        
                    }
                    
                }else
                {
                    NSLog(@"非字典类型 in CircleSetting");
                }
                
            }else
            {
                NSError *error=(NSError *)result;
                [UIAlertView showWithTitle:@"温馨提示" Message:error.localizedDescription cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                    
                }];
            }
        }];

    } IsDelete:isDelete AndCircleUser_id:[circle_info.userId stringValue]];
    [_tableView reloadData];
 
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return section+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return _headerView.frame.size.height;
            break;
            
        default:
            break;
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellTag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellTag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellTag];
        
        if (indexPath.section==1) {
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text=@"圈子名字";
                    Circle_Name_Lable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-230, 10, 200,30)];
                    [Circle_Name_Lable setTextColor:[UIColor whiteColor]];
                    Circle_Name_Lable.text=circle_info.name;
                    Circle_Name_Lable.font=[UIFont boldSystemFontOfSize:16];
                    Circle_Name_Lable.textAlignment=NSTextAlignmentRight;
                    [cell.contentView addSubview:Circle_Name_Lable];
                    [self AddLineToCell:cell];
                    
                }break;
                case 1:{
                    cell.textLabel.text=@"我的小名";
                    Circle_NickName_Lable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-230, 10, 200,30)];
                    Circle_NickName_Lable.text=myinf.nick;
                    Circle_NickName_Lable.textAlignment=NSTextAlignmentRight;
                    [Circle_NickName_Lable setTextColor:[UIColor whiteColor]];
                    Circle_NickName_Lable.font=[UIFont boldSystemFontOfSize:16];
                    [cell.contentView addSubview:Circle_NickName_Lable];
                }break;

                    
                default:
                    break;
            }
        }else if(indexPath.section==2)
        {
            if (indexPath.row==0) {
              cell.textLabel.text=@"消息免打扰";
                Circle_Switch=[DXSwitch SwitchWithSlipColor:[UIColor colorWithRed:58/255.0 green:200/255.0 blue:204/255.0 alpha:1] OffSlipColor:[UIColor whiteColor] OnTintColor:[UIColor whiteColor] OffTintColor:[UIColor whiteColor] OnText:nil OffText:nil AndFrame:CGRectMake(ScreenWidth-70, 15, 40, 20)];
                [self AddLineToCell:cell];
//                Circle_Switch.onImage=[UIImage imageNamed:@"圈子3_21"];
//                Circle_Switch.offImage=[UIImage imageNamed:@"圈子3_25"];
                [cell.contentView addSubview:Circle_Switch];

            }else if(indexPath.row==1)
            {
              cell.textLabel.text=@"聊天记录";
                Circle_TalkMessageSwitch=[DXSwitch SwitchWithSlipColor:[UIColor colorWithRed:58/255.0 green:200/255.0 blue:204/255.0 alpha:1] OffSlipColor:[UIColor whiteColor] OnTintColor:[UIColor whiteColor] OffTintColor:[UIColor whiteColor] OnText:nil OffText:nil AndFrame:CGRectMake(ScreenWidth-70, 15, 40, 20)];
                [cell.contentView addSubview:Circle_TalkMessageSwitch];

            }else
            {
               cell.textLabel.text=@"发起位置共享";
            }
       [self AddLineToCell:cell];
        }else
        {
           // cell.textLabel.text=@"删除成员";
            [cell.contentView addSubview:_headerView];

        }
    }

    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    
    return cell;
}
- (void)AddLineToCell:(UITableViewCell *)cell
{
    UILabel *la=[UILabel labelWithFrame:CGRectMake(0, cell.frame.size.height+5, cell.frame.size.width, 1) text:nil];
    la.backgroundColor=[UIColor whiteColor];
    la.alpha=0.3;
    [cell.contentView addSubview:la];
}
- (UILabel *)LineLableWithFrame:(CGRect )frame AndColor:(UIColor *)color
{
    UILabel *la=[UILabel labelWithFrame:frame text:nil];
    la.backgroundColor=color;
    return la;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:{
        UIAlertView *al=[self createALertWithTitle:@"圈子名称" TAg:indexPath.row];
                [al show];
            }break;
            case 1:{
                UIAlertView *al=[self createALertWithTitle:@"我的小名" TAg:indexPath.row];
                [al show];
            }break;
            default:
                break;
        }

    }else if (indexPath.section==0)
    {
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   // return 0;
    if (section==0) {
        return 28;
    }
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    if (section==0) {
        view.image=[UIImage imageNamed:@"圈子3_06"];
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10,5, ScreenWidth, 20)];
        [lable setTextColor:[UIColor whiteColor]];
        
        lable.font=[UIFont boldSystemFontOfSize:14];
        lable.text=@"圈子成员";
        [view addSubview:lable];
//        UIButton *moreBtn=[UIButton buttonWithFrame:CGRectMake(ScreenWidth-60, 10, 20, 5) title:nil target:self Action:@selector(MoreClick:)];
//        [moreBtn setBackgroundImage:[UIImage imageNamed:@"圈子3_03"] forState:UIControlStateNormal];
//        view.userInteractionEnabled=YES;
//        [view addSubview:moreBtn];
  
    }else
    {
        view.image=[UIImage imageNamed:@"圈子3_16"];
    }
    return view;
}
- (void)MoreClick:(UIButton *)btn
{
    NSLog(@"查看更多成员");
}
- (UIAlertView *)createALertWithTitle:(NSString *)title TAg:(NSInteger )tag
{

    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    al.alertViewStyle=UIAlertViewStylePlainTextInput;
    al.tag=tag;
    al.delegate=self;
    UITextField *textf=[al textFieldAtIndex:0];
    textf.keyboardType=UIKeyboardTypeDefault;
    textf.returnKeyType=UIReturnKeyGo;
    return al;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        return;
    }
    UITextField *text=[alertView textFieldAtIndex:0];
    switch (alertView.tag) {
        case 0:{
            Circle_Name_Lable.text=text.text;
            NSLog(@"%@",text.text);
        }break;
        case 1:
        {
            Circle_NickName_Lable.text=text.text;
        }
            
        default:
            break;
    }
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
