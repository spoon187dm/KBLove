//
//  BlockMacro.h
//  KBLove
//
//  Created by block on 14-10-14.
//  Copyright (c) 2014年 block. All rights reserved.
//

#ifndef KBLove_BlockMacro_h
#define KBLove_BlockMacro_h

typedef void (^requestBlock)(BOOL isSuccess, id result);

typedef void (^boolReturnBlock)(BOOL isSuccess);

/**
 @Author block, 10-14 15:10
 
 用于设备列表获取回调
 
 @param isSuccess   是否成功
 @param deviceArray 列表
 */
typedef void (^ListLoadBlock)(BOOL isSuccess, NSArray *resultArray);
#endif
