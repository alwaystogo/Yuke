//
//  NSArray+LogHelper.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/3.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "NSArray+LogHelper.h"

@implementation NSArray (LogHelper)

-(NSMutableArray *)indexCharacterArray{
    
    // 给indexCharacterArray赋值
    NSMutableArray *indexArrayM = [NSMutableArray array];
    
    for (NSObject *object in self) {
        
        if ([[object soryKeyName] isEqualToString:@""]) {
            return nil;
        }
        
        NSString *value = [object valueForKey:[object soryKeyName]];
        
        unichar charString = [[value stringToFirstCharactor] characterAtIndex:0];
        
        NSString *indexKey = [NSString stringWithFormat:@"%c",charString] ;
        
        if (![indexArrayM containsObject:indexKey]) {
            [indexArrayM addObject:indexKey];
        }
    }
    
    return  indexArrayM;
}

// 根据首字母索引，返回真正数组中对应的索引下标
- (NSMutableArray *)sortArrayRealIndexArray{
    
    NSMutableArray *selectIndexArray = [NSMutableArray array];
    
    for (NSString *charactorString in self.indexCharacterArray) {
        
        for (int i = 0; i < self.count ; i ++) {
            
            NSObject *object = self[i];
            
            NSString *value = [object valueForKey:[object soryKeyName]];
            
            unichar charString = [[value stringToFirstCharactor] characterAtIndex:0];
            
            NSString *indexKey = [NSString stringWithFormat:@"%c",charString] ;
            
            if ([indexKey isEqualToString:charactorString]) {
                [selectIndexArray addObject:@(i)];
                break;
            }
        }
    }
    
    return selectIndexArray;
}

#pragma mark - 名字数据按照首字母分组排序
- (NSMutableArray *)sortByInitials;
{
    NSMutableArray* groupArray = [NSMutableArray array];
    
    // 最后一个数组为#数组
    for (int i = 0; i < 27; i++) {
        NSMutableArray* subArray = [NSMutableArray array];
        [groupArray addObject:subArray];
    }
    
    for (NSObject *object in self) {
        
        // object需要实现的分类方法
        NSString *value = [object valueForKey:[object soryKeyName]];
        
        char ch = [self phonetic:value];
        
        if (!value) {
            break;
        }
        
        if ((ch >= 'A' && ch <= 'Z')) {
            NSInteger index = ch -'A' + 1;
            
            NSMutableArray* subArray = [groupArray objectAtIndex:index];
            [subArray addObject:object];
            [groupArray replaceObjectAtIndex:index withObject:subArray];
        }else{
            NSMutableArray* subArray = [groupArray objectAtIndex:26];
            [subArray addObject:object];
            [groupArray replaceObjectAtIndex:26 withObject:subArray];
        }
    }
    
    NSMutableArray *sortedArrayM = [NSMutableArray array];
    
    for (int i = 0; i < groupArray.count; i ++) {
        
        NSMutableArray *itemArrayM = (NSMutableArray*)groupArray[i];
        
        for (NSObject *itemObject in itemArrayM) {
            [sortedArrayM addObject:itemObject];
        }
    }
    
    return sortedArrayM;
}

- (char)phonetic:(NSString*)sourceString
{
    if (!sourceString || [sourceString isEqualToString:@""]) {
        return '#';
    }
    
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    char ch = (char)[source characterAtIndex:0];
    if ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')) {
        if (ch >= 'a' && ch <= 'z') {
            return ch - 32;
        }else{
            return ch;
        }
    }else{
        return '#';
    }
}

#pragma mark - log

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (LogHelper)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

@end
