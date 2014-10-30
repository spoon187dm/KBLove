//
//  DeleteCircleManagerViewController.m
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DeleteCircleManagerViewController.h"
#import "KBFriendInfo.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "KBHttpRequestTool.h"
#import "CircledeleteFriendCell.h"
#import <AFNetworking.h>
@interface DeleteCircleManagerViewController ()
{
    NSMutableArray *_allData;
    KBCircleInfo *_circle_info;
    NSMutableArray *_selectArray;
}
@end

@implementation DeleteCircleManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // AFHTTPRequestOperationManager
    // Do any additional setup after loading the view.
}
- (void)setCircleModel:(KBCircleInfo *)info
{
    _circle_info=info;
    [self CreateUI];
    [self loadData];
}
#pragma mark - 创建 UI
- (void)CreateUI
{
    
    //创建 头部信息
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 25, 25) Target:self Selector:@selector(BackClick:) isLeft:YES];
    [self addBarItemWithImageName:@"圈子创建_23" frame:CGRectMake(0, 0, 20, 20) Target:self Selector:@selector(DeleteClick:) isLeft:NO];
    self.navigationItem.titleView=[self makeTitleLable:@"删除成员" AndFontSize:18 isBold:YES];
    self.view.backgroundColor=[UIColor whiteColor];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIImageView *bgimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圈子1"]];
    bgimgv.frame=_tableView.bounds;
    _tableView.backgroundView=bgimgv;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];

}
#pragma mark - 删除成员
- (void)DeleteClick:(UIButton *)btn
{
    //确认删除成员,执行删除操作 ，进行 跳转
    NSMutableString *deleteMemberStr=[NSMutableString string];
    for (KBFriendInfo *finf in _selectArray) {
        if ([_selectArray indexOfObject:finf]==_selectArray.count-1) {
            [deleteMemberStr appendString:[NSString stringWithFormat:@"%@",finf.id]];
        }else
        {
            [deleteMemberStr appendString:[NSString stringWithFormat:@"%@,",finf.id]];
        }
        
    }
    NSString *deleteUrl=[Circle_DeleteMember_URL,[KBUserInfo sharedInfo].user_id,[KBUserInfo sharedInfo].token,[_circle_info.id stringValue],deleteMemberStr];
    NSLog(@"%@",deleteUrl);
    [[KBHttpRequestTool sharedInstance]request:[Circle_DeleteMember_URL,[KBUserInfo sharedInfo].user_id,[KBUserInfo sharedInfo].token,[_circle_info.id stringValue],deleteMemberStr]requestType:KBHttpRequestTypeGet params:nil cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            if([result isKindOfClass:[NSDictionary class]])
            {
                //  NSDictionary *dic=(NSDictionary *)result;
                if ([[result objectForKey:@"ret"] integerValue]==1) {
                   //删除成功
                    [UIAlertView showWithTitle:@"温馨提示" Message:@"删除成功" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
                        
                    }];
                    for (KBFriendInfo *finf in _selectArray) {
                        [_allData removeObject:finf];
                    }
                    [_dataArray removeAllObjects];
                    if (!_dataArray) {
                        _dataArray=[[NSMutableArray alloc]init];
                        //创建子数组
                        for (int i=0; i<28; i++) {
                            [_dataArray addObject:[NSMutableArray array]];
                        }
                    }
                    [_selectArray removeAllObjects];
                    [self ConfigData:_allData];

                    
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
}
- (void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - 下载数据
- (void)loadData
{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
        //创建子数组
        for (int i=0; i<28; i++) {
            [_dataArray addObject:[NSMutableArray array]];
        }
    }
    if (!_allData) {
        _allData=[[NSMutableArray alloc]init];
    }
    if (!_selectArray) {
        _selectArray=[[NSMutableArray alloc]init];
    }
    //下载数据
    NSString *urlPath=[Circle_GetAllMember_URL,[KBUserInfo sharedInfo].user_id,[KBUserInfo sharedInfo].token,[_circle_info.id stringValue]];
    NSLog(@"%@",urlPath);
    [[KBHttpRequestTool sharedInstance]request:urlPath requestType:KBHttpRequestTypeGet params:nil cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            if([result isKindOfClass:[NSDictionary class]])
            {
                //  NSDictionary *dic=(NSDictionary *)result;
                if ([[result objectForKey:@"ret"] integerValue]==1) {
                    
                    NSArray *arr=[result objectForKey:@"member"];
                    for (NSDictionary *sdic in arr) {
                        KBFriendInfo *kf=[[KBFriendInfo alloc]init];
                        kf.id=[[sdic objectForKey:@"userId"] stringValue];
                        kf.nick=[sdic objectForKey:@"nickName"];
                        kf.name=kf.id;
                        [_allData addObject:kf];
                    }
                    
                    [self ConfigData:_allData];

                    [_tableView reloadData];
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
//将数据分类
#pragma mark - 将数据分类
- (void)ConfigData:(NSArray *)array
{
    for (int i=0; i<array.count; i++) {
        BOOL IsIn=NO;
        KBFriendInfo *finfo=array[i];
        if ([finfo.id integerValue]==[[KBUserInfo sharedInfo].user_id integerValue]) {
            [_dataArray[0] addObject:finfo];
            
        }else{
        
        for (int j='A'; j<='Z'; j++) {
            NSString *sotr=[[PinYinForObjc chineseConvertToPinYin:finfo.name] lowercaseString];
            if ([sotr hasPrefix:[[NSString stringWithFormat:@"%c",j] lowercaseString]]) {
//                NSString *fid=[NSString stringWithFormat:@"%@",finfo.id];
//                KBUserInfo *user=[[KBUserInfo alloc]init];
//                NSLog(@"%ld",[finfo.id integerValue]);
//                NSLog(@"%ld",[[KBUserInfo sharedInfo].user_id integerValue]);
                //NSString *str
                                [_dataArray[j-'A'+1] addObject:finfo];
                IsIn=YES;
            }
        }
        if (!IsIn) {
            [[_dataArray lastObject] addObject:finfo];
        }
        }
    }
    [_tableView reloadData];
}
#pragma mark - UITableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellTag=@"CircledeleteFriendCell";
    CircledeleteFriendCell *cell=[tableView dequeueReusableCellWithIdentifier:cellTag];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:cellTag owner:self options:nil]lastObject];
        
    }
    KBFriendInfo *info=_dataArray[indexPath.section][indexPath.row];
    [cell configUIWithModel:info AndisSelect:[_selectArray containsObject:info]];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView==_tableView&&[_dataArray[section] count]>0)
    {
        return 30;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section!=0){
    KBFriendInfo *finf=_dataArray[indexPath.section][indexPath.row];
    BOOL isc=[_selectArray containsObject:finf];
    if (!isc) {
        [_selectArray addObject:finf];
    }else
    {
        [_selectArray removeObject:finf];
    }
    [_tableView reloadData];
    }else
    {
        
    }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *BgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    BgView.image=[UIImage imageNamed:@"圈子创建_10"];
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    la.backgroundColor=[UIColor clearColor];
    la.font=[UIFont systemFontOfSize:14];
    [la setTextColor:[UIColor whiteColor]];
    la.text=[NSString stringWithFormat:@"    %c",(UniChar )(section+'A'+1)];
    if (section==27) {
        la.text=@"其他";
    }
    if (section==0) {
        la.text=@"创建者";
    }
    [BgView addSubview:la];
    return BgView;
    
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
