//
//  NSString+Extension.h
//  SCInterest
//
//  Created by 007 on 15/11/22.
//  Copyright © 2015年 wkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)


/**
 *  去除字符串中间的换行
 *
 *  @return 返回去除换行后的字符串
 */
- (NSString *)stringByTrimmingWhitespaceAndAllNewLine;


/**
 *  匹配字符串中得链接
 *
 *  @return 返回链接字符串数组
 */
- (NSArray *) matchLinks;


/**
 *  汉字转拼音
 *
 *  @return 拼音字母
 */
- (char)phoneticToChar;

/*
 *  获取字符串首字母
 *
 *  return 返回字符串的首字母
 */
-(NSString *)stringToFirstCharactor;

/**
 *  手机号码验证
 *
 *  @return 返回这个字符串是否是手机号格式 YES 代表是手机号 NO 代表不是
 */
- (BOOL) isMobile;

/**
 *  邮箱验证
 *  判断字符串是否是邮箱格式的
 *
 *  @return YES 代表是邮箱格式的 NO 代表不是
 */
- (BOOL) isEmail;

/**
 *  特殊字符验证，判断字符串中是否包含特殊字符
 *
 *  @return YES 代表包含有特殊字符， NO 代表不包含特殊字符
 */
- (BOOL) isSpecialCharacter;

/*
 *  判断字符串是否是空字符串，过滤空格，换行
 *
 *  return YES 代表是空串或者nil NO 代表有值
 */
- (BOOL) isEmptyString;

/*
 *  判断字符串是否符合6-12位合法密码
 *
 *  return YES 代表合法 NO 代表不合法
 */
- (BOOL) isLegalPassword;

#pragma mark - 类扩展

/**
 *  按照标准格式 ：yyyy-MM-dd HH:mm:ss 格式化当前时间
 *
 *  @return 返回经过标准格式化当前时间后的字符串日期
 */
+ (NSString *)standardFormartCurrentDate;

//
/**
 *  按照标准格式 ：YYYY-MM 格式化当前时间
 *
 *  @return 返回经过标准格式化当前时间后的字符串日期
 */
+ (NSString *)dateFormartByYYYY_Month;

/**
 *  根据传入的时间的毫秒值，按照yyyy-MM-dd HH:mm:ss 返回一个格式化后的时间字符串
 *
 *  @param timeInterval 时间毫秒值
 *
 *  @return 返回一个格式化后的时间字符串
 */
+ (NSString *)standardFormartWithTimeInterval:(NSNumber *) timeInterval;


/**
 *  将字符串按照标准格式化标准 格式化为时间字符串
 *
 *  @return 返回格式化后的时间字符串
 */
- (NSString *)dateFormartByStandard;

/**
 *  将字符串按照 yyyy-MM-dd 格式 格式化为日期字符串
 *
 *  @return 返回格式化后的时间字符串
 */
- (NSString *)dateFormartByYYYY_MM_dd;

/**
 *  将字符串按照 MM月dd日 HH:mm:ss 格式 格式化为日期字符串
 *
 *  @return 返回格式化后的时间字符串
 */
- (NSString *)dateFormartByMM_Month_dd_day_HH_mm_ss;

/**
 *  将字符串按照 MM-dd HH:mm 格式 格式化为日期字符串
 *
 *  @return 返回格式化后的时间字符串
 */
- (NSString *)dateFormartByMM_dd_HH_mm;

/**
 *  格式化时间字符串为 多久前
 *
 *  @return 返回刚刚，多少分钟前，多少天前，或者几月几号
 */
-(NSString *)formatterDateStringForHowLong;

#pragma mark - money format

/*
 *  将number类型的数字格式化成 形如 123,456.00格式
 */
- (NSString *) formatTo_Y;

@end
