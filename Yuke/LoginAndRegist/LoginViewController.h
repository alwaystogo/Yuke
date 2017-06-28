//
//  LoginViewController.h
//  LinkFinance
//
//  Created by ZhengYi on 16/5/26.
//  Copyright © 2016年 JF. All rights reserved.
//

typedef void(^MyBasicBlock) (id result);

@interface LoginViewController : BaseViewController

@property (nonatomic, copy) MyBasicBlock block;
@property (nonatomic, strong) UIViewController *fromViewController;

+ (BOOL)checkLogin:(MyBasicBlock)block;

+ (BOOL)isLogin;//判断是否登录

@end
