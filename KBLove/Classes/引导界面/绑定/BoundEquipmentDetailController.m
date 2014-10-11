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

- (IBAction)backNavBarButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightNavBarButtonClick:(id)sender
{
    BoundCarInfoController *boundcar= [self.storyboard instantiateViewControllerWithIdentifier:@"BoundCarInfoController"];
    NSMutableDictionary *bounderInfo=[[NSMutableDictionary alloc]init];
    [bounderInfo setObject:self.EquipmentIMEINumString forKey:@"IMEIstring"];
    [bounderInfo setObject:self.EquipmentSIMNum.text forKey:@"SIMNum"];
    [bounderInfo setObject:self.LinkmanPhoneNum.text forKey:@"PhoneNum"];
    boundcar.bounderInfoDic=bounderInfo;
    [self.navigationController pushViewController:boundcar animated:YES];
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
