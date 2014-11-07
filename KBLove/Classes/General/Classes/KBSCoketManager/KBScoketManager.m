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
#import "KBHttpRequestTool.h"
#import "DxConnection.h"
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
        [_clientScoket connectToHost:@"demo.capcare.com.cn" onPort:60006 error:nil];
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
    if ([KBUserInfo sharedInfo].ios_token.length<5) {
        [UIAlertView showWithTitle:@"提示" Message:@"虚拟机无法启用推送功能" cancle:@"确定" otherbutton:nil block:^(NSInteger index) {
            
        }];
    }
    
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
    if(msg){
    [newMsg appendString:msg];
    NSRange start=[newMsg rangeOfString:@"<push>"];
    NSRange end  =[newMsg rangeOfString:@"</push>" options:NSBackwardsSearch];
    NSLog(@"%d",start.location);
    NSLog(@"%d",end.location);
    
    if (start.location==0&&end.length>0) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
                //取得整块信息<push>hhh</push><push>dddd</push><push>dddd</push><push>dddd
        NSString *msgdic=[newMsg substringWithRange:NSMakeRange(start.location+start.length, end.location-start.location-start.length)];
        
      //  NSLog(@"%@",msgdic);
        NSArray *arr=[msgdic componentsSeparatedByString:@"<push>"];
        for (int i=0; i<arr.count; i++) {
            [array addObject:[arr[i] componentsSeparatedByString:@"</push>"][0]];
        }
        
        for (int i=0; i<array.count; i++) {
            NSString *msgdic=array[i];
            NSLog(@"解析后:%@",msgdic);
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[msgdic dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            [self analyseMessage:dic];
        }
        if (newMsg.length>end.location+end.length) {
            newMsg=[[NSMutableString alloc]init];
            [newMsg appendString:[NSString stringWithFormat:@"%@",[newMsg substringWithRange:NSMakeRange(end.location+end.length, newMsg.length-end.location-end.length)]]];
        }else
        {
            newMsg=nil;
        }
        
    }
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
- (void)analyseMessage:(NSDictionary *)msgDic
{
    
    //分析数据存到数据库 发送通知
    //NSLog(@"%@",msgDic);
    NSArray *arr=[msgDic objectForKey:@"protocol"];
    NSDictionary *dic=arr[0];
    NSNumber *cmd=[dic objectForKey:@"cmd"];
    if([cmd integerValue]==0)
    {
        //说明是回执消息 无需解析
        return;
    }
    //创建回执消息数组
    NSMutableArray *msg_idArray=[[NSMutableArray alloc]init];
    //登陆返回信息
    
    //处理位置信息
    //处理报警信息
    //处理群组信息
    NSArray *textarr=[dic objectForKey:@"texts"];
    if(textarr){
        for (int i=0; i<textarr.count; i++) {
            NSArray *msgArr=textarr[i];
            [msg_idArray addObject:[msgArr lastObject]];
            [self analyseOneMessageWithtype:4 AndArray:msgArr];
        }
    }
    //处理好友信息
    NSArray *friend_textsarr=[dic objectForKey:@"friend_texts"];
    if (friend_textsarr) {
        for (int i=0; i<friend_textsarr.count; i++) {
            NSArray *msgArr=friend_textsarr[i];
            [msg_idArray addObject:[msgArr lastObject]];
            [self analyseOneMessageWithtype:5 AndArray:msgArr];
        }
        
    }

        //系统公告信息
  
    
    //好友验证信息
    NSArray *friend_verifys=[dic objectForKey:@"friend_verifys"];
    //NSLog(@"%ld",friend_verifys.count);
    if (friend_verifys) {
        for (int i=0; i<friend_verifys.count; i++) {
            
            NSArray *msgArr=friend_verifys[i];
            NSLog(@"%@",msgArr);
            NSLog(@"%d",msgArr.count);
            [msg_idArray addObject:[msgArr lastObject]];
            [self analyseOneMessageWithtype:6 AndArray:msgArr];
        }
        
    }
    
    //系统公告信息
    
    
    //发送回执消息
    [self sendBackMsgWithCmdTag:msg_idArray];
}

- (void)analyseOneMessageWithtype:(NSInteger)type AndArray:(NSArray *)msgarr
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

            //发送通知
            NSString *myuser_id=[NSString stringWithFormat:@"%@",[KBUserInfo sharedInfo].user_id];
            NSString *getid=[NSString stringWithFormat:@"%@",msginf.FromUser_id];
            if ([myuser_id isEqualToString:getid]) {
                
            }else{
                //存储消息
                KBDBManager *manager=[KBDBManager shareManager];
                [manager insertDataWithModel:msginf];
            [[NSNotificationCenter defaultCenter] postNotificationName:KBMessageTalkNotification object:nil];
            }
            
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
            //好友验证消息<push>{"protocol":[{"ret":1,"cmd":6,"friend_verifys":[["10001","1411920502000","1","请求添加你为好友" ,"123"]]}]}</push>
            KBMessageInfo *msginf=[[KBMessageInfo alloc]init];
            msginf.TalkEnvironmentType=KBTalkEnvironmentTypeFriend;
            msginf.FromUser_id=msgarr[0];
            msginf.time=[msgarr[1] longLongValue];
            msginf.MessageType=[msgarr[2] integerValue]+3;
            msginf.text=msgarr[3];
            msginf.status=KBMessageStatusUnRead;
            
            //存储消息
            KBDBManager *manager=[KBDBManager shareManager];
            [manager insertDataWithModel:msginf];
            switch (msginf.MessageType) {
                case KBMessageTypeAddFriend:{
                    [UIAlertView showWithTitle:@"好友请求" Message:[NSString stringWithFormat:@"%@",msgarr[3]] cancle:@"同意" otherbutton:@"拒绝" block:^(NSInteger index) {
                        NSLog(@"%d",index);
                        KBUserInfo *user=[KBUserInfo sharedInfo];
                        NSDictionary *dic=@{@"user_id":user.user_id,@"token":user.token,@"app_name":app_name,@"friend_id":msginf.FromUser_id,@"is_pass":[NSNumber numberWithInteger:(index+1)]};
                        [[KBHttpRequestTool sharedInstance] request:[Circle_SendIsAGreeFriendMessage_URL] requestType:KBHttpRequestTypePost params:dic cacheType:WLHttpCacheTypeNO overBlock:^(BOOL IsSuccess, id result) {
                            if (IsSuccess) {
                                //已经同意修改信息状态
                            }else
                            {
                                
                            }
                        }];
                    }];
                    
                }break;
                case KBMessageTypeRejectFriend:{
                    [UIAlertView showWithTitle:@"好友请求" Message:[NSString stringWithFormat:@"%@",msgarr[3]] cancle:@"确定" otherbutton:nil  block:^(NSInteger index) {
                    }];
                }break;
                case KBMessageTypeAgreeFriend:{
                    [UIAlertView showWithTitle:@"好友请求" Message:[NSString stringWithFormat:@"%@",msgarr[3]] cancle:@"确定" otherbutton:nil  block:^(NSInteger index) {
                    }];
                    
                }break;
                default:
                    break;
            }
        }break;
        case 7:{
            //系统公告消息
        }break;
            
        default:
            break;
    }
    
}

//发送回执信息
- (void)sendBackMsgWithCmdTag:(NSArray *)msg_idArray
{
    NSMutableString *msg_id=[[NSMutableString alloc]init];
    for (int i =0; i<msg_idArray.count; i++) {
        if (i<msg_idArray.count-1) {
            [msg_id appendFormat:@"%@#",msg_idArray[i]];
        }else
        {
            [msg_id appendFormat:@"%@",msg_idArray[i]];
        }
        
    }
    KBUserInfo *user=[KBUserInfo sharedInfo];
    NSDictionary *dic=@{@"user_id":user.user_id,@"ios_token":user.ios_token,@"msg_id":msg_id,@"cmd":@"2",@"app_name":@"M2616_BD",@"duid":[[UIDevice currentDevice] identifierForVendor].UUIDString};
    NSString *str=[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    NSString *ss=[NSString stringWithFormat:@"<request>%@</request>",str];
    NSLog(@"%@",ss);
    [_clientScoket writeData:[ss dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:200];
    
    //<request>{"user_id":"10705","ios_token":"","msg_id":"1#2#3","cmd":2,"duid":"355066060855683","app_name":"M2616_BD"}</request>
}
@end
