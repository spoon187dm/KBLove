//
//  CCFence.m
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "CCFence.h"
//#import "CCAccountManager.h"
#import "ZWL_Utils.h"
#import "ZWL_MapUtils.h"
//#import "CCPointHelper.h"

@implementation CCFence

@synthesize outType = _outType;
@synthesize type = _type;
@synthesize name = _name;
@synthesize lang = _lang;
@synthesize lat = _lat;
@synthesize radius = _radius;
@synthesize sn = _sn;
@synthesize points = _points;

-(id)generateJasonObj
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:[NSNumber numberWithInt:_type] forKey:kTYPE];
    if (_name) {
        [dict setObject:_name forKey:kNAME];
    }
    [dict setValue:[NSNumber numberWithInt:_outType] forKey:kOUTSTR];
    if (_sn) {
        [dict setObject:_sn forKey:kDEVICE_SN];
    }
    
    if (_type == CIRCLE) {
    
        [dict setValue:[NSNumber numberWithInt:_radius] forKey:kRADIUS];
        NSMutableArray* array = [[NSMutableArray alloc] init];
        NSInteger lang = (_lang / 1e6);
        [array addObject:[NSNumber numberWithInt:lang]];
        NSInteger lat = (_lat / 1e6);
        [array addObject:[NSNumber numberWithInt:lat]];
        [dict setObject:array forKey:kCENTER];
    }
    else
    {
        if (_points != nil) {
            NSMutableArray* array = [[NSMutableArray alloc] init];
            NSInteger size = _points.count;
            for (NSInteger i = 0; i < size; i++) {
                NSMutableDictionary* p = [[NSMutableDictionary alloc]init];
                // add:
                BMKGeoPoint point;
                id item = [_points objectAtIndex:i];
                [item getValue:&point];
//                BMKGeoPoint wgsPoint = [MapUtils convertBd09ToWgs:point];
                
//                [[array objectAtIndex:i] getValue:&point];
                NSInteger lang = point.longitudeE6 / 1e6;
                [p setValue:[NSNumber numberWithInt:lang] forKey:kLANG];
                NSInteger lat = point.latitudeE6 / 1e6;
                [p setValue:[NSNumber numberWithInt:lat] forKey:kLAT];

                [array addObject:p];
            }
            [dict setObject:array forKey:kREGION];
        }
    }
    //此处应添加  token  user_id
    
//    CCAccount* account = [[CCAccountManager sharedClient] getAccount];
//    if (account != nil) {
//        [dict setObject:account.token forKey:kTOKEN];
//        [dict setObject:account.userId forKey:kUSERID];
//    }
    
    return dict;
}

-(void)readFromJason:(id)jason
{
    if ([jason isEqual:[NSNull null]]) {
        return;
    }
    
    _type = [ZWL_Utils intValue:jason aKey:kTYPE];
    _name = [jason objectForKey:kNAME];
    _outType = [ZWL_Utils intValue:jason aKey:kOUTSTR];
    _sn = [jason objectForKey:kDEVICE_SN];
    if (_type == CIRCLE) {
        _radius = [ZWL_Utils intValue:jason aKey:kRADIUS];
        NSArray* array = [jason objectForKey:kCENTER];
        if (![ZWL_Utils isNull:array] && array.count >= 2) {
            NSNumber* lng = [array objectAtIndex:0];
            if (![lng isEqual:[NSNull null]]) {
                _lang = [lng doubleValue] * 1e6;
            }
            NSNumber* lat = [array objectAtIndex:1];
            if (![lat isEqual:[NSNull null]]) {
                _lat = [lat doubleValue] * 1e6;
            }
        }
    } else {
        if (_points == nil) {
            _points = [[NSMutableArray alloc]init];
        }
        
        [_points removeAllObjects];
        NSArray* array = [jason objectForKey:kREGION];
        if (![ZWL_Utils isNull:array]) {
            NSInteger size = array.count;
            for (NSInteger i = 0; i < size; i++) {
                id obj = [array objectAtIndex:i];
                NSDictionary* p;
                if ([obj isKindOfClass:[NSDictionary class]] && ![ZWL_Utils isNull:obj]) {
                    p = (NSDictionary*) obj;
                }
                
                int lng = [ZWL_Utils doubleValue:p aKey:kLANG] * 1e6;
                int lat =  [ZWL_Utils doubleValue:p aKey:kLAT] * 1e6;
                BMKGeoPoint point;
                point.latitudeE6 = lat;
                point.longitudeE6 = lng;
                [_points addObject:[NSValue value:&point withObjCType:@encode(BMKGeoPoint)]];
            }
        }
    }
}

@end
