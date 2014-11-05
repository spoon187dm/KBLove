//
//  MapUtils.h
//  Tracker
//
//  Created by apple on 13-12-1.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "CCDeviceStatus.h"
#import <MAMapKit/MAMapKit.h>
#define EARTH_RADIUS 6378.137f


@interface ZWL_MapUtils : NSObject



+ (ZWL_MapUtils *)sharedClient;
+(CLLocationCoordinate2D) geoPoint2Coordinate2D:(BMKGeoPoint)p;
+(CLLocationCoordinate2D)geoGaoDePoint2Coordinate2D:(MAMapPoint)p;

+(BMKGeoPoint) coordinate2D2geoPoint:(CLLocationCoordinate2D)coor;
+(MAMapPoint)coordinate2D2geoGaoDePoint:(CLLocationCoordinate2D)coor;

+(CLLocationCoordinate2D) wgs84ToBaiduCoord:(BMKGeoPoint)p;

+(CLLocationCoordinate2D)getRealCoordByStatus:(CCDeviceStatus*)status;
+(BMKGeoPoint)getRealCoordByCoord:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

// 百度地图坐标到gps坐标（误差较小）
+(BMKGeoPoint) wgs84ToBaiduPoint:(BMKGeoPoint)point;
+(BMKGeoPoint)convertBd09ToWgs:(BMKGeoPoint)point;

+(double) getDistance:(BMKGeoPoint)p1 p2:(BMKGeoPoint)p2;

+(CLLocationCoordinate2D)findCenterPoint:(CLLocationCoordinate2D)_lo1 _loc2:(CLLocationCoordinate2D)_loc2;

+(double) adjustAngle:(double)lat_a lng_a:(double)lng_a lat_b:(double)lat_b lng_b:(double)lng_b;

+(CGFloat) getAngel:(BMKGeoPoint)p1 p2:(BMKGeoPoint)p2;
+(CGFloat)getGaoDeAngel:(MAMapPoint)p1 p2:(MAMapPoint)p2;
/**
 *判断两个点是否相等
 *@param point1 第一个点
 *@param point2 第二个点
 *@return 如果两点相等，返回YES，否则返回NO
 */
+(BOOL) BMKGeoPointEqualToPoint:(BMKGeoPoint)point1 point2:(BMKGeoPoint) point2;

+(BMKGeoPoint) getPositionByRatio:(BMKGeoPoint)start end:(BMKGeoPoint)end ratio:(CGFloat)radtio;
+(MAMapPoint) getGaoDePositionByRatio:(MAMapPoint)start end:(MAMapPoint)end ratio:(CGFloat)radtio;

+(BMKGeoPoint) getCenterPoint:(BMKGeoPoint)start end:(BMKGeoPoint)end;

+(void) adjustMapCenterAndSpan:(BMKMapView*)mapView statusInfo:(NSArray*) statusInfo; // CCDeviceStatus
+(void) adjustGaoDeMapCenterAndSpan:(MAMapView*)mapView statusInfo:(NSArray*) statusInfo;


+(void) adjustMapCenterAndSpan:(BMKMapView*)mapView start:(CLLocationCoordinate2D) start end:(CLLocationCoordinate2D)end;

+ (CLLocationCoordinate2D)coordinateFromCoord:(CLLocationCoordinate2D)fromCoord
                                 atDistanceKm:(double)distanceKm
                             atBearingDegrees:(double)bearingDegrees;

+ (BMKGeoPoint)geoPointFromPoint:(BMKGeoPoint)fromPoint
                    atDistanceKm:(double)distanceKm
                atBearingDegrees:(double)bearingDegrees;
@end
