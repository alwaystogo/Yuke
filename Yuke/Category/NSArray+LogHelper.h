//
//  NSArray+LogHelper.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LogHelper)

/**
 *  获取首字母数组集合
 *
 *  @return 返回不重复的首字母数组
 */
- (NSMutableArray *)indexCharacterArray;

/**
 *  传入首字母数组的索引，返回真正数组中对应的索引下标
 *
 *  @return 返回真正数组中对应的索引下标
 */
- (NSMutableArray *)sortArrayRealIndexArray;

@end


@interface NSDictionary (LogHelper)

@end
