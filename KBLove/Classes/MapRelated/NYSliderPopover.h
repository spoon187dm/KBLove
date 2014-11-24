//
//  NYSliderPopover.h
//  NYReader
//
//  Created by Cassius Pacheco on 21/12/12.
//  Copyright (c) 2012 Nyvra Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYPopover.h"

@interface NYSliderPopover : UISlider

@property (nonatomic, strong) NYPopover *popover;
@property (nonatomic, assign) CGFloat popoverWidth;
@property (nonatomic, assign) CGFloat popoverHeight;

- (void)showPopover;
- (void)showPopoverAnimated:(BOOL)animated;
- (void)hidePopover;
- (void)hidePopoverAnimated:(BOOL)animated;
- (void)setPopoverText:(NSString*) text;

@end
