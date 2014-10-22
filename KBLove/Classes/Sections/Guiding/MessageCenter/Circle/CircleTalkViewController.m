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
#import "CircleSettingViewController.h"
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
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 25, 25) Target:self Selector:@selector(BackClick:) isLeft:YES];
    self.navigationItem.titleView=[self makeTitleLable:@"北航吃货群" AndFontSize:18 isBold:NO];
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
            [_tableView reloadData];
            if (_dataArray.count) {
                [_tableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }


        }
    } AndDelegate:self];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //_tableView.backgroundColor=[UIColor clearColor];
    UIImageView *bgimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圈子1"]];
    bgimgv.frame=_tableView.bounds;
    _tableView.backgroundView=bgimgv;

    [self.view addSubview:_tableView];
    [self.view addSubview:_sendMsgView];
    //注册通知中心接受消息
    [_sendMsgView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    self.view.userInteractionEnabled=YES;
    //添加收键盘手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(ReceiveKeyBoardClick:)];
    [_tableView addGestureRecognizer:tap];
    //添加圈子设置按钮，如果是圈子则点击
    if(_talkType==KBTalkEnvironmentTypeCircle)
    {
        UIButton *btn1=[self MakeButtonWithBgImgName:@"圈子位置2_03" SelectedImg:@"" Frame:CGRectMake(0, 0, 30, 24) target:self Sel:@selector(SettingClick:) AndTag:100];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn1];
        
    }
}
- (void)dealloc
{
    [_sendMsgView removeObserver:self forKeyPath:@"frame"];
}
#pragma mark - 设置界面
- (void)SettingClick:(UIButton *)btn
{
    //跳转到相应界面
    CircleSettingViewController *cvc=[[CircleSettingViewController alloc]init];
    [cvc setCircle_id:_tid];
    [self.navigationController pushViewController:cvc animated:YES];
}
#pragma mark - 修改Title
- (void)viewWillAppear:(BOOL)animated
{
    //从网络请求相应圈子信息，设置标题
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    _tableView.frame=CGRectMake(0, 0, self.view.frame.size.width, _sendMsgView.frame.origin.y);
   // [_tableView reloadData];
    if (_dataArray.count) {
        [_tableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
#pragma mark - 返回事件
- (void)BackClick:(UIButton *)btn
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}
#pragma mark - 通知中心接受消息
- (void)ReceiveCircleMsg
{
    //从数据库获取信息
    //判断是否是当前聊天对象
    
}
- (void)ReceiveFriendMsg
{
    //判断是否是当前聊天对象
}
#pragma mark - 加载历史信息
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
#pragma mark - 收键盘
- (void)ReceiveKeyBoardClick:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}
#pragma mark - UItableViewDateSource
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
    [cell configleftImage:[UIImage imageNamed:@"userimage"]  rightImage:[UIImage imageNamed:@"userimage"]  Message:_dataArray[indexPath.row] WithPath:indexPath AndBlock:^(NSIndexPath *path) {
        KBMessageInfo *msgin=_dataArray[path.row];
        if (msgin.MessageType==KBMessageTypeTalkText) {
            NSLog(@"%@被点击了",msgin.text);
        }else if(msgin.MessageType==KBMessageTypeTalkImage)
        {
            NSLog(@"图片");
        }
    }];
    
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
