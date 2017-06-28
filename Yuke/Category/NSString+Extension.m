//
//  NSString+Extension.m
//  SCInterest
//
//  Created by 007 on 15/11/22.
//  Copyright © 2015年 wkj. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

// 去除字符串 两端空白 和所有的换行
-(NSString *)stringByTrimmingWhitespaceAndAllNewLine
{
    NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    return temp;
}

// 匹配字符串中得链接
- (NSArray *) matchLinks{
    //匹配链接
    NSError *error;
    
    NSString *regulaStr = @"(http|ftp|https)://[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    //存放匹配到的 链接字符串
    NSMutableArray *urls = [NSMutableArray array];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [self substringWithRange:match.range];
        [urls addObject:substringForMatch];
    }
    
    return urls;
}

/**
 *  字符串首字母转拼音,返回大写拼音首字母
 *
 *  @return 字符串首字母拼音大写
 */
-(NSString *)stringToFirstCharactor
{
    NSString *charactor = @"#";
    
    if ([self isEqualToString:@""] || !self) {
        return charactor;
    }
    
    NSMutableString *source = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    
    char ch = (char)[source characterAtIndex:0];
    
    if ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')) {
        if (ch >= 'a' && ch <= 'z') {
            charactor = [NSString stringWithFormat:@"%c",ch - 32];
            return charactor;
        }else{
            charactor = [NSString stringWithFormat:@"%c",ch];
            return charactor;
        }
    }else{
        return charactor;
    }
    
    return charactor;
}

// 汉字转拼音
- (char)phoneticToChar{

    NSMutableString *source = [self mutableCopy];
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

// 判断字符串是否是手机号
- (BOOL) isMobile{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 判断字符串是否符合邮箱格式
- (BOOL) isEmail{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

// 判断是否是特殊字符
- (BOOL) isSpecialCharacter{
    
    NSString *specialCharacter = @"[a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", specialCharacter];
    
    if (![pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

// 判断字符串是否是空字符串，过滤空格，换行
- (BOOL) isEmptyString{
    
    NSString *trimmingString = [self stringByTrimmingWhitespaceAndAllNewLine];
    
    if ([trimmingString isEqualToString:@""] || !trimmingString ) {
        return YES;
    }
    
    return NO;
}

// 判断字符串是否是合法密码
- (BOOL)isLegalPassword{
    
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:self];
}

#pragma mark - 类扩展

// 按照标准格式 ：yyyy-MM-dd HH:mm:ss 格式化当前时间并返回时间字符串
+ (NSString *)standardFormartCurrentDate{
    //格式化 时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [formatter stringFromDate:[NSDate date]];

    return dateString;
}

// YYYY-MM
+ (NSString *)dateFormartByYYYY_Month{
    //格式化 时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}

// 根据传入的时间的毫秒值，按照yyyy-MM-dd HH:mm:ss 返回一个格式化后的时间字符串
+ (NSString *)standardFormartWithTimeInterval:(NSNumber *) timeInterval{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]]];
    
    return dateString;
}

// 将字符串按照标准格式化标准 格式化为时间字符串
- (NSString *)dateFormartByStandard{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    if (self.length > 10) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *date = [formatter dateFromString:self];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [formatter stringFromDate:date];
}

// yyyy-MM-dd

- (NSString *)dateFormartByYYYY_MM_dd{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    if (self.length > 10) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *date = [formatter dateFromString:self];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    
    return [formatter stringFromDate:date];
}

// MM月dd日 HH:mm:ss

- (NSString *)dateFormartByMM_Month_dd_day_HH_mm_ss{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    if (self.length > 10) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *date = [formatter dateFromString:self];
    
    formatter.dateFormat = @"MM月dd日 HH:mm:ss";
    
    return [formatter stringFromDate:date];
}

// MM-dd HH:mm
- (NSString *)dateFormartByMM_dd_HH_mm{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    if (self.length > 10) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *date = [formatter dateFromString:self];
    
    formatter.dateFormat = @"MM-dd HH:mm";
    
    return [formatter stringFromDate:date];
}

// 格式化时间字符串为 多久前
-(NSString *)formatterDateStringForHowLong;
{
    if (!self) {
        return @"刚刚";
    }
    
    //格式化 时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat : @"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:self];
    
    if (!date) {
        return @"刚刚";
    }
    
    //创建时间
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:[NSTimeZone localTimeZone] fromDate:date];
    //当前时间
    NSDateComponents *currentComponents = [[NSCalendar currentCalendar] componentsInTimeZone:[NSTimeZone localTimeZone] fromDate:[NSDate new]];
    
    //判断年是否相同
    if (dateComponents.year != currentComponents.year) {
        [formatter setDateFormat : @"YY-MM-dd HH:mm"];
        return [formatter stringFromDate:date];
    }
    
    //判断月是否相同
    if (dateComponents.month != currentComponents.month) {
        [formatter setDateFormat : @"MM-dd HH:mm"];
        return [formatter stringFromDate:date];
    }
    
    //判断日是否相同
    if (dateComponents.day != currentComponents.day) {
        return [NSString stringWithFormat:@"%ld天前",(long)currentComponents.day-dateComponents.day];
    }
    
    //判断时是否相同
    if (dateComponents.hour != currentComponents.hour) {
        return [NSString stringWithFormat:@"%ld小时前",(long)currentComponents.hour-dateComponents.hour];
    }
    
    //判断分是否相同
    if (dateComponents.minute != currentComponents.minute) {
        return [NSString stringWithFormat:@"%ld分钟前",(long)currentComponents.minute-dateComponents.minute];
    }
    
    return @"刚刚";
}

#pragma mark - money format

/*
 *  将number类型的数字格式化成 形如 123,456.00格式
 */
- (NSString *) formatTo_Y{
    
    // 防止传入是实际是number类型
    NSString *numString = [NSString stringWithFormat:@"%@",self];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumIntegerDigits = 1;                     // 整数最少位数
    formatter.minimumFractionDigits = 2;                    // 小数最少位数
    formatter.groupingSize = 3;                             // 数字分割大小
    formatter.decimalSeparator = @".";                      // 小数点样式
    
    NSNumber *number = [formatter numberFromString:numString];
    
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    NSString *formatString = [formatter stringFromNumber:number];
    
    return formatString ? : @"0.00";
}

@end
