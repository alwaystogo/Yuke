//
//  UIViewController+NavigationAction.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/21.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "UIViewController+NavigationAction.h"

#import "LoginViewController.h"


static NSInteger kNavBarImageTag = 911;
static NSInteger kWebPageBarImageTag = 922;
static NSInteger kNewCustomerWebPageBarImageTag = 933;

@implementation UIViewController (NavigationAction)

- (void)goBackToHomePage{
    
    [kAppDelegate.tabBarController setSelectedIndex:2];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goBackToPrevPage{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - topBackground image

- (void)addTopBackgroundImageView{
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120 * BiLi_SCREENHEIGHT_NORMAL)];
    topImageView.image = ImageNamed(@"bg");
    
    [self.view addSubview:topImageView];
}

#pragma mark - navbar left and right button item

// 设置导航条左侧白色返回按钮
- (void)setLeftBackNavItem{
    
    [self setupLeftNavButton:[UIImage imageNamed:kLeftNavImageName] withOffset:0 target:self action:@selector(goBackToPrevPage)];
}

// 设置导航条左侧黑色返回按钮
- (void)setBlackBackLeftNavgationItem{
    [self setupLeftNavButton:[UIImage imageNamed:@"black_fanhui"] withOffset:0 target:self action:@selector(goBackToPrevPage)];
}

// 设置导航条右侧的消息按钮
- (void)setRightMessageButton{
    
}

#pragma mark - 导航条主题设置相关-appearance

// 设置导航条为白色主题,顺便隐藏navbar底部的黑线
- (void)setWhiteNavgationAppearance{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    self.navigationController.navigationBar.backgroundColor = WHITECOLOR;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName : FONT_REGULAR(18)};
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:WHITECOLOR] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}


// 设置导航条为透明主题，顺便隐藏navbar底部的黑线
- (void)setClearNavgationAppearance{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.backgroundColor = CLEARCOLOR;
}

// 恢复导航条显示主题
- (void)revertNavgationAppearanceToBlack{
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.navigationController.navigationBar.backgroundColor = COLOR_HEX(0x666666, 0.5);
}

#pragma mark - 设置全局的nav背景图 (彩色背景)

// 设置全局的nav背景图
- (void)setHomeGlobalNavBackgroundImage{
        
 }

// 将全局的nav背景图移除，恢复为原nav
- (void)revertHomeGloadNavBackgroundImageToBlack{
    
    UIImageView *imageView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:kNavBarImageTag];
    
    // 渐变动画的消失移除
    [UIView animateWithDuration:0.35 animations:^{
        imageView.alpha = 0.0;

    } completion:^(BOOL finished) {
        for (UIView *subView in imageView.subviews) {
            [subView removeFromSuperview];
        }
        
        [imageView removeFromSuperview];
    }];
}

#pragma mark - 设置web页面nav背景 （彩色背景） 带左侧返回按钮和右侧分享按钮

/*
 *  设置web页面nav背景，左侧有返回按钮，右侧有分享按钮
 */
- (void)setWebPageTopBackgroundBarRightButtonWithTarget:(id) target action:(SEL) selector{

    UIImageView *imageView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:kWebPageBarImageTag];
    
    if (imageView == nil)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, NAVBAR_HEIGHT)];
        imageView.image = [UIImage imageNamed:@"bg"];
        imageView.userInteractionEnabled = YES;
        
        [imageView setTag:kWebPageBarImageTag];
        [self.navigationController.navigationBar insertSubview:imageView atIndex:0];
        
//        UIButton *shareButton = [[UIButton alloc] init];
//        [shareButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
//        
//        [shareButton setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
//        shareButton.size = CGSizeMake(44.0, 44.0);
//
//        shareButton.right = SCREEN_WIDTH - 1.3;
//        shareButton.top = 19.5;
        
        UIButton *goBackButton = [[UIButton alloc] init];
        
        [goBackButton addTarget:self action:@selector(goBackToPrevPage) forControlEvents:UIControlEventTouchUpInside];
        [goBackButton setImage:[UIImage imageNamed:kLeftNavImageName]  forState:UIControlStateNormal];

        CGFloat goBackLeftMargin = is5_5Inch ? 0 : - 0.5;
        CGFloat goBackTopMargin = is5_5Inch ? 19.7 : 19.5;
        
        goBackButton.left = goBackLeftMargin;
        goBackButton.top = goBackTopMargin;
        
        goBackButton.size = CGSizeMake(44.0, 44.0);
        
//        [imageView addSubview:shareButton];
        [imageView addSubview:goBackButton];
    }
}

/*
 *  移除web页面的nav背景
 */
- (void)revertWebPageTopBackgroundBar{
    
    UIImageView *imageView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:kWebPageBarImageTag];
    
    // 渐变动画的消失移除
    [UIView animateWithDuration:0.35 animations:^{
        imageView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        for (UIView *subView in imageView.subviews) {
            [subView removeFromSuperview];
        }
        
        [imageView removeFromSuperview];
    }];
}


#pragma mark - 设置web页面新手分享的nav背景 （彩色背景） 带左侧返回按钮
/*
 *  设置新手活动web页面nav背景，左侧有返回按钮
 */
- (void)setNewCustomerWebPageTopBar{
    
    UIImageView *imageView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:kNewCustomerWebPageBarImageTag];
    
    if (imageView == nil)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, NAVBAR_HEIGHT)];
        imageView.image = [UIImage imageWithColor:COLOR_HEX(0x513fc9, 1.0)];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        [imageView setTag:kNewCustomerWebPageBarImageTag];
        [self.navigationController.navigationBar insertSubview:imageView atIndex:0];
        
        UIButton *goBackButton = [[UIButton alloc] init];
        
        [goBackButton addTarget:self action:@selector(goBackToPrevPage) forControlEvents:UIControlEventTouchUpInside];
        [goBackButton setImage:[UIImage imageNamed:kLeftNavImageName]  forState:UIControlStateNormal];
        
        CGFloat goBackLeftMargin = is5_5Inch ? 0 : - 0.5;
        CGFloat goBackTopMargin = is5_5Inch ? 19.7 : 19.5;
        
        goBackButton.left = goBackLeftMargin;
        goBackButton.top = goBackTopMargin;
        
        goBackButton.size = CGSizeMake(44.0, 44.0);
        
        [imageView addSubview:goBackButton];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"活动详情";
        titleLabel.textColor = WHITECOLOR;
        titleLabel.font = [UIFont systemFontOfSize:18.0];
        [titleLabel sizeToFit];
        
        titleLabel.centerY = goBackButton.centerY;
        titleLabel.centerX = imageView.centerX;
        
        [imageView addSubview:titleLabel];
    }
}

/*
 *  移除新手活动web页面的nav背景
 */
- (void)revertNewCustomerWebPageTopBar{
    
    UIImageView *imageView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:kNewCustomerWebPageBarImageTag];
    
    // 渐变动画的消失移除
    [UIView animateWithDuration:0.35 animations:^{
        imageView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        for (UIView *subView in imageView.subviews) {
            [subView removeFromSuperview];
        }
        
        [imageView removeFromSuperview];
    }];
}

@end
