//
//  JFTools+ProgressHUD.h
//  LinkFinance
//
//  Created by ZhengYi on 16/12/5.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFTools.h"

@interface JFTools (ProgressHUD)

/**
 *  二次封装MBProgressHUD
 *
 *  @param text 显示的文字
 *  @param view 要加载到的视图
 *  @param time 多长时间隐藏
 */
+ (void)MBProgressHUDWithText:(NSString *)text toView:(UIView *)view time:(NSInteger)time;

/**
 *  显示HUD，内容为指定的图片的文案
 *
 *  @param image 显示的图片
 *  @param tip 显示的文字
 */
+ (void)showHUDWithImage:(UIImage*)image Tip:(NSString*)tip;

/**
 *  显示HUD，只显示文字
 *
 *  @param tip 显示的文字
 */
+ (void)showTipOnHUD:(NSString*)tip;

/**
 *  显示HUD，只显示图片
 *
 *  @param image 显示的图片
 */
+ (void)showImageOnHUD:(UIImage*)image;

/**
 *  显示HUD，内容为圆形对勾和文字
 *
 *  @param tip 显示的文字
 */
+ (void)showSuccessHUDWithTip:(NSString*)tip;

/*
 *  显示成功HUD，内容为圆形对勾和文字,附带消失回调
 *
 *  @param tip 提示文字
 *
 *  @param dismissHandle 消失回调
 *
 */
+ (void)showSuccessHUDWithTip:(NSString *) tip dismissHandle:(void (^)(void)) dismissHandle;

/**
 *  显示HUD，内容为圆叉和文字
 *
 *  @param tip 显示的文字
 */
+ (void)showFailureHUDWithTip:(NSString*)tip;

/**
 *  显示失败HUD，内容为圆叉和文字，附带消失回调
 *
 *  @param tip 显示的文字
 */
+ (void)showFailureHUDWithTip:(NSString *) tip dismissHandle:(void (^)(void)) dismissHandle;

/**
 *  显示HUD，indicator
 */
+ (void)showLoadingHUD;

/**
 *  手动调用，隐藏HUD
 */
+ (void)HUDHide;


@end
