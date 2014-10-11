//
//  BoundCarInfoController.m
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import "BoundCarInfoController.h"
#import "BoundEquipmentInfo.h"
#import "WLHttpRequestTool.h"
@interface BoundCarInfoController ()

@end

@implementation BoundCarInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rightNavBarButtonClick:(id)sender
{
    BoundEquipmentInfo *_equipment=[BoundEquipmentInfo sharedInstance];
    WLHttpRequestTool *httptool=[WLHttpRequestTool sharedInstance];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject: _equipment.EquipmentIMEINum forKey:@""];
    [dic setObject:@"7" forKey:@"cmd"];
    [dic setObject:@"1" forKey:@"operate"];
    //token  user_id
    [dic setObject:_equipment.EquipmentIMEINum forKey:@"device_sn"];
    [dic setObject:_equipment.EquipmentIponeNum forKey:@"phone"];
    [dic setObject:self.CarName.text forKey:@"name"];
    [dic setObject:@"" forKey:@"icon"];
    [dic setObject:self.CarNum.text forKey:@"car"];
    NSString *urlstr=@"http://118.194.192.104:8080/api/device.edit.do?";
    [httptool request:urlstr requestType:0 params:dic overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            NSLog(@"%@",result);
        }
    }];
}

- (void)backNavBarButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
