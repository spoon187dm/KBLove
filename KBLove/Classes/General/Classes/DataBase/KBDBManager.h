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
//数据库回调函数，result返回数据，isSuccess表示是否成功
#define KBresult @"result"
#define KBisSuccess @"isSuccess"
typedef NS_ENUM(NSInteger,ResultType)
{
    Success,
    Faile
};
typedef void (^FinishedBlock)(id result,BOOL isSuccess);
@interface KBDBManager : NSObject
//取得数据库单例

+ (KBDBManager *)shareManager;
//获取某种类型的最后一条消息
//插入数据
- (void)insertDataWithModel:(id)obj;
//- (void)insertDataWithModel:(id)obj AndFinishedBlock:(FinishedBlock)insertBlock;
//删除指定类型数据
- (void)DeleteKBMessageWithType:(KBMessageType )msgtype;
//删除与某人的聊天记录
- (void)DeleteKBMessageWithEnvironment:(KBTalkEnvironmentType)talkType AndUserID:(NSString *)user_id;
//获取与某人的聊天信息,倒叙排列
- (NSArray *)GetKBTalkMessageWithEnvironment:(KBTalkEnvironmentType)talkType FriendID:(NSString *)user_id AndPage:(NSInteger)page Number:(NSInteger)number;
//更新信息
- (void)updateKBMessageWithModel:(KBMessageInfo *)msg;
//获取最后一条信息
- (KBMessageInfo *)getLastMsgWithEnvironment:(KBTalkEnvironmentType)talkType AndFromID:(NSString *)user_id;
- (BOOL)isExistInDateBase:(id)model;
//获取未读消息个数
- (NSInteger)getUnreadMessageCountWithTalkEnvironment:(KBTalkEnvironmentType)talktype TalkID:(NSString *)tagid andMessageType:(KBMessageType)msgtype;
//获取消息列表
- (NSArray *)getMessageList;
//获取·所有好友添加信息
- (NSArray *)getAllRequestList;

@end
