//
//  NSMutableDictionary+Safe.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

- (void)safeSetObject:(id) value forKey:(id<NSCopying>) key{
    
    if (value && ![value isEqual:[NSNull null]]) {
        [self setObject:value forKey:key];
    }else{
        NSLog(@"保存了一个空数据 key 是 ：%@",key);
    }
}

@end

@implementation NSMutableArray (Safe)

- (void)safeAddObject:(id) object{
    
    if (object && ![object isEqual:[NSNull null]]) {
        [self addObject:object];
    }else{
        NSLog(@"保存了一个空数据");
    }
}

@end
