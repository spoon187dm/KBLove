
#import "UIScrollView+TableRefresh.h"

/**

 . 添加头部控件的方法
 [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
 或者
 [self.tableView addHeaderWithCallback:^{ }];
 
 . 添加尾部控件的方法
 [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
 或者
 [self.tableView addFooterWithCallback:^{ }];
 
 . 可以在TableViewFreshConst.h和TableViewFreshConst.m文件中自定义显示的文字内容和文字颜色
 
 
 .自动进入刷新状态
 1> [self.tableView headerBeginRefreshing];
 2> [self.tableView footerBeginRefreshing];
 
 .结束刷新
 1> [self.tableView headerEndRefreshing];
 2> [self.tableView footerEndRefreshing];
*/