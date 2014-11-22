//
//  ZWL_MapViewTool.h
//  KBLove
//
//  Created by qianfeng on 14-11-3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
#import <MAMapKit/MAMapKit.h>
@interface ZWL_MapViewTool : NSObject<BMKMapViewDelegate,MAMapViewDelegate>

-(void)addMapViewToViewController:(UIViewController *)controller frame:(CGRect)rect location:(CLLocationCoordinate2D)location title:(NSString *)titlestr subtitle:(NSString *)subtitleStr image:(NSString *)imageurl;


@end
