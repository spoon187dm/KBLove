//
//  AddFriendButton.m
//  KBLove
//
//  Created by 吴铭博 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "AddFriendButton.h"

@implementation AddFriendButton
//重写button 的 title布局
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect _contentRect = CGRectMake(50, self.bounds.size.height / 2 - contentRect.size.height / 2 , contentRect.size.width, contentRect.size.height);
    return _contentRect;
}
//重写button 的 image布局
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect _contentRect = CGRectMake(10, self.bounds.size.height / 2 - 15 , 30, 30);
    return _contentRect;
}

@end
