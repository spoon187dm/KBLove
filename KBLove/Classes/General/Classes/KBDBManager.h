//
//  KBDBManager.h
//  KBLove
//
//  Created by DX on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBDBManager : NSObject
//取得数据库单例
+ (KBDBManager *)shareManager;
//获取某种类型的最后一条消息

@end
