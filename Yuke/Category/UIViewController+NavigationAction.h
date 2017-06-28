//
//  UIViewController+NavigationAction.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/21.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationAction)

- (void)goBackToHomePage;

- (void)goBackToPrevPage;

#pragma mark - topBackground image

- (void)addTopBackgroundImageView;

#pragma mark - navbar left and right button item

/*
 *  设置导航条左侧白色返回按钮
 */
- (void)setLeftBackNavItem;

/*
 *  设置导航条左侧黑色返回按钮
 */
- (void)setBlackBackLeftNavgationItem;

/*
 *  设置导航条右侧的消息按钮
 */
- (void)setRightMessageButton;


#pragma mark - 导航条主题设置相关-appearance

/*
 *  设置导航条为白色主题,顺便隐藏navbar底部的黑线
 */
- (void)setWhiteNavgationAppearance;

/*
 *  设置导航条为透明主题，顺便隐藏navbar底部的黑线
 */
- (void)setClearNavgationAppearance;

/*
 *  恢复导航条显示主题
 */
- (void)revertNavgationAppearanceToBlack;

#pragma mark - 设置首页全局的nav背景图 (彩色背景)

/*
 *  设置首页全局的nav背景图,高度与navbar相同,右侧有消息按钮，无左侧返回按钮
 */
- (void)setHomeGlobalNavBackgroundImage;

/*
 *  将全局的nav背景图恢复为黑色背景
 */
- (void)revertHomeGloadNavBackgroundImageToBlack;

#pragma mark - 设置web页面nav背景 （彩色背景） 带左侧返回按钮和右侧分享按钮

/*
 *  设置web页面nav背景，左侧有返回按钮，右侧有分享按钮
 */
- (void)setWebPageTopBackgroundBarRightButtonWithTarget:(id) target action:(SEL) selector;

/*
 *  移除web页面的nav背景
 */
- (void)revertWebPageTopBackgroundBar;

#pragma mark - 设置web页面新手分享的nav背景 （彩色背景） 带左侧返回按钮
/*
 *  设置新手活动web页面nav背景，左侧有返回按钮
 */
- (void)setNewCustomerWebPageTopBar;

/*
 *  移除新手活动web页面的nav背景
 */
- (void)revertNewCustomerWebPageTopBar;

@end
