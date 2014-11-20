//
//  TTAlertView.m
//  接口测试
//
//  Created by yuri on 14-11-20.
//  Copyright (c) 2014年 yuri. All rights reserved.
//

#import "TTAlertView.h"

static CGFloat TTAlertViewHeight = 100;
#define TTButtonViewHeight 40

typedef void(^ButtonClickOption)(TTAlertView *alertView);

@interface TTAlertView ()

/** 遮盖图层*/
@property (nonatomic, weak) UIView *cover;
/** 弹窗视图*/
@property (nonatomic, weak) UIView *alertView;
/** 标题label*/
@property (nonatomic, weak) UILabel *titleLabel;
/** 文字label*/
@property (nonatomic, weak) UILabel *messageLabel;
/** 按钮组视图*/
@property (nonatomic, weak) UIView *buttonView;

@property (nonatomic, strong) NSMutableArray *options;

@end

@implementation TTAlertView

- (NSMutableArray *)options
{
    if (_options == nil) {
        _options = [NSMutableArray array];
    }
    return _options;
}

+ (instancetype)alertViewWithHeight:(CGFloat)height
{
    TTAlertViewHeight = height;
    TTAlertView *alert = [[self alloc] init];
    
    return alert;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        // 设置遮盖层
        UIView *cover = [[UIView alloc] init];
        cover.frame = [UIScreen mainScreen].bounds;
        cover.backgroundColor = [UIColor blackColor];
        cover.userInteractionEnabled = NO;
        cover.alpha = 0.4;
        [self addSubview:cover];
        self.cover = cover;
        
        // 设置警告视图
        NSLog(@"%@", NSStringFromCGRect(self.frame));
        UIView *alertView = [[UIView alloc] init];
        CGFloat alertW = cover.frame.size.width * 0.8;
        alertView.bounds = CGRectMake(0, 0, alertW, TTAlertViewHeight);
        alertView.center = CGPointMake(self.center.x, self.center.y - 50);
        [self addSubview:alertView];
        self.alertView = alertView;
        
        // 添加标题label
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.alertView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // 添加消息label
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.font = [UIFont systemFontOfSize:14];
        messageLabel.numberOfLines = 0;
        CGFloat messageW = alertView.bounds.size.width * 0.85;
        CGFloat messageX = (alertView.bounds.size.width - messageW) / 2;
        CGFloat messageY = 10;
        CGFloat messageH = alertView.bounds.size.height - TTButtonViewHeight - 20;
        messageLabel.frame = CGRectMake(messageX, messageY, messageW, messageH);
        [self.alertView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        
        // 添加消息下的分隔线
        UIView *divide = [[UIView alloc] init];
        divide.backgroundColor = [UIColor whiteColor];
        CGFloat divideW = alertView.bounds.size.width;
        CGFloat divideY = CGRectGetMaxY(messageLabel.frame) + 10;
        divide.frame = CGRectMake(0, divideY, divideW, 1);
        [self.alertView addSubview:divide];
        
        // 设置按钮组视图
        UIView *buttonView = [[UIView alloc] init];
        buttonView.frame = CGRectMake(0, alertView.bounds.size.height - TTButtonViewHeight, alertView.bounds.size.width, TTButtonViewHeight);
        [self.alertView addSubview:buttonView];
        self.buttonView = buttonView;
    }
    return self;
}




- (void)addButtonWithTitle:(NSString *)title option:(void (^)(TTAlertView *))option
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [self.options addObject:option];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:btn];
}

- (void)btnClick:(UIButton *)sender
{
    ButtonClickOption option = self.options[sender.tag];
    if (option) {
        option(self);
    }
}

- (void)didMoveToSuperview
{
    int count = (int)self.buttonView.subviews.count;
    CGFloat btnW = self.alertView.bounds.size.width / count;
    
    for (int i = 0; i < count; i++) {
        CGFloat btnX = btnW * i;
        UIButton *btn = self.buttonView.subviews[i];
        btn.tag = i;
        btn.frame = CGRectMake(btnX, 0, btnW, TTButtonViewHeight);
        
        
        if (i) {    //当不为第一个按钮时
            UIView *divide = [[UIView alloc] init];
            divide.backgroundColor = [UIColor whiteColor];
            divide.frame = CGRectMake(btnX, 0, 1, TTButtonViewHeight);
            [self.buttonView addSubview:divide];
        }
    }
}

#pragma mark - 设置alert的属性
- (void)setAlertBackgroundColor:(UIColor *)alertBackgroundColor
{
    _alertBackgroundColor = alertBackgroundColor;
    self.alertView.backgroundColor = alertBackgroundColor;
}

- (void)setMessageColor:(UIColor *)messageColor
{
    _messageColor = messageColor;
    self.messageLabel.textColor = messageColor;
}

- (void)setMessageBackgroundColor:(UIColor *)messageBackgroundColor
{
    _messageBackgroundColor = messageBackgroundColor;
    self.messageLabel.backgroundColor = messageBackgroundColor;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLabel.text = message;
}

#pragma mark - alertView 操作
- (void)showWithSupview:(UIView *)supview
{
    [supview addSubview:self];
}

- (void)closeAlertView
{
    [self removeFromSuperview];
}

@end
