//
//  ModifyPasswordViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"修改密码";
    [self setLeftBackNavItem];
}

- (IBAction)okBtnAction:(id)sender {
    
    NSString *originalPwdString = self.textFieldOld.text;
    
    NSString *freshPwdString = self.textFieldNew1.text;
    
    NSString *confirmPwdString = self.textFieldNew2.text;
    
    
    if (![freshPwdString isEqualToString:confirmPwdString]) {
        
        [JFTools showTipOnHUD:@"两次密码不一致"];
        
        return;
    }
    
    [JFTools showLoadingHUD];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters safeSetObject:kUserMoudle.user_mobile forKey:@"mobile"];
    [parameters safeSetObject:originalPwdString forKey:@"password"];
    [parameters safeSetObject:freshPwdString forKey:@"new_password"];
    
    
    [kJFClient modifyPassword:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [JFTools HUDHide];
        [JFTools showSuccessHUDWithTip:@"修改成功" dismissHandle:^{
             [kCurNavController popViewControllerAnimated:YES];
        }];
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
