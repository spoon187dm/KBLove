//
//  CircleCell.h
//  KBLove
//
//  Created by 1124 on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBCircleInfo.h"
@interface CircleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Circle_headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *Circle_NameLable;
@property (weak, nonatomic) IBOutlet UILabel *CircleLastMessageLable;
@property (weak, nonatomic) IBOutlet UILabel *CircleMessageTimeLable;
- (void)ConfigWithModel:(KBCircleInfo *)cModel;
@end
