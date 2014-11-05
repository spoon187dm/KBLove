//
//  ZhangWenLong.h
//  KBLove
//
//  Created by qianfeng on 14-11-1.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_ZhangWenLong_h
#define KBLove_ZhangWenLong_h

/*
   11-01
   导入百度地图  高德地图SDK
   完成在主界面的地图显示   在地图上添加自定义的大头针视图
 
   反地理编码  由于百度地图sdk版本更新  暂时没有找到信息的获取位置信息的方法
   CCDeviceStatus 模型中 CCGeoHelper  getAddress:coord 得到经纬度对应的位置
   CCWarning   模型中    出现了同样的问题
   [[CCGeoHelper sharedClient] getAddress:coord delegate:self];

   11-02
   在主功能界面中添加地图缩放按钮实现其功能，在设备详情页面添加地图缩放按钮
   在主功能界面中地图中  实现定位自己当前位置的功能   并在设备详情页面中也添加同样的功能
 
   11-03
   封装了高德地图的反地理编码  提供轨迹分享的位置信息
   封装了自定义地图控件   方便外部调用   
 
     CLLocationCoordinate2D coor={39.991069, 116.305395};
     [ZWL_ReGeoRecodeTool GaoDeMapViewReGeocodeWithCoordinate:coor  viewController:self response:^(NSMutableArray *resultArray) {
       5   NSLog(@"%@",resultArray[1]);
     }];
 
   11-04
 
 */


#endif
