//
//  CrawlAlertConfiguration.m
//  KBLove
//
//  Created by qianfeng on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#import "CrawlAlertConfiguration.h"

@interface CrawlAlertConfiguration ()

@end

@implementation CrawlAlertConfiguration

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)awakeFromNib{
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)navLeftClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
