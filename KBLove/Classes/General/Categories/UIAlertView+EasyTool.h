//
//  UIAlertView+EasyTool.h
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^alertClickblock)(NSInteger index);
@interface UIAlertView (EasyTool)<UIAlertViewDelegate>

/**
 @Author block
 
 便捷显示alertView，点击事件为block回调
 
 @param title   title
 @param message message
 @param cancle  canclebutton
 @param other   otherbutton
 @param block   block
 */
+ (void)showWithTitle:(NSString *)title Message:(NSString *)message cancle:(NSString *)cancle otherbutton:(NSString *)other block:(alertClickblock)block;

@end
