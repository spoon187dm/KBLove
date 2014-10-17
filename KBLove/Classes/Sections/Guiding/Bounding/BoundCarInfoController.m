//
//  BoundCarInfoController.m
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import "BoundCarInfoController.h"
#import "BoundEquipmentInfo.h"
#import "KBHttpRequestTool.h"
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
    KBHttpRequestTool *httptool=[KBHttpRequestTool sharedInstance];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"7" forKey:@"cmd"];
    [dic setObject:@"1" forKey:@"operate"];
    KBUserInfo *user=[KBUserInfo sharedInfo];
    [dic setObject:user.token forKey:@"token"];
    [dic setObject:user.user_id forKeyedSubscript:@"user_id"];
    [dic setObject:_equipment.EquipmentIMEINum forKey:@"device_sn"];
    [dic setObject:_equipment.EquipmentIponeNum forKey:@"phone"];
    [dic setObject:self.CarName.text forKey:@"name"];
//    [dic setObject:@"" forKey:@"icon"];//尚未添加头像
    [dic setObject:self.CarNum.text forKey:@"car"];
    NSString *urlstr=@"http://118.194.192.104:8080/api/device.edit.do?";
    NSLog(@"------%@",dic);
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
