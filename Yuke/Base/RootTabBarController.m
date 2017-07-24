//
//  RootTabBarController.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomepageViewController.h"
#import "WorkspaceViewController.h"
#import "FontlibraryViewController.h"
#import "YuePhotoViewController.h"
#import "MineViewController.h"

#import "LoginViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置选中标题的颜色
    self.tabBar.tintColor = COLOR_HEX(0xff83a9fd, 1);
    
    //创建视图控制器
    [self createSubControllers];
    
    self.selectedIndex = 0;
    
    // 配置全局拦截器
    [self wholeInterceptor];
    
    //网络请求，强制更新处理
    [self wholeMustUpdate];
    
    //监测点击tabbar事件
    self.delegate = self;
}
/**
 *  创建视图控制器
 */
- (void)createSubControllers{
    
    WorkspaceViewController *performanceVC =[[WorkspaceViewController alloc] init];
    BaseNavigationController *questionAndAnswerNav = [[BaseNavigationController alloc] initWithRootViewController:performanceVC];
    performanceVC.navigationItem.title = @"工作区";
    questionAndAnswerNav.tabBarItem.title = @"工作区";
    questionAndAnswerNav.tabBarItem.image = [[UIImage imageNamed:@"yeji"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    questionAndAnswerNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"yeji-hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FontlibraryViewController *fontVC = [[FontlibraryViewController alloc]init];
    BaseNavigationController *discoverNav = [[BaseNavigationController alloc] initWithRootViewController:fontVC];
    fontVC.navigationItem.title = @"字体库";
    discoverNav.tabBarItem.title = @"字体库";
    discoverNav.tabBarItem.image = [[UIImage imageNamed:@"new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"new-hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    HomepageViewController *homePageVC = [[HomepageViewController alloc] init];
    BaseNavigationController *homePageNav = [[BaseNavigationController alloc] initWithRootViewController:homePageVC];
    homePageVC.navigationItem.title = @"首页";
    homePageNav.tabBarItem.title = @"首页";
    homePageNav.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homePageNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"home--hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    YuePhotoViewController *yueVC = [[YuePhotoViewController alloc]init];
    BaseNavigationController *yueNav = [[BaseNavigationController alloc] initWithRootViewController:yueVC];
    yueVC.navigationItem.title = @"约拍摄";
    yueNav.tabBarItem.title = @"约拍摄";
    yueNav.tabBarItem.image = [[UIImage imageNamed:@"new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    yueNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"new-hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    MineViewController *mineVC = [[MineViewController alloc] init];
    BaseNavigationController *mineNav = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    mineVC.navigationItem.title = @"个人中心";
    mineNav.tabBarItem.title = @"个人";
    mineNav.tabBarItem.image = [[UIImage imageNamed:@"geren"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"geren-hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSArray *navArray = @[questionAndAnswerNav, discoverNav, homePageNav, yueNav,mineNav];
    
    self.viewControllers = navArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Netword Interceptor

- (void)wholeInterceptor{
    
}

- (void)wholeMustUpdate{
    
}
//检查是否有版本更新
- (void)checkUpdateVersion{
}

@end
