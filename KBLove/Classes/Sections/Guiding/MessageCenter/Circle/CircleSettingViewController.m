//
//  CircleSettingViewController.m
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleSettingViewController.h"
#import "CreateCircleBottomView.h"
#import "DeleteCircleManagerViewController.h"
@interface CircleSettingViewController ()
{
    NSString *_circleId;
    CreateCircleBottomView *_headerView;
    UILabel *Circle_Name_Lable;
    UILabel *Circle_NickName_Lable;
    UISwitch *Circle_Switch;
    UISwitch *Circle_TalkMessageSwitch;
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
#pragma mark - 初始化界面
- (void)CreateUI
{
    //self.view.backgroundColor=[UIColor redColor];
    //返回
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 30, 30) Target:self Selector:@selector(BackClick:) isLeft:YES];
    [self addBarItemWithImageName:@"Circle_setting" frame:CGRectMake(0, 0, 30, 30) Target:self Selector:@selector(SettingClick:) isLeft:NO];
    self.navigationItem.titleView=[self makeTitleLable:@"圈子详情 " AndFontSize:14 isBold:YES];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIImageView *bgimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圈子1"]];
    bgimgv.frame=_tableView.bounds;
    _tableView.backgroundView=bgimgv;

    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorColor=[UIColor
                               whiteColor];
   // _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIScrollView *scr=(UIScrollView *)_tableView;
    scr.bounces=NO;
    [self.view addSubview:_tableView];
    _headerView=[[CreateCircleBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [_headerView.FinishedBtn setBackgroundImage:[UIImage imageNamed:@"圈子3_13"] forState:UIControlStateNormal];
    //[_headerView.FinishedBtn setTitle:@"邀请" forState:UIControlStateNormal];
    //_tableView.tableHeaderView=_headerView;
    

}
#pragma mark - 返回
- (void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 设置
- (void)SettingClick:(UIButton *)btn
{
    //跳转到删除好友界面
    
}
- (void)loadData
{
    //加载群信息
    
    
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
    return 70;
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
                    Circle_Name_Lable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, 20, 80,30)];
                    Circle_Name_Lable.text=@"请输入名字";
                    Circle_Name_Lable.font=[UIFont boldSystemFontOfSize:14];
                    [cell.contentView addSubview:Circle_Name_Lable];
                    
                }break;
                case 1:{
                    cell.textLabel.text=@"我的小名";
                    Circle_NickName_Lable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, 20, 80,30)];
                    Circle_NickName_Lable.text=@"请输入名字";
                    Circle_NickName_Lable.font=[UIFont boldSystemFontOfSize:14];
                    [cell.contentView addSubview:Circle_NickName_Lable];
                }break;

                    
                default:
                    break;
            }
        }else if(indexPath.section==2)
        {
            if (indexPath.row==0) {
              cell.textLabel.text=@"消息免打扰";
                Circle_Switch=[[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-80, 20, 100, 20)];
                //Circle_Switch.
                [cell.contentView addSubview:Circle_Switch];

            }else if(indexPath.row==1)
            {
              cell.textLabel.text=@"聊天记录";
                Circle_TalkMessageSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-80, 20, 100, 20)];
                [cell.contentView addSubview:Circle_TalkMessageSwitch];
            }else
            {
               cell.textLabel.text=@"发起位置共享";
            }
            
        }else
        {
           // cell.textLabel.text=@"删除成员";

        }
    }

    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
        //跳转到删除好友界面
        DeleteCircleManagerViewController *dvc=[[DeleteCircleManagerViewController alloc]init];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 30;
    }
    return 20;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return _headerView;
//    }
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    view.backgroundColor=[UIColor
//                          clearColor];
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    re
//}
- (UIAlertView *)createALertWithTitle:(NSString *)title TAg:(NSInteger )tag
{

    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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
    if (buttonIndex==0) {
        return;
    }
    UITextField *text=[alertView textFieldAtIndex:0];
    switch (alertView.tag) {
        case 0:{
            NSLog(@"%@",text.text);
        }break;
        case 1:
        {
            
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
