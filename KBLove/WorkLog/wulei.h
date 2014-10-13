//
//  wulei.h
//  KBLove
//
//  Created by block on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_wulei_h
#define KBLove_wulei_h

/**
 @Author block, 10-13 23:10
 
 项目目录修改
 大量操作类重命名
 
 viewcontroller 移动至目录Section
 loginrequest 移动至Helper 目录下
 bannerView 移动至General/Views目录下
 
 工具类去掉WL前缀，部分工具类操作操作韩式变更，应为实际代码改动不多，详细进入具体代码界面参考
 
 多个宏定义头文件移动至Macro文件夹下
 
 KBUserInfo 移动至models
 新建KBAccount.hm 用于红旗登陆，获取设备各种信息等用户相关操作
 
    各目录职能
    1.AppDelegate
        这个目录下放的是AppDelegate.h(.m)文件
    2.Models
        这个目录下放一些与数据相关的Model文件
    3. Macro
        这个目录下放了整个应用会用到的宏定义
    4.General
        这个目录放会被重用的Views/Classes和Categories。
    5.Helpers
        这个目录放一些助手类，文件名与功能挂钩。
    6.Vendors
        这个目录放第三方的类库/SDK，如UMeng、WeiboSDK、WeixinSDK
    7.Sections
        这个目录下面的文件对应的是app的具体单元
 */


/**
 @Author block, 10-14 00:10
 
 修改二维码采用官方方式，放弃ZBar第三方库，Zbar库会在后期移除
 
 */
#endif
