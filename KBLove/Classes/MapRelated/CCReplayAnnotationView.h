//
//  CCReplayAnnotationView.h
//  Tracker
//
//  Created by apple on 13-12-20.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import "BMKPinAnnotationView.h"

@interface CCReplayAnnotationView : BMKAnnotationView

@property (nonatomic, copy) NSString* content;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, strong) UIImage* icon;
-(void)hideTitle;
@end
