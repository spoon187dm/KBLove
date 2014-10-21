
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface KBGoalBarPercentLayer : CALayer

@property (nonatomic) CGFloat percent;
@end


@interface KBGoalBar : UIView {
    UIImage * thumb;
    
    KBGoalBarPercentLayer *percentLayer;
    CALayer *thumbLayer;
    
}

@property (nonatomic, strong) UILabel *percentLabel;

- (void)setPercent:(int)percent animated:(BOOL)animated;


@end



