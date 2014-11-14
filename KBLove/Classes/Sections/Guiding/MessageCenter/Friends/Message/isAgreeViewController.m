//
//  isAgreeViewController.m
//  KBLove
//
//  Created by 1124 on 14/11/12.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "isAgreeViewController.h"
#import <UIImageView+AFNetworking.h>
#import "KBHttpRequestTool.h"
@interface isAgreeViewController ()
{
    KBMessageInfo *_msg;
    KBFriendInfo *_finf;
}
@end

@implementation isAgreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)CreateUI
{
    _AgreeBtn.backgroundColor=[UIColor whiteColor];
    _AgreeBtn.layer.cornerRadius=15;
    _AgreeBtn.layer.masksToBounds=YES;
    _RejectBtn.layer.cornerRadius=15;
    _RejectBtn.backgroundColor=[UIColor whiteColor];
    _RejectBtn.layer.masksToBounds=YES;

    self.navigationItem.titleView=[self makeTitleLable:@"新朋友" AndFontSize:16 isBold:YES];
    //返回
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 20, 20) Target:self Selector:@selector(BackClick:) isLeft:YES];
    //请求好友头像
    [_FriendImageView setImageWithURL:[NSURL URLWithString:kUserImageFromName(_finf.id)] placeholderImage:kdefaultImage];
    _FriendName.text=_finf.name;
    _FriendDesLable.text=_msg.text;
    NSLog(@"%d",_msg.status);
    switch (_msg.status) {
        case KBMessageStatusAgree:{
            //同意
            _AgreeBtn.hidden=YES;
            _RejectBtn.hidden=YES;
            _ResultLable.hidden=NO;
            _ResultLable.text=@"已同意该请求";
        }break;
        case KBMessageStatusReject:{
            //拒绝
            _AgreeBtn.hidden=YES;
            _RejectBtn.hidden=YES;
            _ResultLable.hidden=NO;
            
            _ResultLable.text=@"已拒绝该请求";
        }break;
        case KBMessageStatusUnRead:{
            //未读
            _AgreeBtn.hidden=NO;
            _RejectBtn.hidden=NO;
            _ResultLable.hidden=YES;
        }break;
        case KBMessageStatusHaveRead:{
            //未读
            _AgreeBtn.hidden=NO;
            _RejectBtn.hidden=NO;
            _ResultLable.hidden=YES;
        }break;

        default:
            break;
    }

}
- (void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)configUIWithMesageModel:(KBMessageInfo *)msgModel AndFriendModel:(KBFriendInfo *)friendModel
{
    //配置相关属性
        //初始化数据
    _msg=msgModel;
    _finf=friendModel;
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

- (IBAction)RejectBtnClick:(id)sender {
    
    [self sendCmdWithTag:1];
    
}
- (IBAction)agreeBtnClick:(id)sender {
    
    [self sendCmdWithTag:0];
}
- (void)sendCmdWithTag:(NSInteger)tag
{
    KBUserInfo *user=[KBUserInfo sharedInfo];
    NSDictionary *dic=@{@"user_id":user.user_id,@"token":user.token,@"app_name":app_name,@"friend_id":_msg.FromUser_id,@"is_pass":[NSNumber numberWithInteger:(tag+1)]};
    [[KBHttpRequestTool sharedInstance] request:[Circle_SendIsAGreeFriendMessage_URL] requestType:KBHttpRequestTypePost params:dic cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            //已经同意修改信息状态
            NSNumber *ret=[result objectForKey:@"ret"];
            if ([ret integerValue]==1) {
                switch (tag) {
                    case 0:{
                        //同意成功修改状态
                        _msg.status=KBMessageStatusAgree;
                        [[KBDBManager shareManager]updateKBMessageWithModel:_msg];
                        
                    }break;
                    case 1:{
                        //拒绝成功
                        _msg.status=KBMessageStatusReject;
                        [[KBDBManager shareManager]updateKBMessageWithModel:_msg];

                    }break;
                        
                    default:
                        break;
                }
            }else
            {
                [UIAlertView showWithTitle:@"提示" Message:[NSString stringWithFormat:@"操作失败:%@",[result objectForKey:@"desc"]] cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                    
                }];
   
            }
        }else
        {
            //失败 提示
            NSError *error=(NSError *)result;
            [UIAlertView showWithTitle:@"提示" Message:[NSString stringWithFormat:@"操作失败:%@",error.localizedDescription] cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                
            }];
        }
    }];
}
@end
