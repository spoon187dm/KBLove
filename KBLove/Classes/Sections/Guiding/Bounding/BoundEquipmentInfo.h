//
//  BoundEquipmentInfo.h
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoundEquipmentInfo : NSObject

@property (nonatomic, strong) NSString * EquipmentIMEINum;
@property (nonatomic, strong) NSString * EquipmentSIMNum;
@property (nonatomic, strong) NSString * EquipmentIponeNum;

//车辆配置信息
@property (nonatomic, strong) NSData * CarHeadImageInfo;
@property (nonatomic,strong)NSString *CarName;
@property (nonatomic,strong)NSString *CarNum;
@property (nonatomic,strong)NSString *CarBrand;
@property (nonatomic,strong)NSString *CarType;
//人员配置信息
@property (nonatomic,strong)NSData *PersonHeadImageInfo;
@property (nonatomic,strong)NSString *PersonName;
@property (nonatomic,strong)NSString *PersonBirthday;
@property (nonatomic,assign)NSInteger *PersonSex;
@property (nonatomic,assign)NSInteger *PersonHeight;
@property (nonatomic,assign)NSInteger *PersonWeight;
//宠物配置信息
@property (nonatomic,strong)NSString *PetHeadImageInfo;
@property (nonatomic,strong)NSString *PetName;
@property (nonatomic,strong)NSString *PetBreed;
@property (nonatomic,strong)NSString *PetType;
@property (nonatomic,strong)NSString *PetBirthday;
@property (nonatomic,assign)NSInteger *PetSex;
@property (nonatomic,assign)NSInteger *PetHeight;
@property (nonatomic,assign)NSInteger *PetWeight;



//@property (nonatomic,strong)
+ (id)sharedInstance;

@end
