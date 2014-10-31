//
//  KBScoketManager.m
//  KBChatDemo
//
//  Created by 1124 on 14/10/25.
//  Copyright (c) 2014年 Dx. All rights reserved.
//

#import "KBScoketManager.h"
#import "AsyncSocket.h"
#import "KBMessageInfo.h"

@implementation KBScoketManager
{
    NSMutableString *newMsg;
    AsyncSocket *_clientScoket;
}
static KBScoketManager *manager;
+ (KBScoketManager *)ShareManager
{
    
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager=[[KBScoketManager alloc]init];
        });
    }
    return manager;
}
- (void)startScoket
{
    if (![_clientScoket isConnected]) {
        //链接对应接口
        _clientScoket=[[AsyncSocket alloc]initWithDelegate:self];
        [_clientScoket connectToHost:@"demo.capcare.com.cn" onPort:60005 error:nil];
    }
}
- (void)stopScoket
{
    if ([_clientScoket isConnected]) {
        [_clientScoket disconnect];
    }
}
- (void)dealloc
{
    [_clientScoket disconnect];
}
- (void)LoginToScoket
{
    NSString *udid=[[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *pversion=[UIDevice currentDevice].systemVersion;
    NSString *ptype=[UIDevice currentDevice].model;
    KBUserInfo *user=[KBUserInfo sharedInfo];
    NSDictionary *dic=@{@"user_id":user.user_id,@"token":user.token,@"ios_token":user.ios_token,@"cmd":@"1",@"duid":udid,@"app_name":@"M2616_BD",@"pversion":pversion,@"ptype":ptype,@"app_version":@"2.0.0",@"platform":@"ios"};
    
    NSString *str=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    NSString *ss=[NSString stringWithFormat:@"<request>%@</request>",str];
    NSLog(@"%@",ss);
    [_clientScoket writeData:[ss dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:200];
    
}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"已经连接到服务器");
    //传送登陆信息
    [self LoginToScoket];
    //准备接收消息
    [_clientScoket readDataWithTimeout:-1 tag:100];
    
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    //读取到消息
    if (!newMsg) {
        newMsg=[[NSMutableString alloc]init];
    }
    NSString * msg=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@************",msg);
    [newMsg appendString:msg];
    NSRange start=[newMsg rangeOfString:@">"];
    NSRange end  =[newMsg rangeOfString:@"<" options:NSBackwardsSearch];
    if (start.location==5&&end.location>5) {
        NSLog(@"%d",start.location);
        NSLog(@"%d",end.location);

        NSString *msgdic=[newMsg substringWithRange:NSMakeRange(start.location+1, end.location-start.location-1)];
        NSLog(@"%@",msgdic);
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[msgdic dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        [KBScoketManager analyseMessage:dic];
        newMsg=nil;
    }
     [_clientScoket readDataWithTimeout:-1 tag:100];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //发送完毕
    
}
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    //断开连接
    
}
#pragma mark - 消息处理
+ (void)analyseMessage:(NSDictionary *)msgDic
{
    
    //分析数据存到数据库 发送通知
    NSLog(@"%@",msgDic);
    NSArray *arr=[msgDic objectForKey:@"protocol"];
    NSDictionary *dic=arr[0];
    NSNumber *cmd=[dic objectForKey:@"cmd"];
    switch ([cmd integerValue]) {
        case 0:{
        //预留
        }break;
        case 1:{
        //登陆返回信息
        
        }break;
        case 2:{
         //位置信息
        }break;
        case 3:{
        //报警消息
        }break;
        case 4:{
        //群组消息
            NSArray *textarr=[dic objectForKey:@"texts"];
            for (int i=0; i<textarr.count; i++) {
                [KBScoketManager analyseOneMessageWithtype:[cmd integerValue] AndArray:textarr[i]];
            }

        }break;
        case 5:{
         //好友消息
            NSArray *friend_textsarr=[dic objectForKey:@"friend_texts"];
            for (int i=0; i<friend_textsarr.count; i++) {
                [KBScoketManager analyseOneMessageWithtype:[cmd integerValue] AndArray:friend_textsarr[i]];
            }
            
            
        }break;
        case 6:{
         //好友验证消息
        }break;
        case 7:{
         //系统公告消息
        }break;

        default:
            break;
    }
    
}
+ (void)analyseOneMessageWithtype:(NSInteger)type AndArray:(NSArray *)msgarr
{
    switch (type) {
        case 1:{
            //登陆返回信息
        }break;
        case 2:{
            //位置信息
        }break;
        case 3:{
            //报警消息
        }break;
        case 4:{
            //群组消息
            KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
            msginf.TalkEnvironmentType=KBTalkEnvironmentTypeCircle;
        
            msginf.FromUser_id=msgarr[0];
            msginf.Circle_id=msgarr[1];
            msginf.time=[msgarr[2] longLongValue];
            msginf.MessageType=[msgarr[3] integerValue];
            msginf.text=msgarr[4];
            msginf.status=KBMessageStatusUnRead;
            //存储消息
            KBDBManager *manager=[KBDBManager shareManager];
            [manager insertDataWithModel:msginf];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KBMessageTalkNotification object:nil];
        }break;
        case 5:{
            //好友消息
            KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
            msginf.TalkEnvironmentType=KBTalkEnvironmentTypeFriend;
            msginf.FromUser_id=msgarr[0];
            msginf.time=[msgarr[1] longLongValue];
            msginf.MessageType=[msgarr[2] integerValue];
            msginf.text=msgarr[3];
            msginf.status=KBMessageStatusUnRead;

            //存储消息
            KBDBManager *manager=[KBDBManager shareManager];
            [manager insertDataWithModel:msginf];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KBMessageTalkNotification object:nil];
            
        }break;
        case 6:{
            //好友验证消息
        }break;
        case 7:{
            //系统公告消息
        }break;
            
        default:
            break;
    }

}

//发送回执信息
- (void)sendBackMsg
{
    
}
@end
