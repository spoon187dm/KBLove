//
//  TraceCell.h
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TableMenuCell.h"
@class KBTracePart;
@interface TraceCell : TableMenuCell

@property (nonatomic ,strong) UIImageView *bottomImageview;

- (void)setUpViewWithModel:(KBTracePart *)part;

@end
