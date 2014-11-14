//
//  KBPositionInfo.h
//  KBLove
//
//  Created by 1124 on 14/10/24.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBPositionInfo : NSObject
@property(nonatomic,copy)   NSString *positionname;
@property(nonatomic,strong) NSNumber *latitudeNumber;
@property(nonatomic,strong) NSNumber *longitudeNumber;
@property(nonatomic,strong) NSString *positionDes;
@end