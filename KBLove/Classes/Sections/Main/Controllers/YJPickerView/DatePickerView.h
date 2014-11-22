//
//  DatePickerView.h
//  哈哈
//
//  Created by Ming on 14-11-19.
//  Copyright (c) 2014年 MJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    YMD = 0,
    HM,
}PickerType;

@interface DatePickerView : UIView <UITableViewDataSource,UITableViewDelegate>

{
    void (^dateBlock)(NSArray *);
}

-(void)setType:(PickerType)type dateBlock:(void (^)(NSArray *))block;

@end
