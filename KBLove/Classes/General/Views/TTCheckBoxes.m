//
//  TTCheckBoxes.m
//  接口测试
//
//  Created by yuri on 14-11-19.
//  Copyright (c) 2014年 yuri. All rights reserved.
//

#import "TTCheckBoxes.h"

@interface TTCheckBoxes ()

@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation TTCheckBoxes

- (instancetype)initWithTitle:(NSArray *)titleArray normal:(NSString *)normalImage selected:(NSString *)selectedImage
{
    if (self = [super init]) {
        self.titleArray = titleArray;
        self.normalImage = normalImage;
        self.selectedImage = selectedImage;
    }
    return self;
}

+ (instancetype)checkBoxesWithTitle:(NSArray *)titleArray normal:(NSString *)normalImage selected:(NSString *)selectedImage
{
    TTCheckBoxes *boxes = [[self alloc] initWithTitle:titleArray normal:normalImage selected:selectedImage];
    return boxes;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置内部button的属性
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        button.adjustsImageWhenHighlighted = NO;
        [button setImage:[UIImage imageNamed:self.normalImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.selectedImage] forState:UIControlStateSelected];
        
        // button绑定事件
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    
    // 初始化当前选中参数
    _selectedIndex = 0;
    _selectedTitle = titleArray.firstObject;
}

/** 按钮监听事件*/
- (void)btnClick:(UIButton *)sender
{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    
    // 代理通知
    if ([self.delegate respondsToSelector:@selector(checkBoxes:didClickButton:buttonTitle:)]) {
        [self.delegate checkBoxes:self didClickButton:(int)sender.tag buttonTitle:sender.currentTitle];
    }
    
    // 改变当前选中参数
    _selectedIndex = (int)sender.tag;
    _selectedTitle = sender.currentTitle;
}

- (void)setNormalImage:(NSString *)normalImage
{
    _normalImage = normalImage;
    
    for (UIButton *btn in self.subviews) {
        [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    }
}

- (void)setSelectedImage:(NSString *)selectedImage
{
    _selectedImage = selectedImage;
    
    for (UIButton *btn in self.subviews) {
        [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
}

- (void)layoutSubviews
{
    CGFloat btnW = self.bounds.size.width / self.subviews.count;
    CGFloat btnH = self.bounds.size.height;
    
    for (int i = 0; i < self.subviews.count; i++) {
        CGFloat btnX = btnW * i;
        
        // 取出button设置frame
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:btnH];
        btn.tag = i;
        
        if (i == 0) {
            [self btnClick:btn];
        }
    }
}

@end
