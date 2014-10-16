//
//  CreateCircleViewController.m
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CreateCircleViewController.h"
#import "KBHttpRequestTool.h"
#import "KBFriendInfo.h"
#import "CircleFriendCell.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "CreateCircleBottomView.h"
@interface CreateCircleViewController ()
{
    UISearchBar *_searchBar;//搜索条
    UISearchDisplayController *_playCintroller;//搜索控制器
    NSMutableArray *_resultArray;//存放搜索结果
    NSMutableArray *_selectArray;
    NSMutableArray *_allDataArray;
    CreateCircleBottomView *_bottomView;
}
@end

@implementation CreateCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    [self loadData];
    // Do any additional setup after loading the view.
}
- (void)CreateUI
{
    self.navigationItem.titleView=[self makeTitleLable:@"创建圈子" AndFontSize:22 isBold:YES];
    //返回
    [self addBarItemWithImageName:@"NVBar_arrow_left.png" frame:CGRectMake(0, 0, 30, 30) Target:self Selector:@selector(BackClick:) isLeft:YES];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundView=[UIImageView imageViewWithFrame:_tableView.bounds image:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:_tableView];
    //设置头尾视图，显示在第一行的上方
    _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)]
    ;
    _searchBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    _searchBar.delegate=self;
    _tableView.tableHeaderView=_searchBar;
    //创建搜索控制器，传入一个搜索条，点击搜索条，可以触发VC的搜索模式，搜索模式作用在Self上,
    
    _playCintroller =[[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    //此时程序中有两个TableView；
    _playCintroller.searchResultsDelegate=self;
    _playCintroller.searchResultsDataSource=self;
    _playCintroller.searchResultsTableView.backgroundView=[UIImageView imageViewWithFrame:_tableView.bounds image:[UIImage imageNamed:@"background.png"]];
    _selectArray =[[NSMutableArray alloc]init];
    _bottomView=[[CreateCircleBottomView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height, ScreenWidth, 0)];
    _bottomView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:_bottomView];
    
}

- (void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 下载数据
- (void)loadData
{
    if (!_allDataArray) {
        _allDataArray=[[NSMutableArray alloc]init];
    }
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
     for (NSInteger i='A'; i<='Z'+1; i++) {
        [_dataArray addObject:[NSMutableArray array]];
         KBFriendInfo *finfo=[[KBFriendInfo alloc]init];
         if (i<='Z') {
             //此处是假数据 上线时需删掉
             
             finfo.name=[NSString stringWithFormat:@"%c",(unichar)i];
             //[_dataArray[i-'A'] addObject:finfo];
             
         }else
         {
           finfo.name=@"董新";
         }
         [_allDataArray addObject:finfo
          ];
                }
        
         //[_dataArray addObject:[NSMutableArray array]];
    }
    if (!_selectArray) {
        _selectArray=[[NSMutableArray alloc]init];
    }
    if (!_resultArray) {
        _resultArray=[[NSMutableArray alloc]init];
    }
    KBUserInfo *user=[KBUserInfo sharedInfo];
    NSString *Urlstr=[NSString stringWithFormat:FriendList_URL,user.user_id,user.token,53];
    [KBFreash startRefreshWithTitle:@"努力加载中..." inView:_tableView];
    [[KBHttpRequestTool sharedInstance] request:Urlstr requestType:KBHttpRequestTypeGet params:nil cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                if ([[result objectForKey:@"ret"] integerValue]==1) {
                    NSArray *friedArray=[result objectForKey:@"userList"];
                    for (NSDictionary *infoDic in friedArray) {
                        KBFriendInfo *info=[[KBFriendInfo alloc]init];
                        [info setValuesForKeysWithDictionary:infoDic];
                        [_allDataArray addObject:info];
                    }
                    [self ConfigData:_allDataArray];
                    
                }else
                {
                    [UIAlertView showWithTitle:@"提示" Message:@"数据请求失败"  cancle:@"确定" otherbutton:nil     block:^(NSInteger index) {
                        
                    }];
                }
                
                
            }else
            {
                NSLog(@"数据解析错误 From CreateCircle");
            }
        }else
        {
            [UIAlertView showWithTitle:@"提示" Message:[(NSError *)result localizedDescription]  cancle:@"确定" otherbutton:nil     block:^(NSInteger index) {
                
            }];
        }
        [KBFreash StopRefreshinView:_tableView];
       // [_tableView reloadData];
    }];
}
//将数据分类
#pragma mark - 将数据分类
- (void)ConfigData:(NSArray *)array
{
    for (int i=0; i<array.count; i++) {
        BOOL IsIn=NO;
        KBFriendInfo *finfo=array[i];
        for (int j='A'; j<='Z'; j++) {
            NSString *sotr=[[PinYinForObjc chineseConvertToPinYin:finfo.name] lowercaseString];
            if ([sotr hasPrefix:[[NSString stringWithFormat:@"%c",j] lowercaseString]]) {
                
                [_dataArray[j-'A'] addObject:finfo];
                IsIn=YES;
            }
        }
        if (!IsIn) {
            [[_dataArray lastObject] addObject:finfo];
        }
    }
    [_tableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_tableView==tableView) {
        return _dataArray.count;
        // return _allDataArray.count;
    }else
    {
        
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return 0;
    if (_tableView==tableView) {
        return [_dataArray[section] count];
       
    }else
    {
        
        return _resultArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellTag=@"CircleFriendCell";
    CircleFriendCell *cell=[tableView dequeueReusableCellWithIdentifier:cellTag];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:cellTag owner:self options:nil]lastObject];
    }
    
    if (_tableView==tableView) {
        KBFriendInfo *finfo=_dataArray[indexPath.section][indexPath.row];
        [cell configUIWithModel:finfo Path:indexPath isSleect:[_selectArray containsObject:finfo] andBlock:^(NSIndexPath *patn, BOOL isselect) {
            
            KBFriendInfo *ff=_dataArray[patn.section][patn.row];
            if (isselect) {
                
                if (![_selectArray containsObject:ff]) {
                    [_selectArray addObject:ff];
                }
                //添加移动动画
                
                
            }else
            {
                [_selectArray removeObject:ff];
            }
            [self refreshBottomWithArray];
        }];      //  cell.CircleFriendName.text=finfo.name;
        
    }else
    {
        KBFriendInfo *finfo=_resultArray[indexPath.row];
        //cell.CircleFriendName.text=finfo.name;
        [cell configUIWithModel:finfo Path:indexPath isSleect:[_selectArray containsObject:finfo] andBlock:^(NSIndexPath *patn, BOOL isselect) {
            KBFriendInfo *ff=_resultArray[patn.row];
            if (isselect) {
                
                if (![_selectArray containsObject:ff]) {
                    [_selectArray addObject:ff];
                }
                
            }else
            {
                [_selectArray removeObject:ff];
            }
            [self refreshBottomWithArray];
        }];
       
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)refreshBottomWithArray
{
//    [_bottomView ConfigUIWith:_selectArray AndBlock:^(NSInteger tag) {
//        NSLog(@"%ld",tag);
//    }];
    [_tableView reloadData];
    [_bottomView ConfigUIWith:_selectArray AndBlock:^(NSInteger tag) {
        KBFriendInfo *finf=_selectArray[tag];
        [_selectArray removeObject:finf];
        [self refreshBottomWithArray];
        
    } AndFinishedBlock:^{
        NSLog(@"创建群组");
    }];
    _tableView.frame= CGRectMake(0, 0,ScreenWidth,ScreenHeight-_bottomView.frame.size.height);
}
#pragma mark - UITableViewDelegate
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView!=_tableView) {
        return nil;
    }
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    //系统预置字符串，tableview会把它处理成搜索小图标
    [arr addObject:UITableViewIndexSearch];
    for (int i='A'; i<='Z'; i++) {
        [arr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    return arr;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    la.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    la.text=[NSString stringWithFormat:@"%c",(UniChar )(section+'A')];
    if (section==26) {
        la.text=@"其他";
    }
    return la;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if(tableView==_tableView&&[_dataArray[section] count]>0)
    {

    return 20;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (!_resultArray) {
        _resultArray=[[NSMutableArray alloc]init];
    }
    [_resultArray removeAllObjects];
    if (_searchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_searchBar.text]) {
        for (int i=0; i<_allDataArray.count; i++) {
            KBFriendInfo *info=_allDataArray[i];
            NSString *searchstr=info.name;
            if ([ChineseInclude isIncludeChineseInString:searchstr]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:searchstr];
                NSRange titleResult=[tempPinYinStr rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    
                    if (![_resultArray containsObject:info]) {
                        [_resultArray addObject:info];
                    }
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:searchstr];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    if (![_resultArray containsObject:info]) {
                        [_resultArray addObject:info];
                    }
                    
                }
            }
            else {
                NSRange titleResult=[searchstr rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [_resultArray addObject:info];
                }
            }
        }
    } else if (_searchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:_searchBar.text]) {
        for (KBFriendInfo *info in _allDataArray) {
            NSString *tempStr=info.name;
            NSRange titleResult=[tempStr rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [_resultArray addObject:info];
            }
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //返回正确的下标，Title是被选中的索引标题，index是索引标题数组的下标
    //return -1不会引起滚动
    return  index-1;
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
