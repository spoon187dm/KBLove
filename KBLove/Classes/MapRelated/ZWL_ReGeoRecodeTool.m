//
//  ZWL_ReGeoRecodeTool.m
//  KBLove
//
//  Created by qianfeng on 14-11-3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "ZWL_ReGeoRecodeTool.h"

@implementation ZWL_ReGeoRecodeTool
{


}
//反地理编码 方法存在一定问题   在代码中一次请求不能超过两次  否则会导致信息接收错乱

static ZWL_ReGeoRecodeTool *tool;

+(void)GaoDeMapViewReGeocodeWithCoordinate:(CLLocationCoordinate2D)location viewController:(UIViewController *)controller response:(GeocodeResult)responseBlock
{
    if (tool==nil) {
        tool=[[ZWL_ReGeoRecodeTool alloc]init];
        tool.search = [[AMapSearchAPI alloc] initWithSearchKey: GAODEMAOVIEWKEY Delegate:tool];
    }
  
    tool.responseBlock=responseBlock;
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
//    self.GeoRecodeRequest=regeo;
    regeo.location = [AMapGeoPoint locationWithLatitude:location.latitude longitude:location.longitude];
    regeo.requireExtension = YES;
    [tool.search AMapReGoecodeSearch:regeo];
}

#pragma mark - AMapSearchDelegate

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        NSMutableArray *resultStrs=[[NSMutableArray alloc]init];
        for (int i=0; i<response.regeocode.pois.count; i++) {
           
            AMapPOI *p=response.regeocode.pois[i];
            [resultStrs addObject:p.name];
        }
        self.responseBlock(resultStrs);
        tool=nil;
    }
}


- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}




@end
