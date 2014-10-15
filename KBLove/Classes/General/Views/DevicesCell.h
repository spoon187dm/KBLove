//
//  DevicesCell.h
//  KBLove
//
//  Created by block on 14-10-15.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "DAContextMenuCell.h"

@interface DevicesCell : UITableViewCell

@property (strong, nonatomic) UIView *actualContentView;


@property (readonly, assign, nonatomic, getter = isContextMenuHidden) BOOL contextMenuHidden;
@property (strong, nonatomic) NSString *deleteButtonTitle;
@property (assign, nonatomic) BOOL editable;
@property (assign, nonatomic) CGFloat menuOptionButtonTitlePadding;
@property (assign, nonatomic) CGFloat menuOptionsAnimationDuration;
@property (assign, nonatomic) CGFloat bounceValue;
@property (strong, nonatomic) NSString *moreOptionsButtonTitle;

@property (weak, nonatomic) id<DAContextMenuCellDelegate> delegate;

- (CGFloat)contextMenuWidth;
- (void)setMenuOptionsViewHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler;
- (void)setUp;

@property (strong, nonatomic) UIImageView *deviceImageView;
@property (strong, nonatomic) UILabel *deviceNameLabel;
@property (strong, nonatomic) UILabel *deviceSnLabel;
@property (strong, nonatomic) UILabel *deviceLocationLabel;
@property (strong, nonatomic) UIImageView *deveiceStatusImageView;
@property (strong, nonatomic) UILabel *timeLabel;

@end
