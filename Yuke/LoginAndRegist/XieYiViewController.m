//
//  XieYiViewController.m
//  test
//
//  Created by 杨云飞 on 2017/7/27.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "XieYiViewController.h"

@interface XieYiViewController ()

@end

@implementation XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.delegate = self;
    self.title = @"注册协议";
    [self setLeftBackNavItem];
    //设置导航栏字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_HEX(0x000000, 1),NSFontAttributeName : FONT_REGULAR(18)};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    [textView resignFirstResponder];
    
    return NO;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //恢复其他界面导航栏颜色
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.navigationController.navigationBar.backgroundColor = WHITECOLOR;
}
@end
