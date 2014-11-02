//
//  NYPopover.m
//  NYReader
//
//  Created by Cassius Pacheco on 21/12/12.
//  Copyright (c) 2012 Nyvra Software. All rights reserved.
//

#import "NYPopover.h"
#import "CCUtils.h"
#import "CCTrackerUtils.h"

@implementation NYPopover

#define LABEL_HEIGHT 26

#define MARGIN_TOP          6

#define BG_PADDING_LEFT     8
#define BG_PADDING_TOP      8
#define BG_PADDING_RIGHT    8
#define BG_PADDING_BOTTOM   8

#define ARROW_HEIGHT        6
#define ARROW_WIDTH         10
#define ARROW_PADDING       -5

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bg = [[UIImageView alloc] initWithFrame:self.bounds];
        [CCUtils setUIImageViewStretchImage:_bg imageName:@"popover.png" scaleIfNotRetina:NO left:16 top:16 right:16 bottom:16];
        [self addSubview:_bg];
        _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ARROW_WIDTH, ARROW_HEIGHT)];
        _arrow.image = [CCTrackerUtils loadImageFromCache:@"popover_arrow.png"];
        [self addSubview:_arrow];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont boldSystemFontOfSize:13];
        _textLabel.text = @"12:48";
        [CCUtils setUILabelAlignCenter:_textLabel];
        _textLabel.adjustsFontSizeToFitWidth = YES;
        _textLabel.opaque = NO;
        [self addSubview:_textLabel];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat y = (frame.size.height - LABEL_HEIGHT) / 3;
    if (frame.size.height < 38) {
        y = 0;
    }
    
    [_textLabel sizeToFit];
    _textLabel.center = CGPointMake([CCUtils centerX:self], [CCUtils centerY:_textLabel] + MARGIN_TOP);
//    _textLabel.frame = CGRectMake(0, y, frame.size.width, LABEL_HEIGHT);
    _bg.frame = CGRectMake([CCUtils left:_textLabel] - BG_PADDING_LEFT,
                           [CCUtils top:_textLabel] - BG_PADDING_TOP,
                           [CCUtils width:_textLabel] + BG_PADDING_LEFT + BG_PADDING_RIGHT,
                           [CCUtils height:_textLabel]  + BG_PADDING_TOP + BG_PADDING_BOTTOM);
    
    _bg.center = CGPointMake(_textLabel.center.x, _textLabel.center.y);
    _arrow.center = CGPointMake(_textLabel.center.x, [CCUtils bottom:_bg] + [CCUtils centerY:_arrow] + ARROW_PADDING);
}
//];
//    [bezierPath closePath];
//    CGContextSaveGState(context);
//    [bezierPath addClip];
//    CGRect bezierBounds = bezierPath.bounds;
//    CGContextDrawLinearGradient(context, gradient,
//                                CGhadowBlurRadius);

//        CGFloat xOffset = innerShadowOffset.width + round(bezierBorderRect.size.width);
//        CGFloat yOffset = innerShadowOffset.height;

//    
//    //// Cleanup
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
//}

@end
