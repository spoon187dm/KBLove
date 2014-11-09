//
//  ImageMacro.h
//  KBLove
//
//  Created by block on 14/10/30.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_ImageMacro_h
#define KBLove_ImageMacro_h

#define ClearColor [UIColor clearColor]


#define kImageUrlForName(x) [NSString stringWithFormat:@"http://118.194.192.104:1045/api/upload//api/upload/%@",x]
//获取 头像 链接
#define kUserImageFromName(x)[NSString stringWithFormat:@"http://test.capcare.com.cn:1045/api/upload/user_%@.jpg",x]

#define kImage_car [UIImage imageNamed:@"图标_97"]
#define kImage_person [UIImage imageNamed:@"图标_96"]
#define kImage_pet [UIImage imageNamed:@"图标_91"]

/**
 没有警报
 */
#define kImage_deviceAlarm_no [UIImage imageNamed:@"页面列表1_17"]

/**
 有警报的图片
 */
#define kImage_deviceAlarm_yes [UIImage imageNamed:@"页面列表31_17"]

#define kImage_deviceStatusActive [UIImage imageNamed:@"页面列表1_24"]

#define kImage_deviceStatusDeactive [UIImage imageNamed:@"页面列表1_12"]

#endif
