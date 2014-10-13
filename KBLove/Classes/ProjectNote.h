//
//  ProjectNote.h
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_ProjectNote_h
#define KBLove_ProjectNote_h

/**
 
 需注意，所有文件请根据下方列出的目录结构进行管理
 进行文件添加时请尽量完善下方目录，以便他人参考
 
 */

#pragma mark -
#pragma mark total 各目录职能
/**
 @Author block, 10-13
 
 项目目录修改
 各目录职能
|- Classes
    |- AppDelegate 这个目录下放的是AppDelegate.h(.m)文件

    |- General     这个目录放会被重用的Views/Classes和Categories。

    |- Models      这个目录下放一些与数据相关的Model文件

    |- Macro       这个目录下放了整个应用会用到的宏定义

    |- Helpers     这个目录放一些助手类，文件名与功能挂钩。

    |- Vendors     这个目录放第三方的类库/SDK，如UMeng、WeiboSDK、WeixinSDK

    |- Sections    这个目录下面的文件对应的是app的具体单元，如具体的视图控制器，具体的菜单按钮之类的不应被重用的单元

 */

#pragma mark -
#pragma mark AppDelegate 这个目录下放的是AppDelegate.h(.m)文件
//  这就不用介绍了
#pragma mark -
#pragma mark General 这个目录放会被重用的Views/Classes和Categories
/**
 @Author block, 10-14 00:10
 
 |- General
     |- Categories 一些分类
 
     |- Classes 一些需要重用的泪
 
     |- Views 一些通用可被重载的视图
 
 
 */
#pragma mark -
#pragma mark Models 这个目录下放一些与数据相关的Model文件
/**
 @Author block, 10-14 00:10
 
 |-Models 数据模型
 
 */
#pragma mark -
#pragma mark Macro 这个目录下放了整个应用会用到的宏定义
/**
 @Author block, 10-14 00:10
 
 |-Macro 各宏定义或者常量定义
 
 */
#pragma mark -
#pragma mark Helpers 这个目录放一些助手类，文件名与功能挂钩
/**
 @Author block, 10-14 00:10
 
 |-Helpers 工具类
 
 */

#pragma mark -
#pragma mark Vendors 这个目录放第三方的类库/SDK
/**
 @Author block, 10-14 00:10
 
 |- Vendors 第三方库
 */

#pragma mark -
#pragma mark Sections 这个目录下面的文件对应的是app的具体单元
/**
 @Author block, 10-14 00:10
 
 |- Sections app具体单元
    |- Guiding 注册引导相关视图控制器
    |- Main    主界面视图控制器
 */
#endif
