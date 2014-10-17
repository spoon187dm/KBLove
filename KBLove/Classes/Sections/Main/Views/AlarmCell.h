//
//  AlarmCell.h
//  KBLove
//
//  Created by block on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TableMenuCell.h"
@class KBAlarm;
@interface AlarmCell : TableMenuCell

/**
 @Author block, 10-17 12:10
 
 自己的开始编辑状态，非系统
 
 @param edit 是否开启
 */
- (void)startMyEdit:(BOOL)edit;


- (void)setMySelected:(BOOL)selected;
/**
 @Author block, 10-17 12:10
 
 使用model初始化界面
 
 @param alarm 数据
 */
- (void)setData:(KBAlarm *)alarm;

@end
