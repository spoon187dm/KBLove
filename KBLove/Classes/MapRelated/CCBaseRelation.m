//
//  CCBaseRelation.m
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "CCBaseRelation.h"

#import "ZWL_Utils.h"

@implementation CCBaseRelation

@synthesize age = _age;
@synthesize description = _description;

- (id)init
{
    self = [super init];
    if (self) {
        _age = INVALID_ID;
    }
    return self;
}

-(id)generateJasonObj
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSNumber numberWithInt:_age] forKey:kAGE];
    if (_description) {
        [dict setObject:_description forKey:kDESC];
    }
    return dict;
}

-(void)readFromJason:(id)jason
{
    if ([jason isEqual:[NSNull null]]) {
        return;
    }
    _age = [ZWL_Utils intValue:jason aKey:kAGE];
    _description = [jason objectForKey:kDESC];
}

-(void)writeToJson:(id)aJson
{
    if (_age != INVALID_ID) {
        [aJson setValue:[NSNumber numberWithInt:_age] forKey:kAGE];
        if (_description) {
            [aJson setObject:_description forKey:kDESC];
        }
    }
}

+(CCBaseRelation *)createRelation:(NSInteger)aType
{
//    CCBaseRelation* relation;
//    switch (aType) {
//        case DEVICE_CAR:
//            relation = [[CCCar alloc] init];
//            break;
//        case DEVICE_PERSON:
//            relation = [[CCPerson alloc] init];
//            break;
//        case DEVICE_PET:
//            relation = [[CCPet alloc] init];
//            break;
//            
//        default:
//            break;
//    }
    return nil;
}


@end
