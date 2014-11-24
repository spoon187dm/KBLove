//
//  BoundCarInfoController.h
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoundCarInfoController : UIViewController

@property (nonatomic,strong)NSMutableDictionary *bounderInfoDic;

/** 车辆头像*/
@property (weak, nonatomic) IBOutlet UIButton *CarHeadImage;

/** 车辆名称*/
@property (weak, nonatomic) IBOutlet UITextField *CarName;
/** 车牌号*/
@property (weak, nonatomic) IBOutlet UITextField *CarNum;
//车辆品牌


- (IBAction)rightNavBarButtonClick:(id)sender;
- (IBAction)backNavBarButtonClick:(id)sender;

@end
