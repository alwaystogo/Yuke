//
//  NSDictionary+Helper.m
//  LinkFinance
//
//  Created by yangyunfei on 16/6/30.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

#pragma mark - 私有方法
//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSArray中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}

- (id)objectForKeySafeArray:(id)aKey{
    
    
    if([self objectForKey:aKey] != nil && ![[self objectForKey:aKey] isKindOfClass:[NSNull class]] && [[self objectForKey:aKey] isKindOfClass:[NSArray class]]){
        
        return [self objectForKey:aKey];
    }
    
    return [[NSArray alloc] init];
}

- (id)objectForKeySafe:(id)aKey{
    
    if ([[self objectForKey:aKey] isKindOfClass:[NSNull class]]) {
        
        return @"";
    }
    
    return [self objectForKey:aKey];
}

- (id)safeAll{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self];
    
    for (id key in [tempDic allKeys]) {
        
        if ([[tempDic objectForKey:key] isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
        }
    }
    
    return tempDic;
}

- (id)safeAllEx{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:self];
    
    for (NSString *key in [tempDic allKeys]) {
        
        if ([[tempDic objectForKey:key] isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
            
        } else if ([[tempDic objectForKey:key] isKindOfClass:[NSArray class]]){
            
            NSArray *arr = [tempDic objectForKey:key];
            
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:arr];
            
            for (NSDictionary *dic in arr) {
                
                NSMutableDictionary *tDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                
                tDic = [dic safeAllEx];
                
                [tempArray replaceObjectAtIndex:[tempArray indexOfObject:dic] withObject:tDic];
            }
            [tempDic removeObjectForKey:key];
            
            [tempDic setObject:tempArray forKey:key];
            
        } else if ([[tempDic objectForKey:key] isKindOfClass:[NSDictionary class]]){
            
            NSDictionary *aDic = [tempDic objectForKey:key];
            
            NSMutableDictionary *mDic = [aDic safeAllEx];
            
            [tempDic removeObjectForKey:key];
            
            [tempDic setObject:mDic forKey:key];
            
        }
    }
    return tempDic;
}

- (NSDictionary *)deleteNullValueObject{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in self.allKeys) {
        
        if (![[self objectForKey:keyStr] isEqual:[NSNull null]] && ![[self objectForKey:keyStr] isEqualToString:@""]) {
            
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}


@end
