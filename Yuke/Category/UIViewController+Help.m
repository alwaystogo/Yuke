//
//  UIViewController+Help.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "UIViewController+Help.h"

@implementation UIViewController (Help)
#pragma mark - UINavigationItems and UINavigationBar

- (void)setupRightNavButton:(NSString *)title
               withTextFont:(UIFont *)font
              withTextColor:(UIColor *)color
                     target:(id)target
                     action:(SEL)action{
    
    UIBarButtonItem *rightNavBtn = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    //设置颜色
    [rightNavBtn setTintColor:color];
    //设置字体大小
    [rightNavBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightNavBtn;
    
}
- (void)setupRightNavButton:(UIImage*)image
                     target:(id)target
                     action:(SEL)action{
    [self setupRightNavButton:image withOffset:isiOS7 ? -10 : 0 target:target action:action];
}
- (void)setupRightNavButton2:(UIImage*)image
                     target:(id)target
                     action:(SEL)action{
    [self setupRightNavButton2:image withOffset:isiOS7 ? -10 : 0 target:target action:action];
}
- (void)setupRightNavButton2:(UIImage*)image
                 withOffset:(float)offset
                     target:(id)target
                     action:(SEL)action {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 23)];
    [btn setBackgroundImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                   forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}
- (void)setupRightNavButton:(UIImage*)image
                 withOffset:(float)offset
                     target:(id)target
                     action:(SEL)action {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [btn setBackgroundImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                   forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

-(void)setupRightNavButton:(UIImage*)image
                withOffset:(float)offset
                    target:(id)target
                    action:(SEL)action
    imageWithRenderingMode:(UIImageRenderingMode)imageModel {
    
    [self setupRightNavButton:[image imageWithRenderingMode:imageModel] withOffset:offset target:target action:action];
}

- (void)setupLeftNavButton:(UIImage*)image
                    target:(id)target
                    action:(SEL)action {
    [self setupLeftNavButton:image withOffset:isiOS7 ? -10 : 0 target:target action:action];
}

- (void)setupLeftNavButton:(UIImage*)image
                withOffset:(float)offset
                    target:(id)target
                    action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [btn setBackgroundImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                   forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem* negativeSpacer =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                  target:nil
                                                  action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setupLeftNavButton:(UIImage*)image
                withOffset:(float)offset
                    target:(id)target
                    action:(SEL)action
    imageWithRenderingMode:(UIImageRenderingMode)imageModel {
    [self setupLeftNavButton:[image imageWithRenderingMode:imageModel] withOffset:offset target:target action:action];
}

- (void)setupLeftNavItemsWithTarget:(id)target
                            actions:(NSArray *)actions
                        withImgArry:(NSArray*)imageArray
                  effectByTintColor:(BOOL)effect{
    
    CGFloat offset = isiOS7 ? -10 : 0;
    
    NSMutableArray* items = [NSMutableArray array];
    
    NSArray* images = imageArray;
    
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        
        NSString * actionString = actions[idx];
        SEL action = NSSelectorFromString(actionString);
        UIBarButtonItem* item;
        //        UIImage* image = [UIImage imageNamed:obj];
        UIImage *image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:obj]];
        
        if (!effect) {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } else {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (idx == 3) {
            btn.frame = CGRectMake(0, 0, image.size.width + 10, image.size.height + 10);
        } else {
            btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
        
        [btn setImage:image
             forState:UIControlStateNormal];
        btn.tag = idx + 1000;
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem* negativeSpacer =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    
    self.navigationItem.leftBarButtonItems = items;
}

- (void)setupBackItem:(NSString *)imageName action:(SEL)action{
    UIImage *image =  [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName]];
    //    UIImage *image = [UIImage imageNamed:imageName];
    [self setupLeftNavButton:image target:self action:action];
}

- (void)setupRightNavItemsWithTarget:(id)target
                             actions:(NSArray *)actions
                         withImgArry:(NSArray*)imageArray
                   effectByTintColor:(BOOL)effect{
    CGFloat offset = isiOS7 ? -10 : 0;
    
    NSMutableArray* items = [NSMutableArray array];
    
    NSArray* images = imageArray;
    
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        
        NSString * actionString = actions[idx];
        SEL action = NSSelectorFromString(actionString);
        UIBarButtonItem* item;
        //        UIImage* image = [UIImage imageNamed:obj];
        UIImage *image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:obj]];
        
        if (!effect) {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } else {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (idx == 3) {
            btn.frame = CGRectMake(0, 0, image.size.width + 10, image.size.height + 10);
        } else {
            btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
        
        [btn setImage:image
             forState:UIControlStateNormal];
        btn.tag = idx + 1000;
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem* negativeSpacer =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    
    self.navigationItem.rightBarButtonItems = items;
}

- (void)customeNavTitle:(NSString*)title Font:(UIFont*)font Color:(UIColor*)color{
    if (self.navigationController != nil) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        titleLabel.backgroundColor = CLEARCOLOR;
        titleLabel.text = title;
        titleLabel.font = font;
        titleLabel.textColor = color;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = titleLabel;
    }
}

+ (UIViewController*)currentViewController {
    // Find best view controller
    UIViewController* viewController = kAppDelegate.tabBarController;
    return [UIViewController findBestViewController:viewController];
}
//从tabbarViewController开始寻找，找出当前显示在屏幕上的ViewController
+ (UIViewController*)findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController &&
        ![vc.presentedViewController isKindOfClass:[UIAlertController class]]) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController* svc = (UINavigationController*)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController* svc = (UITabBarController*)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        // Unknown view controller type, return last child view controller
        //NSLog(@"========  currentVCClass  ======== %@", NSStringFromClass([vc class]));
        return vc;
    }
}

-(CGFloat)bottomSafeMargin{
    
    if (SCREEN_HEIGHT == 812) {
        return 34;
    }else{
        return 0;
    }
}

@end
