//
//  UITableViewController+WLTool.m
//  KBLove
//
//  Created by block on 14/11/5.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UITableViewController+WLTool.h"

@implementation UITableViewController (WLTool)

/**
 将self.view从UITableView修改为uiview。
 */
- (void)replaceSelfViewToNormal{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *tableview = self.tableView;
    UIView *newview = [[UIView alloc]initWithFrame:self.view.frame];
    newview.backgroundColor = [UIColor blackColor];
    self.view = newview;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    [newview addSubview:tableview];
}

@end
