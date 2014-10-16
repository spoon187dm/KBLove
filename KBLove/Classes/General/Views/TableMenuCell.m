//
//  TableMenuCell.m
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-2.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "TableMenuCell.h"

@interface TableMenuCell () {
    CGRect _frame;
}
//@property (assign, nonatomic, getter = isMenuViewHidden) BOOL menuViewHidden;
@end

#define ISIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

@implementation TableMenuCell
@synthesize cellView;
@synthesize startX;
@synthesize cellX;
@synthesize menuActionDelegate;
@synthesize indexpathNum;
@synthesize menuCount;
@synthesize menuView;
@synthesize menuViewHidden;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        menuCount = 0;
        
        self.cellView = [[UIView alloc] init];
        self.cellView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.cellView];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cellPanGes:)];
        panGes.delegate = self;
        panGes.delaysTouchesBegan = YES;
        panGes.cancelsTouchesInView = NO;
        [self addGestureRecognizer:panGes];
    }
    return self;
}

- (UIView *)ViewForCellContent{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = self.bounds;
//    [self.contentView addSubview:view];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = [NSString stringWithFormat:@"||^^<>^^我就是我,颜色不一样的火焰>>%ld",indexpathNum.row];
    lab.font = [UIFont systemFontOfSize:16];
    lab.backgroundColor = [UIColor whiteColor];
    lab.textColor = [UIColor blackColor];
    [view addSubview:lab];
    return view;
}

- (UIView *)menuViewForMenuCount:(NSInteger)count{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(320 - 80*count, 0, 80*count, self.frame.size.height);
    view.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < count; i++) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
        bgView.frame = CGRectMake(80*i, 0, 80, _frame.size.height);
        [view addSubview:bgView];
        
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        menuBtn.frame = CGRectMake(0, 0, 80, _frame.size.height);
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:i] objectForKey:@"stateNormal"]]] forState:UIControlStateNormal];
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[_menuData objectAtIndex:i] objectForKey:@"stateHighLight"]]] forState:UIControlStateHighlighted];
        [menuBtn setTitle:@"test" forState:UIControlStateNormal];
        [menuBtn setBackgroundColor:[UIColor blackColor]];
        [bgView addSubview:menuBtn];
    }
    
    return view;
}

-(void)configWithData:(NSIndexPath *)indexPath menuData:(NSArray *)menuData cellFrame:(CGRect)cellFrame{
    indexpathNum = indexPath;
    _frame = cellFrame;
    _menuData = menuData;
    menuCount = [menuData count];
    if (self.cellView) {
        [self.cellView removeFromSuperview];
        self.cellView = nil;
    }
    self.cellView = [self ViewForCellContent];
    [self.contentView addSubview:cellView];
    menuView = [self menuViewForMenuCount:menuData.count];
    [self.contentView insertSubview:menuView belowSubview:self.cellView];
    self.menuViewHidden = YES;

    
}
-(void)menuBtnClick:(id)sender{
    UIButton *btn = sender;
    if (btn.tag == 2) {
        self.menuViewHidden = YES;
        [menuActionDelegate deleteCell:self];
    }
    [self.menuActionDelegate menuChooseIndex:indexpathNum.row menuIndexNum:btn.tag];
    
//    UITableViewCell *cell;
//    if (ISIOS7) {
//        cell = (UITableViewCell *)btn.superview.superview;
//    }else{
//        cell = (UITableViewCell *)btn.superview;
//    }
}

-(void)cellPanGes:(UIPanGestureRecognizer *)panGes{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGPoint pointer = [panGes locationInView:self.contentView];
    if (panGes.state == UIGestureRecognizerStateBegan) {
        self.menuViewHidden = NO;
        startX = pointer.x;
        cellX = self.cellView.frame.origin.x;
    }else if (panGes.state == UIGestureRecognizerStateChanged){
        self.menuViewHidden = NO;
        [menuActionDelegate tableMenuWillShowInCell:self];
    }else if (panGes.state == UIGestureRecognizerStateEnded){
        [self cellReset:pointer.x - startX];
        return;
    }else if (panGes.state == UIGestureRecognizerStateCancelled){
        [self cellReset:pointer.x - startX];
        return;
    }
    [self cellViewMoveToX:cellX + pointer.x - startX];
}

-(void)cellReset:(float)moveX{
    if (cellX <= -80*menuCount) {
        if (moveX <= 0) {
            return;
        }else if(moveX > 20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                self.menuViewHidden = YES;
                [self.menuActionDelegate tableMenuDidHideInCell:self];
            }];
        }else if (moveX <= 20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:-menuCount*80];
            } completion:^(BOOL finished) {
                self.menuViewHidden = NO;
                [self.menuActionDelegate tableMenuDidShowInCell:self];
            }];
        }
    }else{
        if (moveX >= 0) {
            return;
        }else if(moveX < -20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:-menuCount*80];
            } completion:^(BOOL finished) {
                self.menuViewHidden = NO;
                [self.menuActionDelegate tableMenuDidShowInCell:self];
            }];
        }else if (moveX >= -20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                self.menuViewHidden = YES;
                [self.menuActionDelegate tableMenuDidShowInCell:self];
            }];
        }
    }
}
-(void)cellViewMoveToX:(float)x{
    if (x <= -(menuCount*80+20)) {
        x = -(menuCount*80+20);
    }else if (x >= 50){
        x = 50;
    }
    self.cellView.frame = CGRectMake(x, 0, _frame.size.width, _frame.size.height);
    if (x == -(menuCount*80+20)) {
        [UIView animateWithDuration:0.2 animations:^{
            [self initCellFrame:-menuCount*80];
        } completion:^(BOOL finished) {
            self.menuViewHidden = NO;
            [self.menuActionDelegate tableMenuDidShowInCell:self];
        }];
    }
    if (x == 50) {
        [UIView animateWithDuration:0.2 animations:^{
            [self initCellFrame:0];
        } completion:^(BOOL finished) {
            self.menuViewHidden = YES;
            [self.menuActionDelegate tableMenuDidHideInCell:self];
        }];
    }
}
- (void)initCellFrame:(float)x{
    CGRect frame = self.cellView.frame;
    frame.origin.x = x;
    
    self.cellView.frame = frame;
}
#pragma mark * UIPanGestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    NSString *str = [NSString stringWithUTF8String:object_getClassName(gestureRecognizer)];
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return (fabs(translation.x) > fabs(translation.y))&&(translation.x<0);
    }
    return YES;
}

- (void)setMenuHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    if (hidden) {
        CGRect frame = self.cellView.frame;
        if (frame.origin.x != 0) {
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                self.menuViewHidden = YES;
                [self.menuActionDelegate tableMenuDidHideInCell:self];
                if (completionHandler) {
                    completionHandler();
                }
            }];
        }
    }
}
- (void)setMenuViewHidden:(BOOL)Hidden{
    menuViewHidden = Hidden;
    
    if (Hidden) {
        self.menuView.hidden = YES;
    }else{
        self.menuView.hidden = NO;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (self.menuViewHidden) {
        self.menuView.hidden = YES;
        [super setHighlighted:highlighted animated:animated];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.menuViewHidden) {
        self.menuView.hidden = YES;
        [super setSelected:selected animated:animated];
    }
}

@end
