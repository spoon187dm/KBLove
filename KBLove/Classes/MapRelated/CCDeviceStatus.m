//
//  CCDeviceStatus.m
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "CCDeviceStatus.h"
#import "CCUtils.h"
//#import "MapUtils.h"
//#import "CCAccountManager.h"

@implementation CCDeviceStatus

-(id)generateJasonObj
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSNumber numberWithLongLong:_uid] forKey:kID];
    double lang = _lang / 1e6;
    [dict setValue:[NSNumber numberWithDouble:lang] forKey:kLANG];
    double lat = _lat / 1e6;
    [dict setValue:[NSNumber numberWithDouble:lat] forKey:kLAT];
    [dict setValue:[NSNumber numberWithFloat:_speed] forKey:kSPEED];
    [dict setValue:[NSNumber numberWithFloat:_flowTotal] forKey:kFLOW_TOTLE];
    [dict setValue:[NSNumber numberWithFloat:_flow] forKey:kFLOW];
    [dict setValue:[NSNumber numberWithInt:_battery] forKey:kBATTERY];
    [dict setValue:[NSNumber numberWithInt:_status] forKey:kSTATUS];
    // TODO 到底用的是哪个？
//    [dict setValue:[NSNumber numberWithFloat:_heading] forKey:kHEAD];
    [dict setValue:[NSNumber numberWithFloat:_heading] forKey:kDIRECTION];
    [dict setValue:[NSNumber numberWithLongLong:_receive] forKey:kRECEIVE];
    [dict setValue:[NSNumber numberWithInt:_stayed] forKey:kSTAYED];
    [dict setValue:[NSNumber numberWithLongLong:_stamp] forKey:kSTAMP];

    if (_address) {
        [dict setObject:_address forKey:kADDR];
    }

    return dict;
}

-(void)readFromJason:(id)jason
{
    if ([jason isEqual:[NSNull null]]) {
        return;
    }
    
    _uid = [CCUtils longLongValue:jason aKey:kID];
    _lang = [CCUtils doubleValue:jason aKey:kLANG] * 1e6;
    _lat = [CCUtils doubleValue:jason aKey:kLAT] * 1e6;

    _speed = [CCUtils floatValue:jason aKey:kSPEED];
    _flowTotal = [CCUtils floatValue:jason aKey:kFLOW_TOTLE];
    _flow = [CCUtils floatValue:jason aKey:kFLOW];

    _battery = [CCUtils intValue:jason aKey:kBATTERY];
    _status = [CCUtils intValue:jason aKey:kSTATUS];

//    _heading = [[jason valueForKey:kHEAD] longValue];
    _heading = [CCUtils longValue:jason aKey:kDIRECTION];
    _status = [CCUtils intValue:jason aKey:kSTATUS];
    _sn = [jason objectForKey:kSN];
    if ([CCUtils isEmpty:_sn]) {
        _sn = [jason objectForKey:kDEVICESN];
    }
    
    _receive = [CCUtils longLongValue:jason aKey:kRECEIVE];
    _stayed = [CCUtils intValue:jason aKey:kSTAYED];
    _address = [jason objectForKey:kADDR];
    
    _stamp = [CCUtils longLongValue:jason aKey:kSTAMP];

//    CCAccount* ac = [[CCAccountManager sharedClient] getAccount];
//    if(ac != nil) {
//        CCDevice* device = [ac getDeviceBySn:_sn];
//        if (device != nil && _status > 0 && _status != device.status.status) {
//            [ac resetDevicesStatusBySn:_sn status:_status];
//        }
    
//        if (device != nil && ((_stamp > 0 && _stamp > device.status.stamp) || nil == device.status)) {
//            [ac requestDevicesBySn:_sn showloading:NO];
//        }
//    }

    [self convertPoint];
}

-(void) convertPoint
{
    CLLocationCoordinate2D tmp;
    tmp.latitude = _lat / 1e6;
    tmp.longitude = _lang / 1e6;
    NSDictionary *Dic_fixlocation = BMKConvertBaiduCoorFrom(tmp,BMK_COORDTYPE_GPS);
    CLLocationCoordinate2D fixLocationCoordiante = BMKCoorDictionaryDecode(Dic_fixlocation);
    // TODO 是否要乘以 1e6？
    _point.longitudeE6 = fixLocationCoordiante.longitude * 1e6;
    _point.latitudeE6 = fixLocationCoordiante.latitude * 1e6;
}

-(NSString*)getAddress
{
    if (_address == nil) {
        NSString* addrString = [NSString stringWithFormat:@"经纬度:(%f, %f)", _lang/1e6, _lat/1e6];
        if (!_addressRequested) {
            _addressRequested = YES;
            
            CLLocationCoordinate2D coord;
            coord.longitude = _lang / 1e6;
            coord.latitude = _lat / 1e6;
//            [[CCGeoHelper sharedClient] getAddress:coord delegate:self];
        }
        return addrString;
    }
    return _address;
}

-(void)onGetAddress:(NSString *)address
{
    _address = address;
//    if(_geoDelegate) {
//        [_geoDelegate performSelector:@selector(onGetAddress:) withObject:address];
//    }
}

-(void)readFromArray:(id)array
{
//    strArray[0] = lng
//    strArray[1] = lat
//    strArray[2] = receive
//    strArray[3] = mode
//    strArray[4] = deviceSn
//    strArray[5] = battery
//    strArray[6] = speed
//    strArray[7] = direction
//    strArray[8] = stamp
//    strArray[9] = status
//    strArray[10] = stayed
//    strArray[11] = alarm
//    strArray[12] = flow
//    strArray[13] = info
    if (array && [array isKindOfClass:[NSArray class]]) {
        NSArray* dataArray = (NSArray*)array;
        @try {
            _lang = [[dataArray objectAtIndex:0] floatValue] * 1e6;
            _lat = [[dataArray objectAtIndex:1] floatValue] * 1e6;
            _receive = [[dataArray objectAtIndex:2] longLongValue];
            _sn = [dataArray objectAtIndex:4];
            _battery = [[dataArray objectAtIndex:5] intValue];
            _speed = [[dataArray objectAtIndex:6] floatValue];
            _heading = [[dataArray objectAtIndex:7] floatValue];
            _stamp = [[dataArray objectAtIndex:8] longLongValue];
            _status = [[dataArray objectAtIndex:9] intValue];
            if (dataArray.count == 12) {
                _stayed = [[dataArray objectAtIndex:10] intValue];
                _flow = [[dataArray objectAtIndex:12] floatValue];
            }
        }
        @catch (NSException *exception) {
//            debugLog(@"CCDeviceStatus readFromArray error %@", exception);
        }
        @finally {
        }
    }
}


@end
