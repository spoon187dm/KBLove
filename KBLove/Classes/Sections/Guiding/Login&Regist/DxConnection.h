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

#define  Circle_URL NSString stringWithFormat:@"%@/api/group.all.do?user_id=%@&token=%@",SERVER_URL

#define ScreenWidth  self.view.frame.size.width
#define ScreenHeight self.view.frame.size.height
#endif
