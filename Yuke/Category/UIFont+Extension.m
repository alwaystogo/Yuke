//
//  UIFont+Extension.m
//  SCInterest
//
//  Created by 王柯佳 on 15/11/6.
//  Copyright © 2015年 taiyiheng. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

/**
 *  返回一个默认的字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 根据字体大小返回一个默认的字体实例
 */
+ (instancetype)systemFontWithSize:(CGFloat) fontSize{
    
    fontSize = _sizeToFitFontSize(fontSize);
    
    return [UIFont systemFontOfSize:fontSize];
}

/**
 *  返回一个默认加粗的字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 根据字体大小返回一个默认的字体实例
 */
+ (instancetype)systemFontWithBlodSize:(CGFloat) fontSize{
    
    fontSize = _sizeToFitFontSize(fontSize);
    
    return [UIFont boldSystemFontOfSize:fontSize];
}

#pragma mark - iOS 9 苹方字体，如果为iOS 8 设备则仍然为系统字体

/**
 *  iOS 9之后系统自带的苹方细体
 *
 *  @param fontSize 适配的字体大小
 */
+ (instancetype)pingFangSC_LightWithFont:(CGFloat) fontSize{
    
    fontSize = _sizeToFitFontSize(fontSize);
    
    // 如果是iOS 9
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
    }else{
        return [UIFont systemFontOfSize:fontSize];
    }    
}

// iOS 9之后系统自带的苹方常规体 PingFangSC-Regular
+ (instancetype)pingFangSC_RegularWithFont:(CGFloat ) fontSize{
    
    fontSize = _sizeToFitFontSize(fontSize);

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    }else{
        return [UIFont systemFontOfSize:fontSize];
    }
}

// iOS 9之后系统自带的苹方中黑体 PingFangSC-Medium
+ (instancetype)pingFangSC_MediumWithFont:(CGFloat ) fontSize{
    
    fontSize = _sizeToFitFontSize(fontSize);
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    }else{
        return [UIFont systemFontOfSize:fontSize];
    }
}

// iOS 9之后系统自带的苹方中粗体 PingFangSC-Semibold
+ (instancetype)pingFangSC_SemiboldWithFont:(CGFloat ) fontSize{
    
    fontSize = _sizeToFitFontSize(fontSize);
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
    }else{
        return [UIFont systemFontOfSize:fontSize];
    }
}


#pragma mark - private method

CGFloat _sizeToFitFontSize(CGFloat fontSize) {
    
    // 如果是4 或者 4s则将字号减小
    if (is3_5InchRetina) {
        fontSize -= 1.5;
    }
    
    // 5系列适配
    if (is4_0Inch) {
        fontSize -= 1.0;
    }
    
    // 以6系列为基准
    if (is4_7Inch) {
        
    }
    
    if (is5_5Inch) {
        
        fontSize += 1.0;
    }
    return fontSize;
}

@end
