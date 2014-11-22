//
//  MapUtils.m
//  Tracker
//
//  Created by apple on 13-12-1.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "ZWL_MapUtils.h"
#import "BMapKit.h"
#import "CCDeviceStatus.h"
#import <MAMapKit/MAMapKit.h>

@implementation ZWL_MapUtils

static ZWL_MapUtils *maptool;



+(CLLocationCoordinate2D)geoPoint2Coordinate2D:(BMKGeoPoint)p
{
    CLLocationCoordinate2D coor;
    coor.latitude = p.latitudeE6 / 1e6;
    coor.longitude = p.longitudeE6 / 1e6;
    return coor;
}

+(CLLocationCoordinate2D)geoGaoDePoint2Coordinate2D:(MAMapPoint)p
{
    CLLocationCoordinate2D coor;
    coor.latitude = p.x/ 1e6;
    coor.longitude = p.y/ 1e6;
    return coor;
}


+(BMKGeoPoint)coordinate2D2geoPoint:(CLLocationCoordinate2D)coor
{
    BMKGeoPoint p;
    p.latitudeE6 = coor.latitude * 1e6;
    p.longitudeE6 = coor.longitude * 1e6;
    return p;
}

+(MAMapPoint)coordinate2D2geoGaoDePoint:(CLLocationCoordinate2D)coor
{
    MAMapPoint p;
    p.x = coor.latitude * 1e6;
    p.y = coor.longitude * 1e6;
    return p;
}

+(CLLocationCoordinate2D)wgs84ToBaiduCoord:(BMKGeoPoint)p
{
    CLLocationCoordinate2D coor = [ZWL_MapUtils geoPoint2Coordinate2D:p];
    NSDictionary *Dic_fixlocation = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);    return BMKCoorDictionaryDecode(Dic_fixlocation);
}

+(BMKGeoPoint)wgs84ToBaiduPoint:(BMKGeoPoint)p
{
    CLLocationCoordinate2D coor = [ZWL_MapUtils geoPoint2Coordinate2D:p];
    NSDictionary *Dic_fixlocation = BMKConvertBaiduCoorFrom(coor, BMK_COORDTYPE_GPS);
    return [ZWL_MapUtils coordinate2D2geoPoint:BMKCoorDictionaryDecode(Dic_fixlocation)];
}


+(CLLocationCoordinate2D)getRealCoordByStatus:(CCDeviceStatus*)status
{
    CLLocationCoordinate2D coor;
    coor.latitude = status.lat / 1e6;
    coor.longitude = status.lang / 1e6;
    NSDictionary *Dic_fixlocation = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
    return BMKCoorDictionaryDecode(Dic_fixlocation);
}

+(BMKGeoPoint)getRealCoordByCoord:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
    CLLocationCoordinate2D coor;
    coor.latitude = latitude / 1e6;
    coor.longitude = longitude / 1e6;
    NSDictionary *Dic_fixlocation = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
    return [ZWL_MapUtils coordinate2D2geoPoint:BMKCoorDictionaryDecode(Dic_fixlocation)];
}

+(BMKGeoPoint)convertBd09ToWgs:(BMKGeoPoint)point
{
    BMKGeoPoint baiduPoint = [ZWL_MapUtils wgs84ToBaiduPoint:point];
    int longitudeE6 = 2 * baiduPoint.longitudeE6 - point.longitudeE6;
    int latitudeE6 = 2 * baiduPoint.latitudeE6 - point.latitudeE6;
    BMKGeoPoint p;
    p.latitudeE6 = latitudeE6;
    p.longitudeE6 = longitudeE6;
    return p;
}

+(double)getDistance:(BMKGeoPoint)p1 p2:(BMKGeoPoint)p2
{
    NSInteger dx = p1.longitudeE6 - p2.longitudeE6;
    NSInteger dy = p1.latitudeE6 - p2.latitudeE6;
    if (dx == 0 && dy == 0) {
        return 0;
    }

    CLLocationCoordinate2D a = [self geoPoint2Coordinate2D:p1];
    CLLocationCoordinate2D b = [self geoPoint2Coordinate2D:p2];
    return BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(a), BMKMapPointForCoordinate(b));
}

+(CLLocationCoordinate2D)findCenterPoint:(CLLocationCoordinate2D)_lo1 _loc2:(CLLocationCoordinate2D)_loc2
{
    CLLocationCoordinate2D center;

    double lon1 = _lo1.longitude * M_PI / 180;
    double lon2 = _loc2.longitude * M_PI / 180;
    
    double lat1 = _lo1.latitude * M_PI / 180;
    double lat2 = _loc2.latitude * M_PI / 180;
    
    double dLon = lon2 - lon1;
    
    double x = cos(lat2) * cos(dLon);
    double y = cos(lat2) * sin(dLon);
    
    double lat3 = atan2( sin(lat1) + sin(lat2), sqrt((cos(lat1) + x) * (cos(lat1) + x) + y * y) );
    double lon3 = lon1 + atan2(y, cos(lat1) + x);
    
    center.latitude  =lat3 * 180 / M_PI;
//    (_lo1.latitude+_loc2.latitude)/2;//
    center.longitude =lon3 * 180 / M_PI;

//    (_lo1.longitude+_loc2.longitude)/2;//lon3 * 180 / M_PI;
    
    return center;
}

+(double) adjustAngle:(double)lat_a lng_a:(double)lng_a lat_b:(double)lat_b lng_b:(double)lng_b
{
    if (lat_a < lat_b) {
        if ( lng_a < lng_b) {
            return 180;
        } else {
            return 90;
        }
    } else {
        if ( lng_a < lng_b) {
            return 270;
        } else {
            return 0;
        }
    }
}

//根据两个point 得到地图上设备的角度（弧度值）
+ (CGFloat)getAngel:(BMKGeoPoint)p1 p2:(BMKGeoPoint)p2
{
    CLLocationCoordinate2D startCoord = [ZWL_MapUtils geoPoint2Coordinate2D:p1];
    BMKMapPoint point1 = BMKMapPointForCoordinate(startCoord);
    
    CLLocationCoordinate2D endCoord = [ZWL_MapUtils geoPoint2Coordinate2D:p2];
    BMKMapPoint point2 = BMKMapPointForCoordinate(endCoord);
    
    CGFloat dy = ABS(point2.y - point1.y);
    CGFloat dx = ABS(point2.x - point1.x);
    if (dy == 0 && dx == 0) {
        return 0;
    }
    
    CGFloat angle = 0;
    if (dx == 0) {
        angle = M_PI / 2;
    } else {
        CGFloat val = dy / dx;
        angle = atan(val);
    }
    
    if (point2.y > point1.y) {
        if (point2.x < point1.x) {
            angle = M_PI - angle;
        }
    } else {
        if (point2.x > point1.x) {
            angle = 2 * M_PI - angle;
        } else {
            angle += M_PI;
        }
    }
    return angle;
}


//根据两个point 得到地图上设备的角度（弧度值）
+ (CGFloat)getGaoDeAngel:(MAMapPoint)p1 p2:(MAMapPoint)p2
{
    CLLocationCoordinate2D startCoord = [ZWL_MapUtils geoGaoDePoint2Coordinate2D:p1];
    MAMapPoint point1 =MAMapPointForCoordinate(startCoord);
    
    CLLocationCoordinate2D endCoord = [ZWL_MapUtils geoGaoDePoint2Coordinate2D:p2];
    MAMapPoint point2 = MAMapPointForCoordinate(endCoord);
    
    CGFloat dy = ABS(point2.y - point1.y);
    CGFloat dx = ABS(point2.x - point1.x);
    if (dy == 0 && dx == 0) {
        return 0;
    }
    
    CGFloat angle = 0;
    if (dx == 0) {
        angle = M_PI / 2;
    } else {
        CGFloat val = dy / dx;
        angle = atan(val);
    }
    
    if (point2.y > point1.y) {
        if (point2.x < point1.x) {
            angle = M_PI - angle;
        }
    } else {
        if (point2.x > point1.x) {
            angle = 2 * M_PI - angle;
        } else {
            angle += M_PI;
        }
    }
    return angle;
}



+(BOOL) BMKGeoPointEqualToPoint:(BMKGeoPoint) point1 point2:(BMKGeoPoint) point2
{
    return point1.latitudeE6 == point2.latitudeE6 && point1.longitudeE6 == point2.longitudeE6;
}

//  转换成直角坐标系，根据线性求出目标百分比所在的位置
+(BMKGeoPoint) getPositionByRatio:(BMKGeoPoint)start end:(BMKGeoPoint)end ratio:(CGFloat)radtio
{
    CLLocationCoordinate2D startCoord = [ZWL_MapUtils geoPoint2Coordinate2D:start];
    BMKMapPoint point1 = BMKMapPointForCoordinate(startCoord);
    
    CLLocationCoordinate2D endCoord = [ZWL_MapUtils geoPoint2Coordinate2D:end];
    BMKMapPoint point2 = BMKMapPointForCoordinate(endCoord);
    
    double x = point1.x + (point2.x - point1.x) * radtio;
    double y = point1.y + (point2.y - point1.y) * radtio;
    
    BMKMapPoint target = BMKMapPointMake(x, y);
    CLLocationCoordinate2D targetCoord = BMKCoordinateForMapPoint(target);
    return [ZWL_MapUtils coordinate2D2geoPoint:targetCoord];
}
+(MAMapPoint) getGaoDePositionByRatio:(MAMapPoint)start end:(MAMapPoint)end ratio:(CGFloat)radtio
{
    CLLocationCoordinate2D startCoord = [ZWL_MapUtils geoGaoDePoint2Coordinate2D:start];
    MAMapPoint point1 =MAMapPointForCoordinate(startCoord);
    
    CLLocationCoordinate2D endCoord = [ZWL_MapUtils geoGaoDePoint2Coordinate2D:end];
    MAMapPoint point2=MAMapPointForCoordinate(endCoord);
    
    double x = point1.x + (point2.x - point1.x) * radtio;
    double y = point1.y + (point2.y - point1.y) * radtio;
    
    MAMapPoint target = MAMapPointMake(x, y);
    CLLocationCoordinate2D targetCoord =MACoordinateForMapPoint(target);
    return [ZWL_MapUtils coordinate2D2geoGaoDePoint:targetCoord];
}

+(BMKGeoPoint) getCenterPoint:(BMKGeoPoint)start end:(BMKGeoPoint)end
{
    return [ZWL_MapUtils getPositionByRatio:start end:end ratio:0.5];
}

//调整地图到合适的尺寸
+(void) adjustMapCenterAndSpan:(BMKMapView*)mapView statusInfo:(NSArray*) statusInfo // CCDeviceStatus
{
    NSInteger size = statusInfo.count;
    CCDeviceStatus* status =  [statusInfo objectAtIndex:0];
    BMKGeoPoint topLeft =  status.point;
    BMKGeoPoint bottomRight = status.point;
    
    for (NSInteger i = 1; i < size; i++) {
        status = [statusInfo objectAtIndex:i];
        if (status.lat < topLeft.latitudeE6) {
            topLeft.latitudeE6 = (int)status.lat;
        }
        
        if (status.lang < topLeft.longitudeE6) {
            topLeft.longitudeE6 = (int)status.lang;
        }
        
        if (status.lat > bottomRight.latitudeE6) {
            bottomRight.latitudeE6 = (int)status.lat;
        }
        
        if (status.lang > bottomRight.longitudeE6) {
            bottomRight.longitudeE6 = (int)status.lang;
        }
    }
    
    [ZWL_MapUtils adjustMapCenterAndSpan:mapView start:[ZWL_MapUtils geoPoint2Coordinate2D:topLeft] end:[ZWL_MapUtils geoPoint2Coordinate2D:bottomRight]];
}

+(void) adjustGaoDeMapCenterAndSpan:(MAMapView*)mapView statusInfo:(NSArray*) statusInfo{
    
}
//
//+(void) adjustGaoDeMapCenterAndSpan:(MAMapView*)mapView statusInfo:(NSArray*) statusInfo // CCDeviceStatus
//{
//    NSInteger size = statusInfo.count;
//    CCDeviceStatus* status =  [statusInfo objectAtIndex:0];
//    MAMapPoint topLeft =  status.gaode_point;
//    MAMapPoint bottomRight = status.gaode_point;
//    
//    for (NSInteger i = 1; i < size; i++) {
//        status = [statusInfo objectAtIndex:i];
//        if (status.lat < topLeft.x) {
//            topLeft.x = status.lat;
//        }
//        
//        if (status.lang < topLeft.y) {
//            topLeft.y = status.lang;
//        }
//        
//        if (status.lat > bottomRight.x) {
//            bottomRight.x = status.lat;
//        }
//        
//        if (status.lang > bottomRight.y) {
//            bottomRight.y = status.lang;
//        }
//    }
//    
//    [ZWL_MapUtils adjustGaoDeMapCenterAndSpan:mapView start:[ZWL_MapUtils geoGaoDePoint2Coordinate2D:topLeft] end:[ZWL_MapUtils geoGaoDePoint2Coordinate2D:bottomRight]];
//}


//在地图上增加区域
+(void) adjustMapCenterAndSpan:(BMKMapView*)mapView start:(CLLocationCoordinate2D) start end:(CLLocationCoordinate2D)end
{
    CLLocationDegrees latituDelta = end.latitude - start.latitude;
    CLLocationDegrees longitudeDelta = end.longitude - start.longitude;
    CLLocationCoordinate2D center = [ZWL_MapUtils findCenterPoint:start _loc2:end];
    BMKCoordinateSpan span = BMKCoordinateSpanMake(latituDelta * 1.2f, longitudeDelta * 1.2f);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(center, span);
    [mapView setRegion:region animated:YES];
}
//在地图上增加区域
//+(void) adjustGaoDeMapCenterAndSpan:(MAMapView*)mapView start:(CLLocationCoordinate2D) start end:(CLLocationCoordinate2D)end
//{
//    CLLocationDegrees latituDelta = end.latitude - start.latitude;
//    CLLocationDegrees longitudeDelta = end.longitude - start.longitude;
//    CLLocationCoordinate2D center = [ZWL_MapUtils findCenterPoint:start _loc2:end];
//    MACoordinateSpan span=MACoordinateSpanMake(latituDelta * 1.2f, longitudeDelta * 1.2f);
//    MACoordinateRegion region=MACoordinateRegionMake(center, span);
//    [mapView setRegion:region animated:YES];
//}

+(void) adjustGaoDeMapCenterAndSpan:(MAMapView*)mapView start:(CLLocationCoordinate2D) start end:(CLLocationCoordinate2D)end
{
    CLLocationDegrees latituDelta = end.latitude - start.latitude;
    CLLocationDegrees longitudeDelta = end.longitude - start.longitude;
    CLLocationCoordinate2D center = [ZWL_MapUtils findCenterPoint:start _loc2:end];
    MACoordinateSpan span=MACoordinateSpanMake(latituDelta * 1.2f, longitudeDelta * 1.2f);
    MACoordinateRegion regon=MACoordinateRegionMake(center, span);
    [mapView setRegion:regon animated:YES];
}
+ (double)radiansFromDegrees:(double)degrees
{
    return degrees * (M_PI/180.0);
}

+ (double)degreesFromRadians:(double)radians
{
    return radians * (180.0/M_PI);
}

+ (CLLocationCoordinate2D)coordinateFromCoord:(CLLocationCoordinate2D)fromCoord
                                 atDistanceKm:(double)distanceKm
                             atBearingDegrees:(double)bearingDegrees
{
    double distanceRadians = distanceKm / 6371.0;
    
    //6,371 = Earth's radius in km
    double bearingRadians = [ZWL_MapUtils radiansFromDegrees:bearingDegrees];
    double fromLatRadians = [ZWL_MapUtils radiansFromDegrees:fromCoord.latitude];
    double fromLonRadians = [ZWL_MapUtils radiansFromDegrees:fromCoord.longitude];
    
    double toLatRadians = asin( sin(fromLatRadians) * cos(distanceRadians)
                               + cos(fromLatRadians) * sin(distanceRadians) * cos(bearingRadians) );
    
    double toLonRadians = fromLonRadians + atan2(sin(bearingRadians)
                                                 * sin(distanceRadians) * cos(fromLatRadians), cos(distanceRadians)
                                                 - sin(fromLatRadians) * sin(toLatRadians));
    
    // adjust toLonRadians to be in the range -180 to +180...
    toLonRadians = fmod((toLonRadians + 3*M_PI), (2*M_PI)) - M_PI;
    
    CLLocationCoordinate2D result;
    result.latitude = [self degreesFromRadians:toLatRadians];
    result.longitude = [self degreesFromRadians:toLonRadians];
    return result;
}

+ (BMKGeoPoint)geoPointFromPoint:(BMKGeoPoint)fromPoint
                                 atDistanceKm:(double)distanceKm
                             atBearingDegrees:(double)bearingDegrees
{
    CLLocationCoordinate2D fromCoord = [ZWL_MapUtils geoPoint2Coordinate2D:fromPoint];
    CLLocationCoordinate2D toCoord = [ZWL_MapUtils coordinateFromCoord:fromCoord atDistanceKm:distanceKm atBearingDegrees:bearingDegrees];
    return [ZWL_MapUtils coordinate2D2geoPoint:toCoord];
}

@end
