//
//  UIViewController+Help.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Help)
#pragma mark - UINavigationItems

//导航栏右按钮
- (void)setupRightNavButton:(NSString *)title
               withTextFont:(UIFont *)font
                withTextColor:(UIColor *)color
                     target:(id)target
                     action:(SEL)action;

- (void)setupRightNavButton:(UIImage*)image
                     target:(id)target
                     action:(SEL)action;

- (void)setupRightNavButton2:(UIImage*)image
                      target:(id)target
                      action:(SEL)action;
- (void)setupRightNavButton:(UIImage*)image
                 withOffset:(float)offset
                     target:(id)target
                     action:(SEL)action;

-(void)setupRightNavButton:(UIImage*)image
                withOffset:(float)offset
                    target:(id)target
                    action:(SEL)action
    imageWithRenderingMode:(UIImageRenderingMode)imageModel;

- (void)setupRightNavItemsWithTarget:(id)target
                             actions:(NSArray *)actions
                         withImgArry:(NSArray*)imageArray
                   effectByTintColor:(BOOL)effect;

//导航栏左按钮
- (void)setupLeftNavButton:(UIImage*)image
                    target:(id)target
                    action:(SEL)action;

- (void)setupLeftNavButton:(UIImage*)image
                withOffset:(float)offset
                    target:(id)target
                    action:(SEL)action;

- (void)setupLeftNavButton:(UIImage*)image
                withOffset:(float)offset
                    target:(id)target
                    action:(SEL)action
    imageWithRenderingMode:(UIImageRenderingMode)imageModel;

- (void)setupLeftNavItemsWithTarget:(id)target
                            actions:(NSArray *)actions
                        withImgArry:(NSArray*)imageArray
                  effectByTintColor:(BOOL)effect;

- (void)setupBackItem:(NSString *)imageName
               action:(SEL)action;

+ (UIViewController*)currentViewController;
- (void)customeNavTitle:(NSString*)title Font:(UIFont*)font Color:(UIColor*)color;

/*
 *  适配iPhone X 底部的安全区域
 */
- (CGFloat)bottomSafeMargin;
@end
