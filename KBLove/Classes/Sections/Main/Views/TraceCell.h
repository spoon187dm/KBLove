//
//  TraceCell.h
//  KBLove
//
//  Created by Ming on 14-11-21.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBTracePart;
#import "BMKMapView.h"

@interface TraceCell : UITableViewCell <BMKMapViewDelegate>

{
    void (^selectBlock)(int);
}

@property (nonatomic ,strong) UIImageView *bottomImageview;

- (void)setUpViewWithModel:(KBTracePart *)part selectedBlock:(void (^)(int))block;


@end
