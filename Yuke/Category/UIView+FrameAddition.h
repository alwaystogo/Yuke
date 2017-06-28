//
//  UIView+FrameAddition.h
//  WillsonUtilities
//
//  Created by WillHelen on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameAddition)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (UIView *) rootSuperView;

/**
 *  当前view的controller
 *
 *  @return UIViewController
 */
- (UIViewController *)viewController;

@end
