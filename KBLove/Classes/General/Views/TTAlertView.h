//
//  TTAlertView.h
//  接口测试
//
//  Created by yuri on 14-11-20.
//  Copyright (c) 2014年 yuri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTAlertView : UIView

/** alertView的背景色*/
@property (nonatomic, strong) UIColor *alertBackgroundColor;
/** 文字颜色*/
@property (nonatomic, strong) UIColor *messageColor;
/** 文字背景颜色*/
@property (nonatomic, strong) UIColor *messageBackgroundColor;
/** 正文文字*/
@property (nonatomic, copy) NSString *message;

/** 添加点击按钮*/
- (void)addButtonWithTitle:(NSString *)title option:(void(^)(TTAlertView *alertView))option;

/** 展示alertView*/
- (void)showWithSupview:(UIView *)supview;
/** 关闭alertView*/
- (void)closeAlertView;

+ (instancetype)alertViewWithHeight:(CGFloat)height;

@end
