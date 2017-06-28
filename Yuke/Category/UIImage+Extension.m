//
//  UIImage+Extension.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/2/28.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageW = 3;
    CGFloat imageH = 3;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithDottedline{
    
    CGFloat dottedLineWidth = 3.5;
    CGFloat solidLineWidth = 7.0;
    
    CGSize size = CGSizeMake(solidLineWidth + dottedLineWidth, 1);
    
    UIGraphicsBeginImageContext(size); //开始画线 划线的frame
    
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, COLOR_RGB(203, 203, 203, 1.0).CGColor);
    
    CGContextMoveToPoint(line, 0.0, 1.0);
    
    CGContextAddLineToPoint(line, solidLineWidth, 1.0);
    
    CGContextStrokePath(line);
    
    CGContextSetStrokeColorWithColor(line, WHITECOLOR.CGColor);
    
    CGContextMoveToPoint(line, solidLineWidth, 1.0);
    
    CGContextAddLineToPoint(line, solidLineWidth + dottedLineWidth, 1.0);
    
    CGContextStrokePath(line);
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
