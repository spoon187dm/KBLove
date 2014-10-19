//
//  CircleViewController.m
//  KBLove
// 圈子界面
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleViewController.h"
#import "CreateCircleViewController.h"
#import "LoginRequest.h"
#import "KBHttpRequestTool.h"
#import "CircleTalkViewController.h"
@interface CircleViewController ()

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self Login];
    [self CreateUI];
   // [self loadData];
    // Do any additional setup after loading the view.
}
-  (void)CreateUI
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.titleView=[self makeTitleLable:@"圈子" AndFontSize:22 isBold:YES];
    //返回
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 30, 30) Target:self Selector:@selector(BackClick:) isLeft:YES];
    //添加群组按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddClick:)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    //初始化 Tableview
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - 模拟登陆 做测试
//临时方法 模拟登陆 做测试
- (void)Login
{
    [[LoginRequest shareInstance] requestWithUserName:@"18236582321" andPassWord:@"123456" andLoginFinishedBlock:^{
        //成功后跳转
        [self loadData];
       // [SVProgressHUD dismiss];
        NSLog(@"登陆成功");
    } andLoginFaildeBlock:^(NSString *desc) {
       // [SVProgressHUD dismiss];
        //展示错误信息
//        [self createAlertViewWithTitile:@"温馨提示" andMessage:desc];
    }];
}
//添加群组
- (void)AddClick:(UIBarButtonItem *)item
{
//    //测试接口
//    CircleTalkViewController * cvc=[[CircleTalkViewController alloc]init];
//    [self.navigationController pushViewController:cvc animated:YES];
    CreateCircleViewController *cvc=[[CreateCircleViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
    
}
//返回按钮
- (void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
//下载数据
- (void)loadData
{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    KBUserInfo *user=[KBUserInfo sharedInfo];
    NSLog(@"%@",[Circle_URL,user.user_id,user.token]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  nil;
}
#pragma mark - UITableDelegate
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
