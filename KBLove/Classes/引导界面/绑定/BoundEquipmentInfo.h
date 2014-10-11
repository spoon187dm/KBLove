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

@property (nonatomic, strong) NSString * CarHeadImageInfo;
@property (nonatomic,strong)NSString *CarName;
@property (nonatomic,strong)NSString *CarNum;
@property (nonatomic,strong)NSString *CarBrand;
@property (nonatomic,strong)NSString *CarType;

//@property (nonatomic,strong)
+ (id)sharedInstance;

@end
