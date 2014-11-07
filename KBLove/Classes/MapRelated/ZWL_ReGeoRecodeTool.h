//
//  ZWL_ReGeoRecodeTool.h
//  KBLove
//
//  Created by qianfeng on 14-11-3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "CCDeviceStatus.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

typedef void (^ GeocodeResult)(NSMutableArray *resultArray);

@interface ZWL_ReGeoRecodeTool : NSObject<AMapSearchDelegate>

@property (nonatomic,strong)  AMapReGeocodeSearchRequest *GeoRecodeRequest;
@property (nonatomic,assign)  GeocodeResult responseBlock;
@property (nonatomic,strong)  AMapSearchAPI * search;


+(void)GaoDeMapViewReGeocodeWithCoordinate:(CLLocationCoordinate2D)location viewController:(UIViewController *)controller response:(GeocodeResult)responseBlock;

@end
