//
//  CCWarning.m
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "CCWarning.h"
//#import "CCAccountManager.h"
#import "CCTimeUtils.h"
#import "CCUtils.h"

@implementation CCWarning

-(id)generateJasonObj
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSNumber numberWithInt:_type] forKey:kTYPE];
    [dict setValue:[NSNumber numberWithLongLong:_serialNum] forKey:kSERIALNUM];
    [dict setValue:[NSNumber numberWithLongLong:_uid] forKey:kID];
    [dict setValue:[NSNumber numberWithDouble:_lang / 1e6] forKey:kLANG];
    [dict setValue:[NSNumber numberWithDouble:_lat / 1e6] forKey:kLAT];
    [dict setValue:[NSNumber numberWithFloat:_speed] forKey:kSPEED];
    
    if (_info) {
        [dict setObject:_info forKey:kINFO];
    }
    
    [dict setValue:[NSNumber numberWithInt:_level] forKey:kLEVEL];
    [dict setValue:[NSNumber numberWithInt:_readState] forKey:kREADED];
    [dict setValue:[NSNumber numberWithLongLong:_time] forKey:kTIME];
    
    if (_sn) {
        [dict setObject:_sn forKey:kDEVICESN];
    }
    [dict setValue:[NSNumber numberWithInt:_battery] forKey:kBATTERY];
    [dict setValue:[NSNumber numberWithInt:_flow] forKey:kFLOW];
    
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
    _type = [CCUtils intValue:jason aKey:kTYPE];
    _serialNum = [CCUtils longLongValue:jason aKey:kSERIALNUM];
    _uid = [CCUtils longLongValue:jason aKey:kID];
    _lang = [CCUtils doubleValue:jason aKey:kLANG] * 1e6;
    _lat = [CCUtils doubleValue:jason aKey:kLAT] * 1e6;
    _speed = [CCUtils floatValue:jason aKey:kSPEED];

    _info = [jason valueForKey:kINFO];
    _level = [CCUtils intValue:jason aKey:kLEVEL];
    _readState = [CCUtils intValue:jason aKey:kREADED];

    _time = [CCUtils longLongValue:jason aKey:kTIME];
    _sn = [jason valueForKey:kDEVICESN];
    _battery = [CCUtils intValue:jason aKey:kBATTERY];
    _flow = [CCUtils intValue:jason aKey:kFLOW];
    _address = [jason valueForKey:kADDR];
}

-(NSString*) getAddress
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

-(void) onAddressReset:(NSString*)address
{
    _address = address;
//    if(_geoDelegate) {
//        [_geoDelegate performSelector:@selector(onGetAddress:) withObject:address];
//    }
}

-(NSString*) getTimeStr
{
    if (_timeStr == nil) {
        _timeStr = [CCTimeUtils getAppleTimeFormat:_time];
    }
    return  _timeStr;
}

-(NSString*) getWarningDeviceName:(CCWarning*)aWarn
{
//    CCAccount* account = [[CCAccountManager sharedClient] getAccount];
//    if (account == nil) {
//        return aWarn.sn;
//    }
    
//    CCDevice* device = [account getDeviceBySn:aWarn.sn];
    return @" ******* ";
}


/*
 XX（警报发生时间）XX（设备名称）在XX（警报发生地点）以XX速度（警报时设备超速的速度）发生超速。
 XX（警报发生时间）XX（设备名称）在XX（警报发生地点）电量剩余XX（警报时设备的电量），请注意充电
 XX（警报发生时间）XX（设备名称）在XX（警报发生地点）发出SOS警报
 XX（警报发生时间）XX（设备名称）在XX（警报发生地点）发生移动，请注意.
 XX（警报发生时间）XX（设备名称）在XX（警报发生地点）设备与基座接连终端，请注意宠物位置信息
 XX（警报发生时间）XX（设备名称）在XX（警报发生地点）超出/进入设定围栏，请注意
 */
-(NSString*)getWarningDetailDes:(BOOL)isFullTime
{
    NSMutableString* ret = [[NSMutableString alloc]init];
    if (isFullTime) {
        [ret appendString:[CCTimeUtils getFullTime:_time]];
    } else {
        [ret appendString:[self getTimeStr]];
    }
    
    NSString* name = [self getWarningDeviceName:self];
    [ret appendString:name];
    [ret appendString:@" ( "];
    [ret appendString:_sn];
    [ret appendString:@" ) "];
    [ret appendString:@"在"];
    
    NSString* addr = [self getAddress];
    if (![CCUtils isEmpty:addr]) {
        [ret appendString:[self getAddress]];
    }

    switch (_type) {
        case ALARM_OUT:
			[ret appendString:@"超出设定围栏，请注意"];
			break;
            
		case ALARM_IN:
			[ret appendString:@"进入设定围栏，请注意"];
			break;
            
		case ALARM_LOW_BATTERY:
			[ret appendFormat:@"电量剩余：%d%%, 请注意充电", _battery];
			break;
            
		case ALARM_SPDHI:
            [ret appendFormat:@"以 %dkm/h 的速度, 发生超速警报。", (int)_speed];
			break;

            
		case ALARM_SOS:
			[ret appendString:@"发出SOS警报"];
			break;
//
//		case ALARM_VIB:
//			[ret appendString:@"发生振动警报"];
//			break;
//            
//		case ALARM_EPD:
//			// 外电警报
//			[ret appendString:@"外电警报"];
//			break;
//            
//		case ALARM_BAT:
//			// 防盗警报
//			[ret appendString:@"发生移动，请注意."];
//			break;
//            
//		case ALARM_SPDLO:
//            [ret appendFormat:@"以%f速度, 发生低速警报。", _speed];
//			break;
//            
//		case ALARM_BLUETOOTH:
//			[ret appendString:@"设备与基座接连终端，请注意宠物位置信息"];
//			break;
//            
//		case ALARM_FLOW:
//            [ret appendFormat:@"流量剩余：%d, 请注意充值", _flow];
//			break;
            
		case ALARM_BREAKAWAY:
			[ret appendString:@"设备从基座中拔出，请注意."];
			break;

		case ALARM_MOVING:
			[ret appendString:@"发生移动，请注意."];
            break;
            
        default:
            break;
    }
    
    return [NSString stringWithString:ret];
}

-(NSString*) getWarningDialogMessage:(NSString*)deviceName
{
    NSString* time = [CCTimeUtils getAppleTimeFormat:_time];
    return [NSString stringWithFormat:@"设备 %@ 于 %@ 发生 %@", deviceName, time, [self getWarningTypeDes]];
}

-(NSString*) getWarningTypeDes
{
    switch (_type) {
        case ALARM_OUT:
            return @"出围栏警报";
            
		case ALARM_IN:
            return @"进围栏警告";
            
		case ALARM_LOW_BATTERY:
            return @"低电警报";
            
		case ALARM_SPDHI:
            return @"超速警告";
            
		case ALARM_BREAKAWAY:
			return @"拔出警报";
            
		case ALARM_MOVING:
			return @"移动警报";
            
        case ALARM_SOS:
			return @"SOS警报";
        default:
            break;
    }
    return @"警报";
}

-(void)readFromArray:(id)array
{
//    strArray[0] = lng
//    strArray[1] = lat
//    strArray[2] = receive
//    strArray[3] = type
//    strArray[4] = deviceSn
//    strArray[5] = info
//    strArray[6] = speed
//    strArray[7] = addr
//    strArray[8] = read
//    strArray[9] = id
//    strArray[10] = battery
    if (array && [array isKindOfClass:[NSArray class]]) {
        NSArray* dataArray = (NSArray*)array;
        @try {
            _lang = [[dataArray objectAtIndex:0] floatValue] * 1e6;
            _lat = [[dataArray objectAtIndex:1] floatValue] * 1e6;
            _time = [[dataArray objectAtIndex:2] longLongValue];
            _type = [[dataArray objectAtIndex:3] intValue];
            _sn = [dataArray objectAtIndex:4];
            _info = [dataArray objectAtIndex:5];
            _speed = [[dataArray objectAtIndex:6] floatValue];
            _address = [dataArray objectAtIndex:7];
            _readState = [[dataArray objectAtIndex:8] intValue];
            _uid = [[dataArray objectAtIndex:9] longLongValue];
            _battery = [[dataArray objectAtIndex:10] intValue];
        }
        @catch (NSException *exception) {
//            debugLog(@"Warnging readFromArray error %@", exception);
        }
        @finally {
        }
    }
}

@end
