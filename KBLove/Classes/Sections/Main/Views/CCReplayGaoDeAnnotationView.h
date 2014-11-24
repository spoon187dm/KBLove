//
//  CCReplayGaoDeAnnotationView.h
//  baiDuTest
//
//  Created by qianfeng on 14-10-20.
//  Copyright (c) 2014年 zhangwenlong. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CCReplayGaoDeAnnotationView : MAAnnotationView

@property (nonatomic, copy) NSString* content;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, strong) UIImage* icon;
-(void)hideTitle;
@end
