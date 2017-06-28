//
//  BaseAlertViewController.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/27.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "BaseAlertViewController.h"

@interface BaseAlertViewController ()

@end

@implementation BaseAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIModalTransitionStyle           取消系统present动画，方便弹出控制器的自定义动画控制

-(UIModalTransitionStyle)modalTransitionStyle
{
    return UIModalTransitionStyleCrossDissolve;
}

#pragma mark - UIModalTransitionStyle

-(UIModalPresentationStyle)modalPresentationStyle
{
    return UIModalPresentationCustom;
}

@end
