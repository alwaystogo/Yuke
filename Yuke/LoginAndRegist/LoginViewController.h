//
//  LoginViewController.h
//  LinkFinance
//
//  Created by ZhengYi on 16/5/26.
//  Copyright © 2016年 JF. All rights reserved.
//

typedef void(^MyBasicBlock) (BOOL result);

@interface LoginViewController : BaseViewController

@property (nonatomic, copy) MyBasicBlock block;

+ (BOOL)checkLogin:(MyBasicBlock)block;

+ (BOOL)isLogin;//判断是否登录

@end
