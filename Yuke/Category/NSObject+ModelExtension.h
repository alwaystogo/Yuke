//
//  NSObject+ModelExtension.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/23.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ModelExtension)

+(instancetype)modelWithDict:(NSDictionary *) dict;

#pragma mark - 供拼音排序使用的排序key

- (NSString *) soryKeyName;

@end
