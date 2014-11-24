//
//  CCBaseRelation.h
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCJASONObject.h"

@interface CCBaseRelation : NSObject<CCJASONObject>

@property (nonatomic, assign) int age;
@property (nonatomic) NSString* description;

-(void) writeToJson:(id)aJson;

+(CCBaseRelation*)createRelation:(NSInteger)aType;

@end
