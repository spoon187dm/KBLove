//
//  CCGeoHelper.h
//  Tracker
//
//  Created by apple on 13-12-30.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@protocol CCGeoHelperDelegate <NSObject>

-(void) onGetAddress:(NSString*)address;

@end

@interface CCGeoQueryPrams : NSObject
@property (nonatomic, strong) id<CCGeoHelperDelegate> delegate;
@property (nonatomic, assign) CLLocationCoordinate2D coord;
@end

@interface ZWL_GeoHelper : NSObject //<BMKSearchDelegate>

//@property (nonatomic, strong) BMKSearch* search;
//@property (nonatomic, strong) NSMutableDictionary* geoCache;
//@property (nonatomic, strong) NSMutableArray* queryList;
//
//+ (ZWL_GeoHelper *)sharedClient;
//
//-(NSString*) getAddress:(CLLocationCoordinate2D)coord delegate:(id)delegate;
//
//-(void) cleanQueryList;
//- (void)clean;


@end
