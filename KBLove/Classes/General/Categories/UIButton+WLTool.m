//
//  UIButton+WLTool.m
//  PoorTravel
//
//  Created by block on 14-10-8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "UIButton+WLTool.h"
#import <objc/objc-runtime.h>

static char * const kWL_Block_ButtonLCickKey = "kWL_Block_ButtonLCickKey";

@implementation UIButton (CreateTool)

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title{
    return [self buttonWithFrame:frame title:title target:nil Action:nil];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target Action:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title clickBlock:(void (^)(UIButton *))block{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:btn action:@selector(wl_block_event_touchupinside:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(btn, kWL_Block_ButtonLCickKey, block, OBJC_ASSOCIATION_COPY);
    return btn;
}

- (void)setClickBlock:(void (^)(UIButton *))block{
    void(^wl_clickbLock)(UIButton *) = objc_getAssociatedObject(self, kWL_Block_ButtonLCickKey);
    if (!wl_clickbLock) {
        objc_setAssociatedObject(self, kWL_Block_ButtonLCickKey, [block copy], OBJC_ASSOCIATION_COPY);
    }else{
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, kWL_Block_ButtonLCickKey, [block copy], OBJC_ASSOCIATION_COPY);
    }
    
    [self removeTarget:self action:@selector(wl_block_event_touchupinside:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTarget:self action:@selector(wl_block_event_touchupinside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)wl_block_event_touchupinside:(UIButton *)btn{
    void(^wl_clickblock)(UIButton *) = objc_getAssociatedObject(btn, kWL_Block_ButtonLCickKey);
    wl_clickblock(btn);
}
@end
