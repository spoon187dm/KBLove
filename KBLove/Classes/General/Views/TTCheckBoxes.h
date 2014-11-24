//
//  TTCheckBoxes.h
//  接口测试
//
//  Created by yuri on 14-11-19.
//  Copyright (c) 2014年 yuri. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTCheckBoxes;

@protocol  TTCheckBoxesDelegate <NSObject>
@optional
- (void)checkBoxes:(TTCheckBoxes *)boxes didClickButton:(int)index buttonTitle:(NSString *)title;

@end

@interface TTCheckBoxes : UIView

/** 普通状态的图片*/
@property (nonatomic, copy) NSString *normalImage;

/** 选中状态的图片*/
@property (nonatomic, copy) NSString *selectedImage;

/** 需要显示的标题数组*/
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, weak) id<TTCheckBoxesDelegate> delegate;


/** 当前选中按钮的索引*/
@property (nonatomic, assign, readonly) int selectedIndex;

/** 当前选中按钮的标题*/
@property (nonatomic, copy, readonly) NSString *selectedTitle;

/** 初始化控件*/
- (instancetype)initWithTitle:(NSArray *)titleArray normal:(NSString *)normalImage selected:(NSString *)selectedImage;
/** 初始化控件*/
+ (instancetype)checkBoxesWithTitle:(NSArray *)titleArray normal:(NSString *)normalImage selected:(NSString *)selectedImage;
@end
