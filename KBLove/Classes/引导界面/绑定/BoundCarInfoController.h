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

@property (weak, nonatomic) IBOutlet UIButton *CarHeadImage;

@property (weak, nonatomic) IBOutlet UITextField *CarName;
//车牌号
@property (weak, nonatomic) IBOutlet UITextField *CarNum;
//车辆品牌
@property (weak, nonatomic) IBOutlet UITextField *CarBrand;
//车辆类型
@property (weak, nonatomic) IBOutlet UITextField *CarType;

- (IBAction)rightNavBarButtonClick:(id)sender;


@end
