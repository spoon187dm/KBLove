//
//  LoginRequest.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "LoginRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "KBUserInfo.h"

@implementation LoginRequest

static LoginRequest *login = nil;
+ (LoginRequest *)shareInstance
{
    if (!login) {
        login = [[LoginRequest alloc] init];
    }
    return login;
}

- (void)requestWithUserName:(NSString *)userName
                andPassWord:(NSString *)passWord
      andLoginFinishedBlock:(LoginFinishedBlock)finishedBlock
        andLoginFaildeBlock:(LoginFailedBlock)failedBlock{
    //获得url
    NSString *url = [self getUrlWithUserName:userName andPasswd:passWord];
    
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&error];
        /*
         allinchina = 1;
         ret = 1;
         token = "2A140923-1969-4EA5-BBA4-6C38CDCCB89F";
         type = "<null>";
         "user_id" = 11218;
         */
        NSDictionary * dict = nil;
        KBUserInfo *info = [KBUserInfo sharedInfo];
        if ([object isKindOfClass:[NSDictionary class]])
        {
            dict = (NSDictionary*)object;
            if ([dict[@"ret"] integerValue] == 1) {//成功时
                //成功后应该保存用户名 密码token user_id到本地
                info.userName = userName;
                info.passWord = passWord;
                info.token = dict[@"token"];
                info.user_id = dict[@"user_id"];
                [info save];
                finishedBlock();
            } else {//出现问题时
                failedBlock(dict[@"desc"]);//讲错误描述传回
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"login error in LoginRequest %@",error);
        failedBlock([NSString stringWithFormat:@"%@",error]);
    }];
    
}

//获取合法请求参数尽心处理的方法
//获取当前时间戳
-(NSString*)TimeJab {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int newTime = time * 1000;
//    timeSecond = newTime;
    NSString * timeStr = [NSString stringWithFormat:@"%lld", newTime];
    return timeStr;
}

//进行加密
- (NSString *)getUrlWithUserName:(NSString *)userName andPasswd:(NSString *)passwd {
    //第一次加密
    NSString * onceMD5 = [passwd MD5Hash];
    //第二次加密
    NSString * twiceMD5 = [onceMD5 MD5Hash];
    //将时间拼接
    NSString * addTime = [NSString stringWithFormat:@"%@%@", twiceMD5, [self TimeJab]];
    //拼接时间后加密
    NSString * lastMD5 = [addTime MD5Hash];
    //得到url
    NSString * url = [LOGIN_URL, userName, lastMD5, [self TimeJab], 3];
    
    return url;

}

@end
