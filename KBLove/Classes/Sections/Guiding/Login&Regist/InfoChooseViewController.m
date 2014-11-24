//
//  InfoChooseViewController.m
//  KBLove
//
//  Created by yuri on 14-11-19.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "InfoChooseViewController.h"

@interface InfoChooseViewController () <UITableViewDataSource, UITableViewDelegate>
/** 头部标题*/
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
/** 头部输入栏*/
@property (weak, nonatomic) IBOutlet UITextField *headerField;

@property (weak, nonatomic) IBOutlet UIButton *headerSearch;
/** 尾部标题*/
@property (weak, nonatomic) IBOutlet UILabel *footerTitle;
/** 尾部输入栏*/
@property (weak, nonatomic) IBOutlet UITextField *footerField;
@property (weak, nonatomic) IBOutlet UIButton *footerSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** tableView数据数组*/
@property (nonatomic, strong) NSMutableArray *dataArr;

- (IBAction)headerBtnClick:(id)sender;
- (IBAction)footerBtnClick:(id)sender;

@end

@implementation InfoChooseViewController

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] initWithObjects:@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha",@"hahha", nil];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"infoChooseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)headerBtnClick:(id)sender {
}

- (IBAction)footerBtnClick:(id)sender {
}
@end
