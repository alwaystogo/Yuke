//
//  NSNumber+FormatExtension.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/28.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "NSNumber+FormatExtension.h"

@implementation NSNumber (FormatExtension)

/*
 *  将number类型的数字格式化成 形如 123,456.00格式
 */
- (NSString *) formatTo_Y{
    
    // 防止传入是实际是字符串类型
    NSString *numString = [NSString stringWithFormat:@"%@",self];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumIntegerDigits = 1;
    formatter.minimumFractionDigits = 2;
    formatter.groupingSize = 3;
    formatter.decimalSeparator = @".";
    
    NSNumber *number = [formatter numberFromString:numString];
    
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    NSString *formatString = [formatter stringFromNumber:number];
    
    return formatString ? : @"0.00";
}

@end
