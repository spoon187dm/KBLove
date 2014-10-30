//
//  KBScoketManager.m
//  KBChatDemo
//
//  Created by 1124 on 14/10/25.
//  Copyright (c) 2014年 Dx. All rights reserved.
//

#import "KBScoketManager.h"
#import "AsyncSocket.h"
#import <UIKit/UIKit.h>
@implementation KBScoketManager
{
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
    NSString * str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    //处理消息
    
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
- (void)analyseMessage:(NSString *)msg
{
    
}
//发送回执信息
- (void)sendBackMsg
{
    
}
@end
