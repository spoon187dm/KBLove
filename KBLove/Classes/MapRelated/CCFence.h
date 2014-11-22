//
//  CCFence.h
//  Tracker
//
//  Created by apple on 13-11-5.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
#import "CCJASONObject.h"

@interface CCFence : NSObject<CCJASONObject>

@property (nonatomic, assign) NSInteger outType;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger lang;
@property (nonatomic, assign) NSInteger lat;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, copy) NSString* sn;

// ArrayList<GeoPoint> mPoints;
@property  (nonatomic, strong) NSMutableArray* points;

@end
