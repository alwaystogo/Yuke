//
//  NSMutableDictionary+Safe.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 可变字典

@interface NSMutableDictionary (Safe)

/*
 *  可变字典保存对象的安全方法，防保存的值为nil崩溃，并过滤NSNull对象
 */
- (void)safeSetObject:(id) value forKey:(id<NSCopying>) key;

@end

#pragma mark - 可变数组

@interface NSMutableArray (Safe)

/*
 *  可变数组保存对象的安全方法，防object为nil崩溃，过滤NSNull对象
 */
- (void)safeAddObject:(id) object;

@end
