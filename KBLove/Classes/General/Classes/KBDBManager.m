//
//  KBDBManager.m
//  KBLove
//
//  Created by 1124 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBDBManager.h"
#import "KBMessageInfo.h"
#import <FMDatabase.h>
@implementation KBDBManager
{
    FMDatabase *_dataBase;
}
static KBDBManager *manager;
+ (KBDBManager *)shareManager
{
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager=[[KBDBManager alloc]init];
        });
    }
    return manager;
}
- (id)init
{
    self=[super init];
    if (self) {
        NSString *path=[NSHomeDirectory() stringByAppendingFormat:@"/Documents/KB.db"];
        _dataBase=[[FMDatabase alloc]initWithPath:path];
        if ([_dataBase open]) {
            //创建消息表
            NSString *createMsgTable=@"create table if not exists KBMessageList(TalkEnvironmentType integer,MessageType integer,status integer,Circle_id char(255),FromUser_id char(255),ToUser_id char(255),text char(255),image varchar(2000),time bigint primary key)";
            if(![_dataBase executeUpdate:createMsgTable]){
                NSLog(@"create KBMessageList error:%@!",_dataBase.lastErrorMessage);
            }
            
        }
    }
    return self;
}
//插入数据
-(void)insertDataWithModel:(id)obj
{
    if ([obj isKindOfClass:[KBMessageInfo class]]) {
        KBMessageInfo *msgModel=(KBMessageInfo *)obj;
        NSString *insert=@"insert into KBMessageList values(?,?,?,?,?,?,?,?,?)";
        NSString *imageStr=[[NSString alloc]initWithData:UIImagePNGRepresentation(msgModel.image) encoding:NSUTF8StringEncoding];
        if (![_dataBase executeQuery:insert,msgModel.TalkEnvironmentType,msgModel.MessageType,msgModel.status,msgModel.Circle_id,msgModel.FromUser_id,msgModel.ToUser_id,msgModel.text,imageStr,msgModel.time]) {
            NSLog(@"insert into KBMessageList error:%@!",_dataBase.lastErrorMessage);
        }
    }

}
//删除指定类型数据
- (void)DeleteKBMessageWithType:(KBMessageType )msgtype
{
    NSString *deleteCmd=@"delete from KBMessageList where MessageType=?";
    if (![_dataBase executeQuery:deleteCmd,msgtype]) {
         NSLog(@"delete from KBMessageList error:%@!",_dataBase.lastErrorMessage);
    }
}
//删除与某人的聊天记录
- (void)DeleteKBMessageWithEnvironment:(KBTalkEnvironmentType)talkType AndUserID:(NSString *)user_id
{
    NSString *deleteCmd=@"delete from KBMessageList where TalkEnvironmentType=? and FromUser_id=?";
    if (![_dataBase executeQuery:deleteCmd,talkType,user_id]) {
        NSLog(@"delete from KBMessageList error:%@!",_dataBase.lastErrorMessage);
    }

}
//获取与某人的聊天信息
//- (NSArray *)GetKBTalkMessageWithEnvironment:(KBTalkEnvironmentType)talkType FriendID:(NSString *)user_id 
@end
