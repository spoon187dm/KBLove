
#import "UIScrollView+TableRefresh.h"

/**
 @Author block
 
 使用说明
 
 
 */

/**
  添加下拉刷新回调的方法
 [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
 或者
 [self.tableView addHeaderWithCallback:^{ }];
 
 添加上拉加载回调的方法
 [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
 或者
 [self.tableView addFooterWithCallback:^{ }];
 
 可以在TableViewFreshConst.h和TableViewFreshConst.m文件中自定义显示的文字内容和文字颜色
 
 
 自动进入刷新状态
 [self.tableView headerBeginRefreshing];
 [self.tableView footerBeginRefreshing];
 
 .结束刷新
 [self.tableView headerEndRefreshing];
 [self.tableView footerEndRefreshing];
*/

/**
 若要修改刷新控件
 修改下拉图片在TableRefresh.bundle下地图片文件即可，注意保持名字不变
 
 修改下拉刷新文字提示在TableRefreshBaseView中修改statusLabel
 
 修改刷新时间提示在 TableRefreshFooterView 或者 TableRefreshHeaderView 中 lastUpdateTimeLabel属性
 */