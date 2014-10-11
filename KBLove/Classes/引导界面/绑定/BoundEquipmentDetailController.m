//
//  BoundEquipmentDetailController.m
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import "BoundEquipmentDetailController.h"
#import "BoundCarInfoController.h"
#import "BoundEquipmentInfo.h"
#import "BoundPersonInfoController.h"
#import "BoundPetInfoController.h"
@interface BoundEquipmentDetailController ()

@end

@implementation BoundEquipmentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    self.EquipmentIMEINum.text=self.EquipmentIMEINumString;
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)rightNavBarButtonClick:(id)sender
{
    BoundEquipmentInfo *_equipment=[BoundEquipmentInfo sharedInstance];
    _equipment.EquipmentSIMNum=self.EquipmentSIMNum.text;
    _equipment.EquipmentIponeNum=self.LinkmanPhoneNum.text;
    
    NSString *imeiNum_sub2=[_equipment.EquipmentIMEINum substringToIndex:2];
    NSInteger num=[imeiNum_sub2 integerValue];
    if ((num>=1&&num<=20)||(num>=51&&num<=54))
    {//车辆
        BoundCarInfoController *boundcar=[[BoundCarInfoController alloc]init];
        [self.navigationController pushViewController:boundcar animated:YES];
    }else if ((num>=21&&num<=35)||(num>=55&&num<=57))
    {//个人
        BoundPersonInfoController *boundperson=[[BoundPersonInfoController alloc]init];
        [self.navigationController pushViewController:boundperson animated:YES];
    }else if ((num>=36&&num<=50)||(num>=58&&num<=60))
    {//宠物
        BoundPetInfoController *boundPet=[[BoundPetInfoController alloc]init];
        [self.navigationController pushViewController:boundPet animated:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
