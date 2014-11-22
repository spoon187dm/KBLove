//
//  ZWL_MapViewTool.m
//  KBLove
//
//  Created by qianfeng on 14-11-3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "ZWL_MapViewTool.h"

@implementation ZWL_MapViewTool
{
    NSString *pointimg;
}

-(void)addMapViewToViewController:(UIViewController *)controller frame:(CGRect)rect location:(CLLocationCoordinate2D)location title:(NSString *)titlestr subtitle:(NSString *)subtitleStr image:(NSString *)imageurl
{
    pointimg=imageurl;
    if ([[[KBUserInfo sharedInfo]mapTypeName] isEqualToString:kMapTypeBaiduMap]) {
        BMKMapView *map=[[BMKMapView alloc]initWithFrame:rect];
        [controller.view addSubview:map];
        map.delegate=self;
        BMKPointAnnotation *p=[[BMKPointAnnotation alloc]init];
        p.coordinate = location;
        if (titlestr.length!=0) {
            p.title = titlestr;
        }
        if (subtitleStr.length!=0) {
            p.subtitle =subtitleStr;
        }
        [map addAnnotation:p];
    }else{
        MAMapView *map=[[MAMapView alloc]initWithFrame:rect];
        [controller.view addSubview:map];
        map.delegate=self;
        MAPointAnnotation *p=[[MAPointAnnotation alloc]init];
        p.coordinate = location;
        if (titlestr.length!=0) {
            p.title = titlestr;
        }
        if (subtitleStr.length!=0) {
            p.subtitle =subtitleStr;
        }
        [map addAnnotation:p];
    }
}


#pragma mammapview Delegate

-(UIView *)mapView:(UIView *)mapView viewForAnnotation:(id)annotation
{
    static NSString* annotationIdentifier = @"mapPin";
    //    百度
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        //        if (annotation == Point) {
        BMKPinAnnotationView* annView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:annotationIdentifier];
        annView.image =  [UIImage imageNamed:pointimg];
        return annView;
        //        }
        
    }
    //    高德地图
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        //        if (annotation == Point) {
        MAAnnotationView * annView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                                  reuseIdentifier:annotationIdentifier];
        annView.image =  [UIImage imageNamed:pointimg];
        return annView;
        //        }
    }
    return nil;
}


@end
