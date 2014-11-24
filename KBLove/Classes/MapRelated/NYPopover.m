//
//  NYPopover.m
//  NYReader
//
//  Created by Cassius Pacheco on 21/12/12.
//  Copyright (c) 2012 Nyvra Software. All rights reserved.
//

#import "NYPopover.h"
#import "ZWL_Utils.h"
//#import "CCTrackerUtils.h"

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
        [ZWL_Utils setUIImageViewStretchImage:_bg imageName:@"popover.png" scaleIfNotRetina:NO left:16 top:16 right:16 bottom:16];
        [self addSubview:_bg];
        _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ARROW_WIDTH, ARROW_HEIGHT)];
        _arrow.image = [UIImage imageNamed:@"popover_arrow.png"];
        [self addSubview:_arrow];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont boldSystemFontOfSize:13];
        _textLabel.text = @"12:48";
        [ZWL_Utils setUILabelAlignCenter:_textLabel];
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
    _textLabel.center = CGPointMake([ZWL_Utils centerX:self], [ZWL_Utils centerY:_textLabel] + MARGIN_TOP);
//    _textLabel.frame = CGRectMake(0, y, frame.size.width, LABEL_HEIGHT);
    _bg.frame = CGRectMake([ZWL_Utils left:_textLabel] - BG_PADDING_LEFT,
                           [ZWL_Utils top:_textLabel] - BG_PADDING_TOP,
                           [ZWL_Utils width:_textLabel] + BG_PADDING_LEFT + BG_PADDING_RIGHT,
                           [ZWL_Utils height:_textLabel]  + BG_PADDING_TOP + BG_PADDING_BOTTOM);
    
    _bg.center = CGPointMake(_textLabel.center.x, _textLabel.center.y);
    _arrow.center = CGPointMake(_textLabel.center.x, [ZWL_Utils bottom:_bg] + [ZWL_Utils centerY:_arrow] + ARROW_PADDING);
}

//- (void)drawRect:(CGRect)rect
//{
//    //// General Declarations
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    //// Color Declarations
//    UIColor* gradientColor = [UIColor colorWithRed: 0.267 green: 0.303 blue: 0.335 alpha: 1];
//    UIColor* gradientColor2 = [UIColor colorWithRed: 0.04 green: 0.04 blue: 0.04 alpha: 1];
//    UIColor* shadowColor2 = [UIColor colorWithRed: 0.524 green: 0.553 blue: 0.581 alpha: 0.3];
//
//    //// Gradient Declarations
//    NSArray* gradientColors = [NSArray arrayWithObjects:
//                               (id)gradientColor.CGColor,
//                               (id)gradientColor2.CGColor, nil];
//    CGFloat gradientLocations[] = {0, 1};
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
//
//    //// Shadow Declarations
//    UIColor* innerShadow = shadowColor2;
//    CGSize innerShadowOffset = CGSizeMake(0, 1.5);
//    CGFloat innerShadowBlurRadius = 0.5;
//
//    //// Frames
//    CGRect frame = self.bounds;
//
//    //// Subframes
//    CGRect frame2 = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 11) * 0.51724 + 0.5), CGRectGetMinY(frame) + CGRectGetHeight(frame) - 9, 11, 9);
//
//
//    //// Bezier Drawing
//    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
//    [bezierPath moveToPoint: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMinY(frame) + 4.5)];
//    [bezierPath addLineToPoint: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMaxY(frame) - 11.5)];
//    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMaxX(frame) - 4.5, CGRectGetMaxY(frame) - 7.5) controlPoint1: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMaxY(frame) - 9.29) controlPoint2: CGPointMake(CGRectGetMaxX(frame) - 2.29, CGRectGetMaxY(frame) - 7.5)];
//    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame2) + 10.64, CGRectGetMinY(frame2) + 1.5)];
//    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame2) + 5.5, CGRectGetMinY(frame2) + 8)];
//    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame2) + 0.36, CGRectGetMinY(frame2) + 1.5)];
//    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 4.5, CGRectGetMaxY(frame) - 7.5)];
//    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.5, CGRectGetMaxY(frame) - 11.5) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 2.29, CGRectGetMaxY(frame) - 7.5) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.5, CGRectGetMaxY(frame) - 9.29)];
//    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.5, CGRectGetMinY(frame) + 4.5)];
//    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 4.5, CGRectGetMinY(frame) + 0.5) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.5, CGRectGetMinY(frame) + 2.29) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 2.29, CGRectGetMinY(frame) + 0.5)];
//    [bezierPath addLineToPoint: CGPointMake(CGRectGetMaxX(frame) - 4.5, CGRectGetMinY(frame) + 0.5)];
//    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMinY(frame) + 4.5) controlPoint1: CGPointMake(CGRectGetMaxX(frame) - 2.29, CGRectGetMinY(frame) + 0.5) controlPoint2: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMinY(frame) + 2.29)];
//    [bezierPath closePath];
//    CGContextSaveGState(context);
//    [bezierPath addClip];
//    CGRect bezierBounds = bezierPath.bounds;
//    CGContextDrawLinearGradient(context, gradient,
//                                CGPointMake(CGRectGetMidX(bezierBounds), CGRectGetMinY(bezierBounds)),
//                                CGPointMake(CGRectGetMidX(bezierBounds), CGRectGetMaxY(bezierBounds)),
//                                0);
//    CGContextRestoreGState(context);
//
//    ////// Bezier Inner Shadow
//    CGRect bezierBorderRect = CGRectInset([bezierPath bounds], -innerShadowBlurRadius, -innerShadowBlurRadius);
//    bezierBorderRect = CGRectOffset(bezierBorderRect, -innerShadowOffset.width, -innerShadowOffset.height);
//    bezierBorderRect = CGRectInset(CGRectUnion(bezierBorderRect, [bezierPath bounds]), -1, -1);
//
//    UIBezierPath* bezierNegativePath = [UIBezierPath bezierPathWithRect: bezierBorderRect];
//    [bezierNegativePath appendPath: bezierPath];
//    bezierNegativePath.usesEvenOddFillRule = YES;
//
//    CGContextSaveGState(context);
//    {
//        CGFloat xOffset = innerShadowOffset.width + round(bezierBorderRect.size.width);
//        CGFloat yOffset = innerShadowOffset.height;
//        CGContextSetShadowWithColor(context,
//                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
//                                    innerShadowBlurRadius,
//                                    innerShadow.CGColor);
//        
//        [bezierPath addClip];
//        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(bezierBorderRect.size.width), 0);
//        [bezierNegativePath applyTransform: transform];
//        [[UIColor grayColor] setFill];
//        [bezierNegativePath fill];
//    }
//    CGContextRestoreGState(context);
//    
//    [[UIColor blackColor] setStroke];
//    bezierPath.lineWidth = 1;
//    [bezierPath stroke];
//    
//    
//    //// Cleanup
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
//}

@end
