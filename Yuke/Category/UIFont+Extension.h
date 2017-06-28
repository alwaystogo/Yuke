//
//  UIFont+Extension.h
//  SCInterest
//
//  Created by 王柯佳 on 15/11/6.
//  Copyright © 2015年 taiyiheng. All rights reserved.
//  字体适配的分类

#import <UIKit/UIKit.h>

@interface UIFont (Extension)


/**
 *  返回一个默认的字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 根据字体大小返回一个默认的字体实例
 */
+ (instancetype)systemFontWithSize:(CGFloat) fontSize;

/**
 *  返回一个默认加粗的字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 根据字体大小返回一个默认的字体实例
 */
+ (instancetype)systemFontWithBlodSize:(CGFloat) fontSize;

#pragma mark - iOS 9 苹方字体，如果为iOS 8 设备则仍然为系统字体

/**
 *  iOS 9之后系统自带的苹方细体 PingFangSC-Light
 *
 *  @param fontSize 适配的字体大小
 */
+ (instancetype)pingFangSC_LightWithFont:(CGFloat) fontSize;

/*
 *  iOS 9之后系统自带的苹方常规体 PingFangSC-Regular
 *
 *  @param fontSize 字体大小，内部会自动调整适配
 *
 *  return 返回苹方常规体，如果是iOS 8则为systemFontOfSize
 */
+ (instancetype)pingFangSC_RegularWithFont:(CGFloat ) fontSize;

/*
 *  iOS 9之后系统自带的苹方中黑体 PingFangSC-Medium
 *
 *  @param fontSize 字体大小，内部会自动调整适配
 *
 *  return 返回苹方中黑体，如果是iOS 8则为systemFontOfSize
 */
+ (instancetype)pingFangSC_MediumWithFont:(CGFloat ) fontSize;

/*
 *  iOS 9之后系统自带的苹方中粗体 PingFangSC-Semibold
 *
 *  @param fontSize 字体大小，内部会自动调整适配
 *
 *  return 返回苹方中粗体，如果是iOS 8则为boldSystemFontOfSize
 */
+ (instancetype)pingFangSC_SemiboldWithFont:(CGFloat ) fontSize;




@end
