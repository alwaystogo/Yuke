//
//  NSObject+ModelExtension.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/23.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "NSObject+ModelExtension.h"

#import <objc/runtime.h>

@implementation NSObject (ModelExtension)

+(instancetype)modelWithDict:(NSDictionary *) dict
{
    NSObject *model = [[self alloc] init];
    
    for (NSString *key in [self _properties]) {
        
        if (dict[key]) {
            
            if ([dict[key] isEqual:[NSNull null]]) {
                
                [model setValue:nil forKey:key];
                
            }else{
                
                [model setValue:dict[key] forKey:key];
            }
        }
    }
    return model;
}

+(NSArray *)_properties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *arryM = [NSMutableArray arrayWithCapacity:count];
    
    for (unsigned int i = 0; i < count; i ++) {
        objc_property_t parmeter = properties[i];
        
        const char *pname =  property_getName(parmeter);
        [arryM addObject:[NSString stringWithUTF8String:pname]];
    }
    
    return  arryM.copy;
}


#pragma mark - 供拼音排序使用的排序key

- (NSString *) soryKeyName{
    return @"";
}

- (NSString *) topKey{
    return @"";
}

@end
