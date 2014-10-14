//
//  BoundPersonInfoController.m
//  KBLove
//
//  Created by qianfeng on 38-1-1.
//  Copyright (c) 2038年 block. All rights reserved.
//

#import "BoundPersonInfoController.h"
#import "BoundEquipmentInfo.h"
#import "KBHttpRequestTool.h"
@interface BoundPersonInfoController ()

@end

@implementation BoundPersonInfoController

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
    //头像
//    [dic setObject:@"" forKey:@"icon"];//尚未添加
    [dic setObject:self.PersonName.text forKey:@"name"];
    [dic setObject:self.PersonBirthday.text forKey:@"birth"];
    [dic setObject:self.PersonSex.text forKey:@"gender"];
    [dic setObject:self.PersonHeight.text forKey:@"height"];
    [dic setObject:self.PersonWeight.text forKey:@"weight"];
    NSString *urlstr=@"http://118.194.192.104:8080/api/device.edit.do?";
    NSLog(@"%@",dic);
    [httptool request:urlstr requestType:0 params:dic overBlock:^(BOOL IsSuccess, id result) {
        if (IsSuccess) {
            NSLog(@"%@",result);
        }
    }];
/*
 http://118.194.192.104:8080/api/device.edit.do?birth=123&
 cmd=7&operate=1&token=BBBBA71C-C43B-4B37-8FDD-8C1813C1E97E&device_sn=409876632863748&user_id=11450&name=4234123&gender=1234&height=21&weight=12
 */
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
