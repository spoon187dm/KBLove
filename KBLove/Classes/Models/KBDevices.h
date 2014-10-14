//
//  KBDevices.h
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KBDevicesStatus;

@interface KBDevices : NSObject

//注：表示设备状态, 源字段中为position
@property (nonatomic, strong) KBDevicesStatus *devicesStatus;

@property (nonatomic, copy) NSString *sn; //设备ID

@property (nonatomic, copy) NSString *name;//名称

@property (nonatomic, copy) NSString *icon; //头像url

@property (nonatomic, copy) NSString *phone;//电话号码

@property (nonatomic, copy) id relation; //设备关联对象

@property (nonatomic, copy) NSNumber *tick; //上传频率

@property (nonatomic, copy) NSNumber *battery;//电量报警条件

@property (nonatomic, copy) NSString *flow;//流量报警条件

@property (nonatomic, copy) id fence;//所属围栏


@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSNumber *stamp;//头像设置的时间。默认-1

//UNKNOW = 0;
//DEVICE_CAR = 1;
//DEVICE_PET = 2;
//DEVICE_PERSON = 3;
@property (nonatomic, copy) NSNumber *type;

//移动警告开关
//1：开
//2：关
@property (nonatomic, copy) NSNumber *moveing_switch;

//超速开关
//1：开
//2：关
@property (nonatomic, copy) NSNumber *speeding_switch;

//围栏警报开关
//1：开
//2：关
@property (nonatomic, copy) NSNumber *fence_warning_switch;

//sso号码设置，1-3个
//{13511112222,13688889999,18066668888}
@property (nonatomic, copy) NSArray *sos_num;

//脱离开关
//1：开
//2：关
@property (nonatomic, copy) NSNumber *break_away_switch;

@property (nonatomic, copy) NSNumber *height; //身高（单位厘米）

@property (nonatomic, copy) NSNumber *weight; //体重（克）

//性别：
//男：1
//女：2
@property (nonatomic, copy) NSNumber *gender;

@property (nonatomic, copy) NSString *age; //年龄


//{
//    age = 0;
//    appName = "M2616_BD";
//    battery = "<null>";
//    begin = "<null>";
//    birth = 0;
//    car = "\U664bE\Uff0d77388";
//    contact = 13935694818;
//    dogBreed = "\U65e0";
//    dogFigure = "\U65e0";
//    email = "<null>";
//    enableFeeCheck = 0;
//    enableSmsAlarm = 0;
//    end = "<null>";
//    feeCheckCmd = "";
//    feeCheckNo = "";
//    fence = "<null>";
//    fenceJson = "<null>";
//    fenceSwitch = 1;
//    flow = "<null>";
//    gender = "<null>";
//    hardware = M2616;
//    height = 0;
//    icon = "354188047172916.png";
//    isobd = 0;
//    month = 0;
//    moveSwitch = 1;
//    name = "\U897f\U897f";
//    phone = 18459116617;
//    polygonFenceSwitch = 2;
//    position =     {
//        alarm = 0;
//        battery = 0;
//        deviceSn = 354188047172916;
//        direction = 0;
//        flow = 0;
//        info = "<null>";
//        lat = "39.9798650053";
//        lng = "116.4985916018";
//        mode = "<null>";
//        receive = 1409825194945;
//        speed = 0;
//        stamp = "<null>";
//        status = 2;
//        stayed = 0;
//        systime = 1409825194945;
//    };
//    sage = "0\U5c81";
//    sn = 354188047172916;
//    sosNum = 13935694818;
//    speedThreshold = 120;
//    speedingSwitch = 1;
//    stamp = 1406889411942;
//    tick = 30;
//    type = 1;
//    weight = 0;
//}


@end
