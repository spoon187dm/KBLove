//
//  KBDBManager.h
//  KBLove
//
//  Created by DX on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBMessageInfo.h"
#import "FMDatabase.h"

@interface KBDBManager : NSObject
//取得数据库单例
+ (KBDBManager *)shareManager;
//获取某种类型的最后一条消息
//插入数据
-(void)insertDataWithModel:(id)obj;
//删除指定类型数据
- (void)DeleteKBMessageWithType:(KBMessageType )msgtype;
//删除与某人的聊天记录
- (void)DeleteKBMessageWithEnvironment:(KBTalkEnvironmentType)talkType AndUserID:(NSString *)user_id;
//获取与某人的聊天信息,倒叙排列
- (NSArray *)GetKBTalkMessageWithEnvironment:(KBTalkEnvironmentType)talkType FriendID:(NSString *)user_id AndPage:(NSInteger)page Number:(NSInteger)number;
//更新信息
- (void)updateKBMessageWithModel:(KBMessageInfo *)msg;
@end
