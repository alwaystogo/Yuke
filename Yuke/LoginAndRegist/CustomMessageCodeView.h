//
//  CustomMessageCodeView.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/2.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomMessageCodeView;

@protocol CustomMessageCodeViewDelegate <NSObject>

@optional

/*
 *  点击了自定义验证码按钮的代理事件
 *
 *  customMessageCodeView 当前的自定义验证码按钮view
 */
- (void)customMessageCodeViewClickMessageCodeButton:(CustomMessageCodeView *) customMessageCodeView;

@end


@interface CustomMessageCodeView : UIView

/*
 *  开始定时器倒数
 */
- (void)beginTimer;

/*
 *  重新设置按钮状态
 */
- (void)resetButton;

@property (nonatomic, weak) id<CustomMessageCodeViewDelegate> delegate ;

@property (nonatomic, strong) UIColor *borderColor ;        // 自定义外边框颜色

@property (nonatomic, strong) UIColor *titleColor ;         // 自定义按钮颜色

@property (nonatomic, strong) UIColor *timerLableColor ;    // 倒计时字体颜色


@end
