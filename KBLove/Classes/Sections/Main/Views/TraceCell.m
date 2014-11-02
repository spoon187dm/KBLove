//
//  TraceCell.m
//  KBLove
//
//  Created by block on 14/11/2.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "TraceCell.h"
#import <UIImageView+AFNetworking.h>
#import "TraceInfoView.h"
@implementation TraceCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}

- (UIView *)ViewForCellContent{
    
    TraceInfoView *infoView = [[[NSBundle mainBundle]loadNibNamed:@"TraceInfoView" owner:self options:nil] lastObject];
    infoView.frame = self.bounds;
    return infoView;
}

- (UIView *)menuViewForMenuCount:(NSInteger)count{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(320 - 80*count, 0, 80*count, self.frame.size.height);
    view.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < count; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        menuBtn.frame = CGRectMake(80*i, 0, 80, 100);
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:i] objectForKey:@"stateNormal"]]] forState:UIControlStateNormal];
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:i] objectForKey:@"stateHighLight"]]] forState:UIControlStateHighlighted];
        [view addSubview:menuBtn];
    }
    
    return view;
}

@end
