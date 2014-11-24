//
//  FaceView.h
//  KBLove
//
//  Created by 1124 on 14/11/11.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectFaceBlock)(NSInteger selecttag);
@interface FaceView : UIView<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *FaceScrollerView;
@property (weak, nonatomic) IBOutlet UIPageControl *FacePageController;
- (void)configUIWithNameArray:(NSArray *)array AndBlock:(selectFaceBlock)block isAutoLayout:(BOOL)isaoutLayout;
@end
