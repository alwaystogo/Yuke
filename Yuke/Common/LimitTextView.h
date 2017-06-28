//
//  LimitTextView.h
//  LinkFinance
//
//  Created by ZhengYi on 16/6/3.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LimitTextView;
@protocol LimitTextViewDelegate <NSObject>

@optional
- (void)limitTextViewDidBeginEditing:(LimitTextView *)textView;
- (void)limitTextView:(LimitTextView *)textView remainCharactorNumDidChanged:(NSInteger)remainNum;
- (void)limitTextView:(LimitTextView *)textView textLengthDidReachMaxNUm:(NSInteger)maxNum;


@end

@interface LimitTextView : UITextView

@property (assign, nonatomic) NSInteger maxLimitNum;
@property (assign, nonatomic) id<LimitTextViewDelegate> limitDelegate;
@property (copy, nonatomic) IBInspectable UIColor *placeHolderColor;
@property (copy,   nonatomic) IBInspectable NSString *placeHolderStr;
@property (assign, nonatomic) IBInspectable BOOL showPlaceHolder;

//当达到最大字符数时，是否只提示一次
@property (assign, nonatomic) BOOL maxNumAlertOnce;

- (void)addDelegate:(id)object;
- (void)setPlaceHolderStr:(NSString *)placeHolderStr;//设置placeHolder

@end
