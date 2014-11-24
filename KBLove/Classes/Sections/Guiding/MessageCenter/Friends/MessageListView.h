//
//  MessageListView.h
//  KBLove
//
//  Created by 1124 on 14/11/8.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *Circle_headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *Circle_NameLable;
@property (weak, nonatomic) IBOutlet UILabel *CircleLastMessageLable;
@property (weak, nonatomic) IBOutlet UILabel *CircleMessageTimeLable;
@property (weak, nonatomic) IBOutlet UIView *UnReadView;
@property (weak, nonatomic) IBOutlet UILabel *UnReadCountLable;
@end
