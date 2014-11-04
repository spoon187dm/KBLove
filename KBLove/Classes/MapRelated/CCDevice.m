//
//  CCDevice.m
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "CCDevice.h"
#import "ZWL_Utils.h"
//#import "CCAccountManager.h"

@implementation CCDevice

- (id)init
{
    self = [super init];
    if (self) {
        _type = DEVICE_CAR;
        _warnings = [[NSMutableArray alloc]init];
        _sosNums = [[NSMutableArray alloc]init];
        
        _tick = INVALID_ID;
        _flow = INVALID_ID;
        _battery = INVALID_ID;
        _warningBattery = INVALID_ID;
        _warningFlow = INVALID_ID;
        _speedThreshold = INVALID_ID;
        
        _overItemIndex = INVALID_ID;
        
        _movingSwitch = INVALID_SWITCH;
        _speedingSwitch = INVALID_SWITCH;
        _breakAwaySwitch = INVALID_SWITCH;
        _fenceWarningSwitch = INVALID_SWITCH;
        _smsWarningSwitch = INVALID_SWITCH;
    }
    return self;
}

-(id)initWithSn:(NSString *)aSn
{
    self = [self init];
    if (!self) {
        _sn = aSn;
        _name = aSn;
    }
    return self;
}

-(id)generateJasonObj
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if (_sn) {
        [dict setObject:_sn forKey:kSN];
    }
    
    if (![ZWL_Utils isNull:_name]) {
        [dict setObject:_name forKey:kNAME];
    }
    
    if (_email) {
        [dict setObject:_email forKey:kEMAIL];
    }
    
    if (_avatarUrl) {
        [dict setObject:_avatarUrl forKey:kICON];
    }
    
    if (_avatarStamp != INVALID_ID) {
        [dict setValue:[NSNumber numberWithLongLong:_avatarStamp] forKey:kSTAMP];
    }

    if (_phoneNumber) {
        [dict setObject:_phoneNumber forKey:kPHONE_NUMBER];
    }

    if (_type != DEVICE_UNKNOW) {
        [dict setObject:[NSNumber numberWithInt:_type] forKey:kTYPE];
    }
    
    if (![ZWL_Utils isEmpty:_hardware]) {
        [dict setObject:_hardware forKey:kHARDWARE];
    }
    
    if (_relation) {
        id relation = [_relation generateJasonObj];
        if (relation) {
            [dict setValue:relation forKey:kRELATION_OBJ];
        }
    }
    
    if (_regionFence) {
        id fence = [_regionFence generateJasonObj];
        if (fence) {
            [dict setValue:fence forKey:kFENCE];
        }
    }
    
    if (_tick != INVALID_ID) {
        [dict setValue:[NSNumber numberWithInt:_tick] forKey:kTICK];
    }
    
    if (_warningBattery != INVALID_ID) {
        [dict setValue:[NSNumber numberWithInt:_warningBattery] forKey:kWARNING_BATTERY];
    }
    
    if (_warningFlow != INVALID_ID) {
        [dict setValue:[NSNumber numberWithInt:_warningFlow] forKey:kWARNING_FLOW];
    }
    
    if (_speedThreshold != INVALID_ID) {
        [dict setValue:[NSNumber numberWithInt:_speedThreshold] forKey:kSPEED_THRESHOLD];
    }
    
    if (_speedingSwitch != INVALID_SWITCH) {
        [dict setValue:[NSNumber numberWithInt:_speedingSwitch] forKey:kSPEEDING_SWITCH];
    }
    
    if (_movingSwitch != INVALID_SWITCH) {
        [dict setValue:[NSNumber numberWithInt:_movingSwitch] forKey:kMOVING_SWITCH];
    }
    
    if (_breakAwaySwitch != INVALID_SWITCH) {
        [dict setValue:[NSNumber numberWithInt:_breakAwaySwitch] forKey:kBREAK_AWAY_SWITCH];
    }
    
    if (_fenceWarningSwitch != INVALID_SWITCH) {
        [dict setValue:[NSNumber numberWithInt:_fenceWarningSwitch] forKey:kSMS_SWITCH];
    }
    
    if (_status) {
        id status = [_status generateJasonObj];
        [dict setObject:status forKey:kPOSITION];
    }
  
    // mWarning
    NSMutableArray* warningArray = [[NSMutableArray alloc]init];
    if (_warnings) {
        NSInteger count = [_warnings count];
        for (NSInteger i = 0; i < count; i ++) {
            CCWarning* warning = [_warnings objectAtIndex:i];
            id json = [warning generateJasonObj];
            [warningArray addObject:json];
        }
    }
    [dict setObject:warningArray forKey:kWARNINGS];

    if (![ZWL_Utils isNull:_sosNums]) {
        NSInteger count = [_sosNums count];
        for (NSInteger i = 0 ; i < count;  i++) {
            [dict setObject:[_sosNums objectAtIndex:i]  forKey:kSOS_NUM];
        }
    }
   
    if (_relation) {
        [_relation writeToJson:dict];
    }
  
    return dict;
}

-(void)readFromJason:(id)jason
{
    if ([jason isEqual:[NSNull null]]) {
        return;
    }
    _sn = [jason objectForKey:kSN];
    _name = [jason objectForKey:kNAME];
    _email = [jason objectForKey:kEMAIL];
    _avatarUrl = [jason objectForKey:kICON];
    
    _avatarStamp = [ZWL_Utils longLongValue:jason aKey:kSTAMP];
    _speedThreshold = [ZWL_Utils intValue:jason aKey:kSPEED_THRESHOLD];
    _phoneNumber = [jason objectForKey:kPHONE_NUMBER];
    if ([ZWL_Utils isEmpty:_phoneNumber]) {
        _phoneNumber = [jason objectForKey:kPHONE];
    }
    
    _hardware = [jason objectForKey:kHARDWARE];
    _type = [ZWL_Utils intValue:jason aKey:kTYPE];
    _movingSwitch = [ZWL_Utils intValue:jason aKey:kMOVING_SWITCH];
    _speedingSwitch = [ZWL_Utils intValue:jason aKey:kSPEEDING_SWITCH];
    _breakAwaySwitch = [ZWL_Utils intValue:jason aKey:kBREAK_AWAY_SWITCH];
    _fenceWarningSwitch = [ZWL_Utils intValue:jason aKey:kFENCE_SWITCH];
    _smsWarningSwitch = [ZWL_Utils intValue:jason aKey:kSMS_SWITCH];
    id statusJson = [jason objectForKey:kPOSITION];
    _status = [[CCDeviceStatus alloc]init];
    [_status readFromJason:statusJson];
    
    id sos = [jason objectForKey:kSOS_NUM];
    if ([sos isKindOfClass:NSArray.class] && ![ZWL_Utils isNull:sos]) {
        [_sosNums addObjectsFromArray:sos];
    } else if ([sos isKindOfClass:NSString.class]) {
        [_sosNums addObject:sos];
    }
    if (_sosNums.count == 0) {
        id sms = [jason objectForKey:kSMS_NUM];
        if ([sms isKindOfClass:NSArray.class] && ![ZWL_Utils isNull:sms]) {
            [_sosNums addObjectsFromArray:sms];
        } else if ([sms isKindOfClass:NSString.class]) {
            [_sosNums addObject:sms];
        }
    }

    id fenceJson = [jason objectForKey:kFENCE];
    if (![ZWL_Utils isNull:fenceJson]) {
        _regionFence = [[CCFence alloc]init];
        [_regionFence readFromJason:fenceJson];
    }
    
    _relation = [CCBaseRelation createRelation:_type];
    [_relation readFromJason:jason];
   
    _tick = [ZWL_Utils intValue:jason aKey:kTICK];
    _warningBattery = [ZWL_Utils intValue:jason aKey:kWARNING_BATTERY];
    _warningFlow = [ZWL_Utils intValue:jason aKey:kWARNING_FLOW];

    NSArray* warnArray = [jason objectForKey:kWARNINGS];
    if (![ZWL_Utils isNull:warnArray]) {
        NSInteger count = [warnArray count];
        for (NSInteger i = 0; i < count; i++) {
            id tmp = [warnArray objectAtIndex:i];
            if (tmp) {
                CCWarning* warning = [[CCWarning alloc]init];
                [warning readFromJason:tmp];
                [_warnings addObject:warning];
            }
        }
    }
    
    // 加载头像
//    String path = FindDogsApp.sDataStronePath + mIconStamp + mSn + ".png";
//    boolean exist = FileUtils.isFileExist(path);
//    if (!exist) {
//        DownloadHeadImgs.downloadDeviceHead(this);
//    } else {
//        Bitmap bmp = BitmapUtils.loadBmpFromFile(path);
//        if (null == bmp) {
//            FileUtils.deleteFile(path);
//            DownloadHeadImgs.downloadDeviceHead(this);
//        } else {
//            mIconDrawable = new BitmapDrawable(bmp);
//        }
//    }
}

-(long long) getLastWarningTime
{
    long long time = -1;
    NSInteger size = _warnings.count;
    for (NSInteger i = 0; i < size; i++) {
        CCWarning *w = [_warnings objectAtIndex:i];
        if (w == nil) {
            continue;
        }
        if (w.time > time) {
            time = w.time;
        }
    }
    return time;
}

-(NSString*) getName
{
    if ([ZWL_Utils isEmpty:_name]) {
        return _sn;
    }
    return _name;
}

-(BOOL)hasUnreadWarning
{
    return [self getUnreadWarnNum] > 0;
}

-(NSInteger) getUnreadWarnNum
{
    NSInteger count = 0;
    NSInteger size = _warnings.count;
    for (NSInteger i = 0; i < size; ++i) {
        CCWarning* warn = [_warnings objectAtIndex:i];
        if (nil == warn || warn.readState == READ) {
            continue;
        }
        ++count;
    }
    return count;
}

- (bool) isAddressChanged:(NSInteger)lat lng:(NSInteger)lng
{
    if (_status.lang == lng && _status.lat == lat) {
        return false;
    }
    return true;
}

-(NSString*) getDefaultAvatar
{
    switch (_type) {
        case DEVICE_CAR:
            return @"head_car.png";
            
        case DEVICE_PET:
            return @"head_pet.png";
            
        case DEVICE_PERSON:
            return @"head_person.png";
            
        default:
            break;
    }
    return nil;
}

-(void) updateInfo:(CCDevice*)result
{
    if (result.name != nil) {
        _name = result.name;
    }
    
    if (result.email != nil) {
        _email = result.email;
    }
    
    if (result.avatarUrl != nil) {
        _avatarUrl= result.avatarUrl;
    }
    
    if (result.phoneNumber != nil) {
        _phoneNumber= result.phoneNumber;
    }
    
    if (result.type != DEVICE_UNKNOW) {
        _type = result.type;
    }
    
    if (result.relation != nil) {
        _relation = result.relation;
    }
    
    if (result.regionFence != nil) {
        _regionFence = result.regionFence;
    }
    
    if (result.tick != INVALID_ID) {
        _tick = result.tick;
    }
    
    if (result.warningBattery != INVALID_SWITCH) {
        _warningBattery = result.warningBattery;
    }
    
    if (result.warningFlow != INVALID_SWITCH) {
        _warningFlow = result.warningFlow;
    }
    
    if (result.speedThreshold != INVALID_SWITCH) {
        _speedThreshold = result.speedThreshold;
    }
    
    if (result.speedingSwitch != INVALID_SWITCH) {
        _speedingSwitch = result.speedingSwitch;
    }
    
    if (result.movingSwitch != INVALID_SWITCH) {
        _movingSwitch = result.movingSwitch;
    }
    
    if (result.breakAwaySwitch != INVALID_SWITCH) {
        _breakAwaySwitch = result.breakAwaySwitch;
    }
    
    if (result.fenceWarningSwitch != INVALID_SWITCH) {
        _fenceWarningSwitch = result.fenceWarningSwitch;
    }
    
    if (result.smsWarningSwitch != INVALID_SWITCH) {
        _smsWarningSwitch = result.smsWarningSwitch;
    }
    
    if (result.sosNums.count > 0) {
        _sosNums = result.sosNums;
    }
    
    if (result.status) {
//        CCAccount* ac = [[CCAccountManager sharedClient] getAccount];
//        [ac updateDeviceStatus:result.status];
    }
}

@end
