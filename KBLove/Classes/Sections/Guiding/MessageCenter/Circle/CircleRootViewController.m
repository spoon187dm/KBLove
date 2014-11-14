//
//  CircleRootViewController.m
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CircleRootViewController.h"

@interface CircleRootViewController ()

@end

@implementation CircleRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav_Circle"] forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
    
}
- (UIButton *)MakeButtonWithBgImgName:(NSString *)img SelectedImg:(NSString *)simg  Frame:(CGRect)frame target:(id)tar Sel:(SEL)selector AndTag:(NSInteger) tag
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=frame;
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:simg] forState:UIControlStateHighlighted];
    btn.tag=tag;
    [btn addTarget:tar action:selector forControlEvents:UIControlEventTouchUpInside];
    return  btn;
}
- (UILabel *)makeTitleLable:(NSString *)title AndFontSize:(NSInteger)size isBold:(BOOL)isb
{
    UILabel *lable=[[UILabel alloc]init];
    lable.text=title;
    [lable setTextColor:[UIColor whiteColor]];
    if (isb) {
        lable.font=[UIFont boldSystemFontOfSize:size];
    }else{
        lable.font=[UIFont systemFontOfSize:size];
    }
    
    CGSize lsize=[title sizeWithAttributes:@{NSFontAttributeName:lable.font}];
    lable.frame=CGRectMake(0, 0, lsize.width, lsize.height);
    return lable;
}
- (void) addBarItemWithImageName:(NSString *)img frame:(CGRect)frame Target:(id)tar Selector:(SEL)selector ToArray:(NSMutableArray *)array andTag:(NSInteger) tag
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    btn.tag=tag;
    
    [btn addTarget:tar action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    [array addObject:item];
    //[view addSubview:btn];
}
- (void)addBarItemWithImageName:(NSString *)img frame:(CGRect)frame  Target:(id) tar Selector:(SEL)selector isLeft:(BOOL)isleft
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    if (isleft) {
        self.navigationItem.leftBarButtonItem=item;
    }else
    {
        self.navigationItem.rightBarButtonItem=item;
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
