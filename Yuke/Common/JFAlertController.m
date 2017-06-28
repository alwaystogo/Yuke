//
//  JFAlertController.m
//  LinkFinance
//
//  Created by ZhengYi on 16/6/14.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "JFAlertController.h"



@interface JFAlertController ()

@property (assign, nonatomic) JFAlertStyle style;
@property (strong, nonatomic) UIView *alertBgView;

@property (nonatomic, assign) BOOL notifiKeyboardHide;
@property (nonatomic, strong) UITapGestureRecognizer *tap;


@end

@implementation JFAlertController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];    
//    //这里要执行动画，否则画面没有反应
//    [self show];
//}

- (id)initWithPreferedStyle:(JFAlertStyle)style{
    self = [[self.class alloc] init];
    self.style = style;
//    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    return self;
}

- (void)setNeedTapBgToHide:(BOOL)needTapBgToHide{
    _needTapBgToHide = needTapBgToHide;
    if (_needTapBgToHide) {
        if (_tap == nil){
            _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
            if (_alertBgView) {
                [_alertBgView addGestureRecognizer:_tap];
            }
        }
    }
}

- (void)setupSubViews{

    _notifiKeyboardHide = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    self.operationView = [self viewForOperationView];
    
    if (self.style == JFAlertStyleAlertView) {
        
        //让alertView位于屏幕中心
        self.operationView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        
    } else {
        
        //actionSheet初始状态是在屏幕外边的
        self.operationView.left = 0;
        self.operationView.top = SCREEN_HEIGHT;
    }
    
    /**
     *  背景视图
     */
    self.alertBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.alertBgView.backgroundColor = COLOR_HEX(0x000000, 0.7);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self.alertBgView];
    
    [window addSubview:self];
    
    self.alertBgView.alpha = 0;
    
    [self.alertBgView addSubview:self.operationView];

}

- (UIView *)viewForOperationView{
    return nil;
}

- (void)show{
    
    [self setupSubViews];
    
    //背景视图出现时的动画
    [UIView animateWithDuration:kAnimationTime animations:^{
        self.alertBgView.alpha = 1;
    }];
    
    //根据style判断指定alertView的动画还是actionSheet的动画
    if (self.style == JFAlertStyleAlertView) {
        
        CAKeyframeAnimation * popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = 0.35;
        popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                //[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes = @[@0.0f, @0.1f, @0.75f, @0.8f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         //[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.operationView.layer addAnimation:popAnimation forKey:nil];
        
    } else {
        
        [UIView animateWithDuration:kAnimationTime animations:^{
           
            self.operationView.top = SCREEN_HEIGHT - self.operationView.height;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

- (void)hide{
    
    if (self.style == JFAlertStyleAlertView) {
        //alertView消失的动画
        [UIView animateWithDuration:kAnimationTime animations:^{
            
            self.alertBgView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
            
            if (_notifiKeyboardHide) {
                
                [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
            }

            [self alertControllerDismiss];
        }];
        
    } else {
        //actionSheet消失的动画
        [UIView animateWithDuration:kAnimationTime animations:^{
            
            self.alertBgView.alpha = 0;
            
            self.operationView.top = SCREEN_HEIGHT;
            
        } completion:^(BOOL finished) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
            
            if (_notifiKeyboardHide) {
                
                [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
            }
            [self alertControllerDismiss];
        }];
    }
}

//键盘弹起，页面动画，监听
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 键盘的frame
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    CGFloat keyboardOriginY = SCREEN_HEIGHT - keyboardHeight;
    CGFloat operateMaxY = SCREEN_HEIGHT/2. + self.operationView.bounds.size.height/2. + 16;
    
    if (operateMaxY >= keyboardOriginY) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = self.operationView.frame;
            rect.origin.y = keyboardOriginY - rect.size.height - 16;
            self.operationView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
        _notifiKeyboardHide = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
    }
    else {
        _notifiKeyboardHide = NO;
    }
}

///键盘收起，页面动画，监听
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect rect = self.operationView.frame;
        
        rect.origin.y = (SCREEN_HEIGHT - rect.size.height)/2.;
        
        self.operationView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)alertControllerDismiss{
    
    
    [self.alertBgView removeFromSuperview];
    
    [self.operationView removeFromSuperview];
    
    self.alertBgView = nil;
    
    self.operationView = nil;
    
    [self removeFromSuperview];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
