//
//  NSDictionary+Helper.h
//  LinkFinance
//
//  Created by yangyunfei on 16/6/30.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Helper)

// 将null转为空字符串
- (id)objectForKeySafe:(id)aKey;

//返回一个数组，防止后台返回异常数组
- (id)objectForKeySafeArray:(id)aKey;

//遍历所有的value,将存在的null转为空字符串
- (id)safeAll;

- (id)safeAllEx;

//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj;

//删除字典中，value值为空的键值对
- (NSDictionary *)deleteNullValueObject;


@end
