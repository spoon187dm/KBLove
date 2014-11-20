//
//  CKCalendarHeaderView.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/14/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKCalendarHeaderView.h"





#import "CKCalendarViewModes.h"

#import "MBPolygonView.h"

@interface CKCalendarHeaderView ()
{
    NSUInteger _columnCount;
    CGFloat _columnTitleHeight;
}

@property (nonatomic, strong) UILabel *monthTitle;

@property (nonatomic, strong) NSMutableArray *columnTitles;
@property (nonatomic, strong) NSMutableArray *columnLabels;

@property (nonatomic, strong) UIButton *forwardButton1;
@property (nonatomic, strong) UIButton *backwardButton1;

@end

@implementation CKCalendarHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _monthTitle = [UILabel new];
        [_monthTitle setTextColor:[UIColor whiteColor]];
       
        [_monthTitle setShadowOffset:CGSizeMake(0, 1)];
        [_monthTitle setBackgroundColor:[UIColor clearColor]];
        [_monthTitle setTextAlignment:NSTextAlignmentCenter];
        [_monthTitle setFont:[UIFont systemFontOfSize:14]];
        
        _columnTitles = [NSMutableArray new];
        _columnLabels = [NSMutableArray new];
        
        _columnTitleHeight = 10;
        
       
        
//        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
//        [self addGestureRecognizer:_tapGesture];
    }
    return self;
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self layoutSubviews];
    [super willMoveToSuperview:newSuperview];
  
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)layoutSubviews
{
    
    /* Show & position the title Label */
    
    CGFloat upperRegionHeight = [self frame].size.height - _columnTitleHeight;
    CGFloat titleLabelHeight = 18;
    
    if ([[self dataSource] numberOfColumnsForHeader:self] == 0) {
        titleLabelHeight = [self frame].size.height;
        upperRegionHeight = titleLabelHeight;
    }
    
    CGFloat yOffset = upperRegionHeight/2 - titleLabelHeight/2;
    
    CGRect frame = CGRectMake(0, yOffset, [self frame].size.width, titleLabelHeight);
    [[self monthTitle] setFrame:frame];
    [self addSubview:[self monthTitle]];
    
    /* Update the month title. */
    
    NSString *title = [[self dataSource] titleForHeader:self];
    [[self monthTitle] setText:title];
    
    /* Highlight the title color as appropriate */

    if ([self shouldHighlightTitle])
    {
     //   [[self monthTitle] setTextColor:kCalendarColorHeaderTitleHighlightedBlue];
    }
    else
    {
        [[self monthTitle] setTextColor:[UIColor whiteColor]];
    }
    
    /* Show the forward and back buttons */

        CGRect backFrame = CGRectMake(yOffset, yOffset, 20, 20);
        CGRect forwardFrame = CGRectMake([self frame].size.width-titleLabelHeight-yOffset, yOffset, 20, 20);
    
    if ([self forwardButton1]) {
        [[self forwardButton1] removeFromSuperview];
        [self setForwardButton1:nil];
    }
    
    if ([self backwardButton1]) {
        [[self backwardButton1] removeFromSuperview];
        [self setBackwardButton1:nil];
    }

    _forwardButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _forwardButton1.frame = forwardFrame;
    [_forwardButton1 setImage:[UIImage imageNamed:@"数据071_22"] forState:UIControlStateNormal];
    _forwardButton1.tag = 100;
    [_forwardButton1 addTarget:self action:@selector(changeMonth:) forControlEvents:UIControlEventTouchUpInside];
    
    _backwardButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _backwardButton1.frame = backFrame;
    [_backwardButton1 setBackgroundImage:[UIImage imageNamed:@"数据071_25"] forState:UIControlStateNormal];
    _backwardButton1.tag = 200;
    [_backwardButton1 addTarget:self action:@selector(changeMonth:) forControlEvents:UIControlEventTouchUpInside];
    
    
   
    
    _forwardButton1.enabled = ![self shouldDisableForwardButton];
    _backwardButton1.enabled = ![self shouldDisableBackwardButton];
    [self addSubview:[self backwardButton1]];
    [self addSubview:[self forwardButton1]];
    
    /*  Check for a data source for the header to be installed */
    if (![self dataSource]) {
        @throw [NSException exceptionWithName:@"CKCalendarViewHeaderException" reason:@"Header can't be installed without a data source" userInfo:@{@"Header": self}];
    }
    
    /* Query the data source for the number of columns. */
    _columnCount = [[self dataSource] numberOfColumnsForHeader:self];
    
    
    /* Remove old labels */
    
    for (UILabel *label in [self columnLabels]) {
        [label removeFromSuperview];
    }
    
    [[self columnLabels] removeAllObjects];
    
    /* Query the datasource for the titles.*/
    [[self columnTitles] removeAllObjects];
    
    for (NSUInteger column = 0; column < _columnCount; column++) {
        NSString *title = [[self dataSource] header:self titleForColumnAtIndex:column];
        [[self columnTitles] addObject:title];
    }
    
    /* Convert title strings into labels and lay them out */
    
    if(_columnCount > 0){
        CGFloat labelWidth = [self frame].size.width/_columnCount;
        CGFloat labelHeight = _columnTitleHeight;
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, [self frame].size.height-labelHeight, 7*labelWidth, labelHeight)];
        view.backgroundColor = [UIColor clearColor];
        
        for (NSUInteger i = 0; i < [[self columnTitles] count]; i++) {
            NSString *title = [self columnTitles][i];
            
            UILabel *label = [self _columnLabelWithTitle:title];
            [[self columnLabels] addObject:label];
            
            CGRect frame = CGRectMake(i*labelWidth, 0, labelWidth, labelHeight);
            [label setFrame:frame];
            
            [view addSubview:label];
        }
        
        [self addSubview:view];
    }
}

#pragma mark - Convenience Methods

/* Creates and configures a label for a column title */

- (UILabel *)_columnLabelWithTitle:(NSString *)title
{
    UILabel *l = [UILabel new];
    [l setBackgroundColor:[UIColor clearColor]];
    [l setTextColor:[UIColor whiteColor]];
    //[l setShadowColor:kCalendarColorHeaderWeekdayShadow];
    [l setTextAlignment:NSTextAlignmentCenter];
    [l setFont:[UIFont boldSystemFontOfSize:10]];
    [l setShadowOffset:CGSizeMake(0, 1)];
    [l setText:title];
    
    return l;
}

#pragma mark - Touch Handling


-(void)changeMonth:(UIButton *)button
{
    if (button.tag == 100) {
        [self forwardButtonTapped];
    }else{
        [self backwardButtonTapped];
    }
}
#pragma mark - Button Handling

- (void)forwardButtonTapped
{
    if ([[self delegate] respondsToSelector:@selector(forwardTapped)]) {
        [[self delegate] forwardTapped];
    }
}

- (void)backwardButtonTapped
{
    if ([[self delegate] respondsToSelector:@selector(backwardTapped)]) {
        [[self delegate] backwardTapped];
    }
}

#pragma mark - Title Highlighting

- (BOOL)shouldHighlightTitle
{
    if ([[self delegate] respondsToSelector:@selector(headerShouldHighlightTitle:)]) {
        return [[self dataSource] headerShouldHighlightTitle:self];
    }
    return NO;  //  Default is no.
}

#pragma mark - Button Disabling

- (BOOL)shouldDisableForwardButton
{
    if ([[self dataSource] respondsToSelector:@selector(headerShouldDisableForwardButton:)]) {
        return [[self dataSource] headerShouldDisableForwardButton:self];
    }
    return NO;  //  Default is no.
}

- (BOOL)shouldDisableBackwardButton
{
    if ([[self dataSource] respondsToSelector:@selector(headerShouldDisableBackwardButton:)]) {
        return [[self dataSource] headerShouldDisableBackwardButton:self];
    }
    return NO;  //  Default is no.
}

@end
