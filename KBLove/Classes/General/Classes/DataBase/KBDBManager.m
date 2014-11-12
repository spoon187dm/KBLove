//
//  KBDBManager.m
//  KBLove
//
//  Created by 1124 on 14-10-17.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "KBDBManager.h"
//表名定义宏，每个用户又不同的 表
#define MessageListName [NSString stringWithFormat:@"KB%@MessageList",[KBUserInfo sharedInfo].user_id]
@implementation KBDBManager
{
    FMDatabase *_dataBase;
    FinishedBlock _FinishedBlock;
    //线程队列
   // NSOperationQueue *_operationQueue;
    NSDictionary *_resultDic;
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
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //初始化线程队列
           // _operationQueue=[[NSOperationQueue alloc]init];
            _resultDic=[[NSDictionary alloc]init];
            NSString *path=[NSHomeDirectory() stringByAppendingFormat:@"/Library/KB.db"];
            _dataBase=[[FMDatabase alloc]initWithPath:path];
            if ([_dataBase open]) {
                //创建消息表
                NSLog(@"%@",MessageListName);
                NSString *createMsgTable=[NSString stringWithFormat: @"create table if not exists %@(TalkEnvironmentType integer,MessageType integer,status integer,Circle_id char(255),FromUser_id char(255),ToUser_id char(255),text char(255),image varchar(2000),time  bigint primary key)",MessageListName];
                NSLog(@"%@",createMsgTable);
                if(![_dataBase executeUpdate:createMsgTable]){
                    NSLog(@"create KBMessageList error:%@!",_dataBase.lastErrorMessage);
                }
                
            }

        });
    }
    return self;
}
//获取消息列表
- (NSArray *)getMessageList
{
    //所有数据
    NSMutableArray *allData=[[NSMutableArray alloc]init];
    
    //返回数据
    NSMutableArray *Resultarray=[[NSMutableArray alloc]init];
    //辅助数组
    NSMutableArray *TagFriendArray=[[NSMutableArray alloc]init];
    NSMutableArray *TagcircleArray=[[NSMutableArray alloc]init];
    //好友申请标志
    BOOL ishaveFriendRequest=NO;
  NSString *excuteStr=[NSString stringWithFormat:@"select *from %@",MessageListName ];
    FMResultSet *set=[_dataBase executeQuery:excuteStr];
    [allData addObjectsFromArray:[self getMessageFromSet:set]];
    if (allData.count>0) {
        for (int i=allData.count-1; i>=0; i--) {
            KBMessageInfo *msg=allData[i];
            if (msg.TalkEnvironmentType==KBTalkEnvironmentTypeCircle) {
               //处理圈子消息
                NSString *circleId=[NSString stringWithFormat:@"%@",msg.Circle_id];
                if (![TagcircleArray containsObject:circleId]) {
                    [TagcircleArray addObject:circleId];
                    [Resultarray addObject:msg];
                }
            }else if (msg.TalkEnvironmentType==KBTalkEnvironmentTypeFriend)
            {
                //处理好友请求消息
                if(msg.MessageType==KBMessageTypeAddFriend||msg.MessageType==KBMessageTypeAgreeFriend||msg.MessageType==KBMessageTypeRejectFriend)
                {
                    if (!ishaveFriendRequest) {
                        ishaveFriendRequest=YES;
                        [Resultarray addObject:msg];
                    }
                }else
                {
                    //处理好友聊天消息
                    NSString *fromId=[NSString stringWithFormat:@"%@",msg.FromUser_id];
                    
                    NSString *friendid;
                    if ([fromId isEqualToString:[NSString stringWithFormat:@"%@",[KBUserInfo sharedInfo].user_id]]) {
                        friendid=[NSString stringWithFormat:@"%@",msg.ToUser_id];
                        NSLog(@"%@",msg.ToUser_id);
                    }else
                    {
                        friendid=fromId;
                    }
                    
                    if (![TagFriendArray containsObject:friendid]) {
                        [TagFriendArray addObject:friendid];
                        [Resultarray addObject:msg];
                    }
                }
            }
        }
    }
    return Resultarray;
}
- (NSInteger)getUnreadMessageCountWithTalkEnvironment:(KBTalkEnvironmentType)talktype TalkID:(NSString *)tagid andMessageType:(KBMessageType)msgtype
{

    FMResultSet *set;
    if(msgtype==KBMessageTypeAddFriend||msgtype==KBMessageTypeAgreeFriend||msgtype==KBMessageTypeRejectFriend){
          NSString *excuteStr=[NSString stringWithFormat:@"select * from %@ where (MessageType=? or MessageType=? or MessageType=?) and status=?",MessageListName];
        set=[_dataBase executeQuery:excuteStr,[NSNumber numberWithInteger:KBMessageTypeAddFriend],[NSNumber numberWithInteger:KBMessageTypeAgreeFriend],[NSNumber numberWithInteger:KBMessageTypeRejectFriend],[NSNumber numberWithInteger: KBMessageStatusUnRead]];
        
    }else
    {
        NSString *excuteStr;
        if (talktype==KBTalkEnvironmentTypeCircle) {
        excuteStr=[NSString stringWithFormat:@"select * from %@ where TalkEnvironmentType=? and Circle_id=? and status=?",MessageListName];
            set=[_dataBase executeQuery:excuteStr,[NSNumber numberWithInteger:talktype],tagid,[NSNumber numberWithInteger: KBMessageStatusUnRead]];
        }else{
        excuteStr=[NSString stringWithFormat:@"select * from %@ where TalkEnvironmentType=? and (FromUser_id=? or ToUser_id=? ) and status=?",MessageListName];
            set=[_dataBase executeQuery:excuteStr,[NSNumber numberWithInteger:talktype],tagid,tagid,[NSNumber numberWithInteger: KBMessageStatusUnRead]];
        }
        
    }
    NSArray *arr=[self getMessageFromSet:set];
   // NSLog(@"%d",arr.count);
    return arr.count;
}
////插入数据
//- (void)insertDataWithModel:(id)obj AndFinishedBlock:(FinishedBlock)insertBlock{
//    if (_FinishedBlock!=insertBlock) {
//        _FinishedBlock=nil;
//        _FinishedBlock=insertBlock;
//    }
//    NSInvocationOperation *opr=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(insertDataWithModel:) object:obj];
//    [_operationQueue addOperation:opr];
//}
-(void)insertDataWithModel:(id)obj
{
    
    
        if ([obj isKindOfClass:[KBMessageInfo class]]) {
            KBMessageInfo *msgModel=(KBMessageInfo *)obj;
            if (![self isExistInDateBase:msgModel]) {
                NSLog(@"%lld",msgModel.time);
                NSString *insert=[NSString stringWithFormat:@"insert into %@ values(?,?,?,?,?,?,?,?,?)",MessageListName];
                NSString *imageStr;
                // NSInteger s=1;
                if (msgModel.image) {
                    imageStr=[[NSString alloc]initWithData:UIImagePNGRepresentation(msgModel.image) encoding:NSUTF8StringEncoding];
                }
                imageStr=@"";
                //NSLog(@"");
                if (![_dataBase executeUpdate:insert,[NSNumber numberWithInteger:msgModel.TalkEnvironmentType],[NSNumber numberWithInteger:msgModel.MessageType],[NSNumber numberWithInteger:msgModel.status],msgModel.Circle_id,msgModel.FromUser_id,msgModel.ToUser_id,msgModel.text,imageStr,[NSNumber numberWithLongLong:msgModel.time]]) {
                    NSLog(@"insert into KBMessageList error:%@!",_dataBase.lastErrorMessage);
//                    [_resultDic setValue:@"" forKey:KBresult];
//                    [_resultDic setValue:[NSNumber numberWithInteger:Success] forKey:KBisSuccess];
                    //                [self performSelectorOnMainThread:@selector(readFinished:) withObject:_resultDic waitUntilDone:NO];
                }
            }
            
        }
   
    
}
//删除指定类型数据
- (void)DeleteKBMessageWithType:(KBMessageType)msgtype
{
    
    NSString *deleteCmd=[NSString stringWithFormat:@"delete from %@ where MessageType=?",MessageListName];
    if (![_dataBase executeUpdate:deleteCmd,[NSNumber numberWithInteger:msgtype]]) {
        NSLog(@"delete from KBMessageList error:%@!",_dataBase.lastErrorMessage);
    }
}
//删除与某人的聊天记录
- (void)DeleteKBMessageWithEnvironment:(KBTalkEnvironmentType)talkType AndUserID:(NSString *)user_id
{
    
    NSString *deleteCmd;
    if (talkType==KBTalkEnvironmentTypeCircle) {
         deleteCmd=[NSString stringWithFormat:@"delete from %@ where TalkEnvironmentType=? and Circle_id=?",MessageListName];
        if (![_dataBase executeUpdate:deleteCmd,[NSNumber numberWithInteger:talkType],user_id]) {
            NSLog(@"delete from KBMessageList error:%@!",_dataBase.lastErrorMessage);
        }

    }else
    {
        deleteCmd=[NSString stringWithFormat:@"delete from %@ where TalkEnvironmentType=? and (FromUser_id=? or ToUser_id=?)",MessageListName];
        if (![_dataBase executeUpdate:deleteCmd,[NSNumber numberWithInteger:talkType],user_id,user_id]) {
            NSLog(@"delete from KBMessageList error:%@!",_dataBase.lastErrorMessage);
        }

    }

    
}
- (void)updateKBMessageWithModel:(KBMessageInfo *)msg
{
    NSString *imgStr;
    if (msg.image) {
          imgStr=[[NSString alloc]initWithData:UIImagePNGRepresentation(msg.image) encoding:NSUTF8StringEncoding];
    }else
    {
     imgStr=@" ";
    }

    NSString *updateSQL=[NSString stringWithFormat:@"update %@ set TalkEnvironmentType=?,MessageType=?,status=?,Circle_id=?,FromUser_id=?,ToUser_id=?,text=?,image=? where time=?",MessageListName];
    if(![_dataBase executeUpdate:updateSQL,[NSNumber numberWithInteger:msg.TalkEnvironmentType],[NSNumber numberWithInteger:msg.MessageType],[NSNumber numberWithInteger:msg.status],msg.Circle_id,msg.FromUser_id,msg.ToUser_id,msg.text,imgStr,[NSNumber numberWithLongLong:msg.time]])
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
    selectSQL=[NSString stringWithFormat:@"select * from %@ where TalkEnvironmentType=? and Circle_id=? order by time desc",MessageListName ];
    }else{
    selectSQL=[NSString stringWithFormat:@"select * from %@ where TalkEnvironmentType=? and (FromUser_id=? or ToUser_id=? )order by time desc",MessageListName ];
    }
    
//    NSString *selectSQL;
//    if (talkType==KBTalkEnvironmentTypeCircle) {
//        selectSQL=[NSString stringWithFormat:@"select * from %@  where TalkEnvironmentType=? and Circle_id=? ",MessageListName ];
//    }else{
//        selectSQL=[NSString stringWithFormat:@"select * from %@ where TalkEnvironmentType=? and (FromUser_id=? or ToUser_id=? )",MessageListName];
//    }
    FMResultSet *set;
    if (talkType==KBTalkEnvironmentTypeCircle) {
        set=[_dataBase executeQuery:selectSQL,[NSNumber numberWithInteger:talkType],user_id];
    }else
    {
        set=[_dataBase executeQuery:selectSQL,[NSNumber numberWithInteger:talkType],user_id,user_id];
    }

    

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

    NSLog(@"%ld,%ld",(long)page,(long)number);
    NSMutableArray *resultarr=[[NSMutableArray alloc]init];
    NSMutableArray *allData=[[NSMutableArray alloc]init];
    NSString *selectSQL;
    if (talkType==KBTalkEnvironmentTypeCircle) {
        selectSQL=[NSString stringWithFormat:@"select * from %@  where TalkEnvironmentType=? and Circle_id=? ",MessageListName ];
    }else{
        selectSQL=[NSString stringWithFormat:@"select * from %@ where TalkEnvironmentType=? and (FromUser_id=? or ToUser_id=? )",MessageListName];
    }
    FMResultSet *set;
    if (talkType==KBTalkEnvironmentTypeCircle) {
      set=[_dataBase executeQuery:selectSQL,[NSNumber numberWithInteger:talkType],user_id];
    }else
    {
    set=[_dataBase executeQuery:selectSQL,[NSNumber numberWithInteger:talkType],user_id,user_id];
    }
    [allData addObjectsFromArray:[self getMessageFromSet:set]];
    //返回指定条数信息
    
    NSLog(@"%lu",(unsigned long)allData.count);
    if (allData.count < (page +1)*number) {
        if (allData.count >(page)*number) {
            for (int i=0; i<allData.count-(page)*number; i++) {
                [resultarr addObject:allData[i]];
            }
        }
    }else
    {
    for (int i=(int)(allData.count-(page+1)*number); i<allData.count-(page)*number; i++) {
        [resultarr addObject:allData[i]];
    }
    }
    NSLog(@"%lu",(unsigned long)resultarr.count);
    return  resultarr ;
}
- (BOOL)isExistInDateBase:(id)model
{
    if ([model isKindOfClass:[KBMessageInfo class]]) {
        KBMessageInfo *msginf=(KBMessageInfo *)model;
        NSString *quaryStr=[NSString stringWithFormat:@"select * from %@ where time=?",MessageListName];
        FMResultSet *set=[_dataBase executeQuery:quaryStr,[NSNumber numberWithLongLong:msginf.time]];
        return  [set next];
    }
    return NO;
}
//获取数据库表名称
- (NSString *)getListName
{
    
    return  [NSString stringWithFormat:@"%@_MessageList",[KBUserInfo sharedInfo].user_id];
}
- (NSArray *)getMessageFromSet:(FMResultSet *)set
{
    NSMutableArray *resultArr=[[NSMutableArray alloc]init];
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
        [resultArr addObject:msginf];
        
    }
    return resultArr;

}
//使用线程访问数据库是回调方法
//- (void)readFinished:(NSDictionary *)resultDic
//{
//    NSNumber *ret=[resultDic objectForKey:KBisSuccess];
//    switch ([ret integerValue]) {
//        case Success:{
//            _FinishedBlock([resultDic objectForKey:KBresult],YES);
//        }break;
//        case Faile:{
//           _FinishedBlock([resultDic objectForKey:KBresult],NO);
//        }break;
//            
//        default:
//            break;
//    }
//}
@end
