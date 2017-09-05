//
//  AppDelegate.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "AdvertiseView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.tabBarController = [[RootTabBarController alloc] init];
    
    //第一次下载APP，需要做的操作
    //显示引导页
    if (![[USERDEFAULTS objectForKey:@"FirstEnter"] isEqualToString:@"1"]) {
        
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        self.window.rootViewController = guideVC;
        
        [USERDEFAULTS setObject:@"1" forKey:@"FirstEnter"];
        [USERDEFAULTS synchronize];
    }else{
        
        self.window.rootViewController = self.tabBarController;
    }

    //这里去请求接口
    
//    AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:self.window.bounds];
//    advertiseView.picUrl = picUrl;
//    [advertiseView show];
    
    //内购时，添加订单观察者
    [[AppPayManager manager] startObserver];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //内购，移除订单观察者
    [[AppPayManager manager] stopObserver];
}


@end
