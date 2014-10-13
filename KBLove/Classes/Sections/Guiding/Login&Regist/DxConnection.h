//
//  DxConnection.h
//  KBLove
//
//  Created by qianfeng on 14-10-11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_DxConnection_h
#define KBLove_DxConnection_h
typedef NS_ENUM(NSInteger, RegisterType)
{
    phone=1,
    email,
    userName,
    QQ,
    sinaWeibo,
    renren
};

//#define  REGRSTER_URL NSString stringWithFormat:@"%@/api/register.do?type=%d&name=%@&pwd=%@",SERVER_URL

#endif
