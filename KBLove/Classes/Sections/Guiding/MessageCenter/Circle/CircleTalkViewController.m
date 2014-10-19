//
//  CircleTalkViewController.m
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleTalkViewController.h"
#import "SendMessageView.h"
#import "MessageCell.h"
@interface CircleTalkViewController ()
{
    KBTalkEnvironmentType _talkType;
    NSString *_tid;
    SendMessageView *_sendMsgView;
}
@end

@implementation CircleTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self CreateUI];
    // Do any additional setup after loading the view.
}
- (void)setTalkEnvironment:(KBTalkEnvironmentType)type andId:(NSString *)tid
{
    _talkType=type;
    _tid=tid;
    [self CreateUI];
    [self loadData];
}
- (void)CreateUI
{
    //self.automaticallyAdjustsScrollViewInsets=YES;
    //返回
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 30, 30) Target:self Selector:@selector(BackClick:) isLeft:YES];
    self.navigationItem.titleView=[self makeTitleLable:@"好友" AndFontSize:14 isBold:YES];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    _sendMsgView=[[[NSBundle mainBundle]loadNibNamed:@"SendMessageView" owner:self options:nil]lastObject];
    _sendMsgView.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
    [_sendMsgView setBlock:^(KBMessageInfo *msg) {
        //发送相应消息
        msg.FromUser_id=[KBUserInfo sharedInfo].user_id;
        msg.TalkEnvironmentType=_talkType;
        msg.time=[NSString TimeJabLong];
        
        if(msg.TalkEnvironmentType==KBTalkEnvironmentTypeFriend)
        {
            //给好友发送信息
            
            
        }else if(msg.TalkEnvironmentType==KBTalkEnvironmentTypeCircle)
        {
            //发送给圈子
            [_dataArray addObject:msg];
            KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
            msginf.TalkEnvironmentType=KBTalkEnvironmentTypeCircle;
            msginf.FromUser_id=@"14022";
            msginf.ToUser_id=[KBUserInfo sharedInfo].user_id;
            msginf.text=@"圈子测试返回信息";
            [_dataArray addObject:msginf];
            if (_dataArray.count) {
                [_tableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }

            [_tableView reloadData];
        }
    } AndDelegate:self];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //_tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    [self.view addSubview:_sendMsgView];
    //注册通知中心接受消息
    [_sendMsgView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)dealloc
{
    [_sendMsgView removeObserver:self forKeyPath:@"frame"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    _tableView.frame=CGRectMake(0, 0, self.view.frame.size.width, _sendMsgView.frame.origin.y);
    if (_dataArray.count) {
        [_tableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)BackClick:(UIButton *)btn
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}

- (void)ReceiveCircleMsg
{
    //判断是否是当前聊天对象
}
- (void)ReceiveFriendMsg
{
    //判断是否是当前聊天对象
}
- (void)loadData
{
    if(!_dataArray)
    {
        _dataArray=[[NSMutableArray alloc]init];
        
    }
    //从数据库读取当期圈子或者朋友；聊天记录存入数据
    if(_talkType==KBTalkEnvironmentTypeCircle)
    {
        
    }else if(_talkType==KBTalkEnvironmentTypeFriend)
    {
        
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellTag=@"MessageCell";
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellTag];
    if (cell==nil) {
        cell=[[MessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellTag];
    }
    [cell configleftImage:[UIImage imageNamed:@"loginQQ"] rightImage:[UIImage imageNamed:@"loginQQ"] Message:_dataArray[indexPath.row]];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell=[[MessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@""];
    return [cell getHightWithMOdel:_dataArray[indexPath.row]];
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
