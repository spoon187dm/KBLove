//
//  CKCalendarCalendarCell.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKCalendarCell.h"




@interface CKCalendarCell (){
    CGSize _size;
}

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *dot;

@end

@implementation CKCalendarCell

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        _state = CKCalendarMonthCellStateNormal;
        
        //  Normal Cell Colors
        _normalBackgroundColor = [UIColor clearColor];
        _selectedBackgroundColor = [UIColor darkGrayColor];
        _inactiveSelectedBackgroundColor = [UIColor darkGrayColor];
        
        //  Today Cell Colors
        _todayBackgroundColor = [UIColor grayColor];
        _todaySelectedBackgroundColor = [UIColor darkGrayColor];
        _todayTextShadowColor = [UIColor darkGrayColor];
        _todayTextColor = [UIColor whiteColor];
        
        //  Text Colors
      
        _textSelectedColor = [UIColor whiteColor];
        _textSelectedShadowColor = [UIColor darkGrayColor];
        
       
        
    
        _label = [UILabel new];
        
    }
    return self;
}

- (id)initWithSize:(CGSize)size
{
    self = [self init];
    if (self) {
        _size = size;
    }
    return self;
}

#pragma mark - View Hierarchy

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    CGPoint origin = [self frame].origin;
    [self setFrame:CGRectMake(origin.x, origin.y, _size.width, _size.height)];
    [self layoutSubviews];
 
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [self configureLabel];
  
    
    [self addSubview:[self label]];
  
}

#pragma mark - Setters

- (void)setState:(CKCalendarMonthCellState)state
{
    if (state > CKCalendarMonthCellStateOutOfRange || state < CKCalendarMonthCellStateTodaySelected) {
        return;
    }
    
    _state = state;
    
    [self applyColorsForState:_state];
}

- (void)setNumber:(NSNumber *)number
{
    _number = number;
    
    //  TODO: Locale support?
    NSString *stringVal = [number stringValue];
    [[self label] setText:stringVal];
}


#pragma mark - Recycling Behavior

-(void)prepareForReuse
{
    //  Alpha, by default, is 1.0
    [[self label]setAlpha:1.0];
    
    [self setState:CKCalendarMonthCellStateNormal];
    
  
}

#pragma mark - Label 

- (void)configureLabel
{
    UILabel *label = [self label];
    
    [label setFont:[UIFont boldSystemFontOfSize:13]];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor whiteColor];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
}



#pragma mark - UI Coloring

- (void)applyColors
{    
    [self applyColorsForState:[self state]];
   
}

//  TODO: Make the cell states bitwise, so we can use masks and clean this up a bit
- (void)applyColorsForState:(CKCalendarMonthCellState)state
{
    //  Default colors and shadows
    
    [[self label] setShadowOffset:CGSizeMake(0, 0.5)];
    
    //[self setBorderColor:[self cellBorderColor]];
   // [self setBorderWidth:0.5];
    [self setBackgroundColor:[self normalBackgroundColor]];
    
    //  Today cell
    if(state == CKCalendarMonthCellStateTodaySelected)
    {
        [self setBackgroundColor:[self todaySelectedBackgroundColor]];
        [[self label] setShadowColor:[self todayTextShadowColor]];
        [[self label] setTextColor:[self todayTextColor]];
        
    }
    
    //  Today cell, selected
    else if(state == CKCalendarMonthCellStateTodayDeselected)
    {
        [self setBackgroundColor:[self todayBackgroundColor]];
        [[self label] setShadowColor:[self todayTextShadowColor]];
        [[self label] setTextColor:[self todayTextColor]];
        
    }
    
    //  Selected cells in the active month have a special background color
    else if(state == CKCalendarMonthCellStateSelected)
    {
        [self setBackgroundColor:[self selectedBackgroundColor]];
       
        [[self label] setTextColor:[self textSelectedColor]];
        [[self label] setShadowColor:[self textSelectedShadowColor]];
        [[self label] setShadowOffset:CGSizeMake(0, -0.5)];
    }
    
    if (state == CKCalendarMonthCellStateInactive) {
        [[self label] setAlpha:0.5];    //  Label alpha needs to be lowered
        [[self label] setShadowOffset:CGSizeZero];
    }
    else if (state == CKCalendarMonthCellStateInactiveSelected)
    {
        [[self label] setAlpha:0.5];    //  Label alpha needs to be lowered
        [[self label] setShadowOffset:CGSizeZero];
        [self setBackgroundColor:[self inactiveSelectedBackgroundColor]];
    }
    else if(state == CKCalendarMonthCellStateOutOfRange)
    {
        [[self label] setAlpha:0.01];    //  Label alpha needs to be lowered
        [[self label] setShadowOffset:CGSizeZero];
    }
    
    //  Make the dot follow the label's style
    [[self dot] setBackgroundColor:[[self label] textColor]];
    [[self dot] setAlpha:[[self label] alpha]];
}

#pragma mark - Selection State

- (void)setSelected
{
    
    CKCalendarMonthCellState state = [self state];
    
    if (state == CKCalendarMonthCellStateInactive) {
        [self setState:CKCalendarMonthCellStateInactiveSelected];
    }
    else if(state == CKCalendarMonthCellStateNormal)
    {
        [self setState:CKCalendarMonthCellStateSelected];
    }
    else if(state == CKCalendarMonthCellStateTodayDeselected)
    {
        [self setState:CKCalendarMonthCellStateTodaySelected];
    }
}

- (void)setDeselected
{
    CKCalendarMonthCellState state = [self state];
    
    if (state == CKCalendarMonthCellStateInactiveSelected) {
        [self setState:CKCalendarMonthCellStateInactive];
    }
    else if(state == CKCalendarMonthCellStateSelected)
    {
        [self setState:CKCalendarMonthCellStateNormal];
    }
    else if(state == CKCalendarMonthCellStateTodaySelected)
    {
        [self setState:CKCalendarMonthCellStateTodayDeselected];
    }
}

- (void)setOutOfRange
{
    [self setState:CKCalendarMonthCellStateOutOfRange];
}

@end
