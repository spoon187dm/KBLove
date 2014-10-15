//
//  DeviceListViewController.h
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TableMenuViewController.h"

@interface DeviceListViewController : TableMenuViewController<UITableViewDataSource,UITableViewDelegate>

-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum;

@end
