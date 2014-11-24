//
//  BottomSelectView.h
//  KBLove
//
//  Created by block on 14/11/3.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomSelectView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *allSelectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *readImageView;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImageView;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *readButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
