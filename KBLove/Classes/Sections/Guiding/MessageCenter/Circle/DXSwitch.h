//
//  DXSwitch.h
//  KBLove
//
//  Created by 1124 on 14/10/23.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXSwitch;
@protocol DXSwitchDelegate <NSObject>

- (void)SwitchValueChange:(DXSwitch *)dx_switch;

@end
@interface DXSwitch : UIScrollView
{
    //UISwitch
    UIView *_slipView;
    //BOOL *ON;
    UILabel *_onLable;
    UILabel *_offLable;
    // BOOL *isAnimation;
}

//滑动小圆圈选中状态下颜色
@property (nonatomic,strong)UIColor *slipColor;
//滑动小圆圈w未选中状态下颜色
@property (nonatomic,strong) UIColor *offSlipColor;
//选中滑动轨道颜色
@property (nonatomic,strong)UIColor *onTintColor;
//未选中轨道颜色
@property (nonatomic,strong)UIColor *offTintColor;
//是否选中
@property (nonatomic,assign)BOOL ON;
//选中提示文字
@property (nonatomic,strong)NSString *onText;
//未选中提示文字
@property (nonatomic,strong)NSString *offText;
//代理函数
@property (nonatomic,weak)id<DXSwitchDelegate> swdelegate;
//初始化类函数
+ (DXSwitch *)SwitchWithSlipColor:(UIColor *)slipColor OffSlipColor:(UIColor *)offSlipcolor OnTintColor:(UIColor *)ontintcolor  OffTintColor:(UIColor *)offtintcolor OnText:(NSString *)text OffText:(NSString *)offtext AndFrame:(CGRect )frame;
//设置属性时调用方法
- (void)setON:(BOOL)ON;
- (void)setON:(BOOL)ON animation:(BOOL)anamation;
- (void)setSlipColor:(UIColor *)slipColor;
- (void)setOffSlipColor:(UIColor *)offSlipColor;
- (void)setOffTintColor:(UIColor *)offTintColor;
- (void)setOnTintColor:(UIColor *)onTintColor;
- (void)setOnText:(NSString *)onText;
- (void)setOffText:(NSString *)offText;
@end
