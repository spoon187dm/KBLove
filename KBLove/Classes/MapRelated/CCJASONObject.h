//
//  CCJASONObject.h
//  Tracker
//
//  Created by apple on 13-11-11.
//  Copyright (c) 2013年 Capcare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelConstants.h"
#import "ProtocolConstants.h"

@protocol CCJASONObject <NSObject>

-(id) generateJasonObj;
-(void) readFromJason:(id)jason;

@end
