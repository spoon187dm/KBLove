//
//  MainViewController.h
//  KBLove
//
//  Created by block on 14-10-13.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <MAMapKit/MAMapKit.h>

@interface MainViewController : UIViewController<BMKMapViewDelegate,MAMapViewDelegate>
//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (weak, nonatomic) IBOutlet BMKMapView *baidu_MapView;
- (IBAction)click_fresh:(UIButton *)sender;
- (IBAction)click_Location:(UIButton *)sender;
- (IBAction)click_zoomin:(UIButton *)sender;
- (IBAction)click_zoomout:(UIButton *)sender;

@end
