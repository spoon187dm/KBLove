//
//  KBDBManager.m
//  KBLove
//
//  Created by 1124 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBDBManager.h"
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
            NSString *createMsgTable=@"create table if not exists KBMessageList(TalkEnvironmentType integer,MessageType integer,status integer,Circle_id char(255),FromUser_id char(255),ToUser_id char(255),text char(255),image varchar(2000),time  bigint primary key)";
            NSLog(@"%@",createMsgTable);
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
        NSLog(@"%lld",msgModel.time);
        NSString *insert=@"insert into KBMessageList values(?,?,?,?,?,?,?,?,?)";
        NSString *imageStr;
       // NSInteger s=1;
        if (msgModel.image) {
          imageStr=[[NSString alloc]initWithData:UIImagePNGRepresentation(msgModel.image) encoding:NSUTF8StringEncoding];
        }
        imageStr=@"";
        //NSLog(@"");
        if (![_dataBase executeUpdate:insert,[NSNumber numberWithInteger:msgModel.TalkEnvironmentType],[NSNumber numberWithInteger:msgModel.MessageType],[NSNumber numberWithInteger:msgModel.status],msgModel.Circle_id,msgModel.FromUser_id,msgModel.ToUser_id,msgModel.text,imageStr,[NSNumber numberWithLongLong:msgModel.time]]) {
            NSLog(@"insert into KBMessageList error:%@!",_dataBase.lastErrorMessage);
        }
    }
    
}
//删除指定类型数据
- (void)DeleteKBMessageWithType:(KBMessageType)msgtype
{
    NSString *deleteCmd=@"delete from KBMessageList where MessageType=?";
    if (![_dataBase executeUpdate:deleteCmd,msgtype]) {
        NSLog(@"delete from KBMessageList error:%@!",_dataBase.lastErrorMessage);
    }
}
//删除与某人的聊天记录
- (void)DeleteKBMessageWithEnvironment:(KBTalkEnvironmentType)talkType AndUserID:(NSString *)user_id
{
    NSString *deleteCmd=@"delete from KBMessageList where TalkEnvironmentType=? and FromUser_id=?";
    if (![_dataBase executeUpdate:deleteCmd,talkType,user_id]) {
        NSLog(@"delete from KBMessageList error:%@!",_dataBase.lastErrorMessage);
    }
    
}
- (void)updateKBMessageWithModel:(KBMessageInfo *)msg
{
    NSString *imgStr=[[NSString alloc]initWithData:UIImagePNGRepresentation(msg.image) encoding:NSUTF8StringEncoding];
    NSString *updateSQL=@"update KBMessageList set TalkEnvironmentType=?,MessageType=?,status=?,Circle_id=?,FromUser_id=?,ToUser_id=?,text=?,image=? where time=?";
    if(![_dataBase executeUpdate:updateSQL,msg.TalkEnvironmentType,msg.MessageType,msg.status,msg.Circle_id,msg.FromUser_id,msg.ToUser_id,msg.text,imgStr,msg.time])
    {
        NSLog(@"update KBMessageList error:%@",_dataBase.lastErrorMessage);
    }
    
}
//获取最后一条聊天数据
- (KBMessageInfo *)getLastMsgWithEnvironment:(KBTalkEnvironmentType)talkType AndFromID:(NSString *)user_id
{
    NSMutableArray *resultarr=[[NSMutableArray alloc]init];
    
    NSString *selectSQL;
    if (talkType==KBTalkEnvironmentTypeCircle) {
    selectSQL=@"select * from KBMessageList where TalkEnvironmentType=? and Circle_id=? order by time desc";
    }else{
    selectSQL=@"select * from KBMessageList where TalkEnvironmentType=? and FromUser_id=? order by time desc";
    }
    FMResultSet *set=[_dataBase executeQuery:selectSQL,[NSNumber numberWithInteger:talkType],user_id];
    if([set next]) {
        KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
        msginf.TalkEnvironmentType=[set intForColumn:@"TalkEnvironmentType"];
        msginf.MessageType=[set intForColumn:@"MessageType"];
        msginf.status=[set intForColumn:@"status"];
        msginf.Circle_id=[set stringForColumn:@"Circle_id"];
        msginf.FromUser_id=[set stringForColumn:@"FromUser_id"];
        msginf.ToUser_id=[set stringForColumn:@"ToUser_id"];
        msginf.text=[set stringForColumn:@"text"];
        msginf.image=[UIImage imageWithData:[[set stringForColumn:@"image"] dataUsingEncoding:NSUTF8StringEncoding]];
        msginf.time=[set longLongIntForColumn:@"time"];
        [resultarr addObject:msginf];
    return  [resultarr lastObject];
    }
    return nil;
}
//获取与某人的聊天信息
- (NSArray *)GetKBTalkMessageWithEnvironment:(KBTalkEnvironmentType)talkType FriendID:(NSString *)user_id AndPage:(NSInteger)page Number:(NSInteger)number
{

    NSLog(@"%d,%d",page,number);
    NSMutableArray *resultarr=[[NSMutableArray alloc]init];
    NSMutableArray *allData=[[NSMutableArray alloc]init];
    NSString *selectSQL;
    if (talkType==KBTalkEnvironmentTypeCircle) {
        selectSQL=@"select * from KBMessageList  where TalkEnvironmentType=? and Circle_id=? ";
    }else{
        selectSQL=@"select * from KBMessageList where TalkEnvironmentType=? and (FromUser_id=? or ToUser_id=? )";
    }
    FMResultSet *set;
    if (talkType==KBTalkEnvironmentTypeCircle) {
      set=[_dataBase executeQuery:selectSQL,[NSNumber numberWithInteger:talkType],user_id];
    }else
    {
    set=[_dataBase executeQuery:selectSQL,[NSNumber numberWithInteger:talkType],user_id,user_id];
    }
    
    while([set next]) {
        KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
        msginf.TalkEnvironmentType=[set intForColumn:@"TalkEnvironmentType"];
        msginf.MessageType=[set intForColumn:@"MessageType"];
        msginf.status=[set intForColumn:@"status"];
        msginf.Circle_id=[set stringForColumn:@"Circle_id"];
        msginf.FromUser_id=[set stringForColumn:@"FromUser_id"];
        msginf.ToUser_id=[set stringForColumn:@"ToUser_id"];
        msginf.text=[set stringForColumn:@"text"];
        msginf.image=[UIImage imageWithData:[[set stringForColumn:@"image"] dataUsingEncoding:NSUTF8StringEncoding]];
        msginf.time=[set longLongIntForColumn:@"time"];
        [allData addObject:msginf];
        
    }
    //返回指定条数信息
    
    NSLog(@"%d",allData.count);
    if (allData.count < (page +1)*number) {
        if (allData.count >(page)*number) {
            for (int i=0; i<allData.count-(page)*number; i++) {
                [resultarr addObject:allData[i]];
            }
 
        }
    }else
    {
    for (int i=allData.count-(page+1)*number; i<allData.count-(page)*number; i++) {
        [resultarr addObject:allData[i]];
    }
    }
    NSLog(@"%d",resultarr.count);
    return  resultarr ;
}

@end
