//
//  FenceSettingViewController.h
//  KBLove
//
//  Created by qianfeng on 14-11-4.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <MAMapKit/MAMapKit.h>

@interface FenceSettingViewController : UIViewController<BMKMapViewDelegate,MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet UISlider *fenceSlider;

- (IBAction)Click_inSendwarning:(id)sender;
- (IBAction)Click_outSendwarning:(id)sender;
- (IBAction)Click_down:(id)sender;
- (IBAction)Click_up:(id)sender;
- (IBAction)Click_setup:(id)sender;


- (IBAction)Click_selectRectType:(id)sender;

- (IBAction)Click_selectCircleType:(id)sender;



@end
