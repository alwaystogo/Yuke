//
//  UIImage+Extension.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/2/28.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


/*
 *  传递颜色返回一张图
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/*
 *  返回一张虚线图
 */
+ (UIImage *)imageWithDottedline;

@end
