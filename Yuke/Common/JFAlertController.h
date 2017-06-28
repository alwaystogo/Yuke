//
//  JFAlertController.h
//  LinkFinance
//
//  Created by ZhengYi on 16/6/14.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAnimationTime 0.2

typedef void(^alertHandler) (id result);

typedef NS_ENUM(NSInteger, JFAlertStyle) {
    
    JFAlertStyleAlertView = 0,
    JFAlertStyleActionSheet = 1
    
};

//////////////////////////////////////////////////////////////////////////////////////////

//没有采用modal出ViewController的方式，是因为每次点击都会有延迟
@interface JFAlertController : UIView//UIViewController

@property (strong, nonatomic) UIView *operationView;
@property (assign, nonatomic) BOOL needTapBgToHide; //是否允许点击背景时隐藏

- (id)initWithPreferedStyle:(JFAlertStyle)style;
- (void)show;
- (void)hide;


//需要重写，返回自定义的视图
- (UIView *)viewForOperationView;

@end
