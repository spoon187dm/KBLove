//
//  TraceCell.h
//  KBLove
//
//  Created by Ming on 14-11-21.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBTracePart;

@interface TraceCell : UITableViewCell

{
    void (^selectBlock)(BOOL);
}

@property (nonatomic ,strong) UIImageView *bottomImageview;

- (void)setUpViewWithModel:(KBTracePart *)part selectedBlock:(void (^)(BOOL))block;


@end
