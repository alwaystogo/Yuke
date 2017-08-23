//
//  LoginViewController.m
//  LinkFinance
//
//  Created by ZhengYi on 16/5/26.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ForgetPasswordViewController.h"

//距离左右的距离
#define leftAndRightDistance 33

@interface LoginViewController()

@property(nonatomic,strong)UIView *phoneBkView;
@property(nonatomic,strong)UIView *passwordBkView;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *registBtn;
@property(nonatomic,strong)UIButton *forgetPasswordBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"登录";
    //设置导航栏字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_HEX(0xffffff, 1),NSFontAttributeName : FONT_REGULAR(18)};
 
    [self setupLeftNavButton:ImageNamed(@"dengluarrow") target:self action:@selector(goBackToPrevPage)];
    
    [self createUI];
    
    UITapGestureRecognizer *resignFirstResponserTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponserTap:)];
    [self.view addGestureRecognizer:resignFirstResponserTap];
    
    [self setupNotification];
}
- (void)createUI{
    
    UIImageView *bkImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bkImageView.image = ImageNamed(@"bg");
    [self.view addSubview:bkImageView];
    
    self.phoneBkView = [[UIView alloc] init];
    self.phoneBkView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.phoneBkView.layer.cornerRadius = 5;
    [self.view addSubview:self.phoneBkView];
    [self.phoneBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
        make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
        make.top.mas_equalTo(self.view.mas_top).offset(180 * BiLi_SCREENHEIGHT_NORMAL);
        make.height.mas_equalTo(35);
    }];
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"phone")];
    [self.phoneBkView addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneBkView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.phoneBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    self.phoneTextField = [[UITextField alloc] init];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"输入手机号" attributes:
                                      @{NSForegroundColorAttributeName:COLOR_HEX(0xffffff, 1),NSFontAttributeName : FONT_REGULAR(14)}];
    self.phoneTextField.attributedPlaceholder = attrString;
    [self.phoneBkView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.phoneBkView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.phoneBkView.mas_centerY);
    }];
    
    
    self.passwordBkView = [[UIView alloc] init];
    self.passwordBkView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.passwordBkView.layer.cornerRadius = 5;
    [self.view addSubview:self.passwordBkView];
    [self.passwordBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
        make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
        make.top.mas_equalTo(self.phoneBkView.mas_bottom).offset(30);
        make.height.mas_equalTo(35);
    }];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"lock")];
    [self.passwordBkView addSubview:passwordImageView];
    [passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passwordBkView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.passwordBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    self.passwordTextField = [[UITextField alloc] init];
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"输入密码" attributes:
                                      @{NSForegroundColorAttributeName:COLOR_HEX(0xffffff, 1),NSFontAttributeName : FONT_REGULAR(14)}];
    self.passwordTextField.attributedPlaceholder = attrString2;
    [self.passwordBkView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.passwordBkView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.passwordBkView.mas_centerY);
    }];

    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = FONT_REGULAR(18);
    [self.loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.passwordBkView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view.centerX).offset(0);
        make.size.mas_equalTo(CGSizeMake(250, 44));
    }];

    self.forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPasswordBtn setTitleColor:COLOR_HEX(0xffffff, 1) forState:UIControlStateNormal];
    self.forgetPasswordBtn.titleLabel.font = FONT_REGULAR(16);
    [self.forgetPasswordBtn addTarget:self action:@selector(forgetPasswordBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPasswordBtn];
    [self.forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.left).offset(leftAndRightDistance);
        make.size.mas_equalTo(CGSizeMake(75, 40));
    }];

    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [self.registBtn setTitleColor:COLOR_HEX(0xffffff, 1) forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = FONT_REGULAR(16);
    [self.registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.right).offset(-leftAndRightDistance);
        make.size.mas_equalTo(CGSizeMake(75, 40));
    }];

    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTextField.secureTextEntry  = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //设置导航栏透明(给导航栏设置一个空图片)
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏透明后下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    //设置背景色为透明
    self.navigationController.navigationBar.backgroundColor = CLEARCOLOR;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //恢复其他界面导航栏颜色
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.navigationController.navigationBar.backgroundColor = WHITECOLOR;
}

//检查是否已经登录
+ (BOOL)checkLogin:(MyBasicBlock)block{
    
    BOOL userHasLogin = !(kUserMoudle.user_Id == nil);
    
    /*通过单例中的userid是否为空来判断用户是否已经登录*/
    if (userHasLogin) {
        
        NSLog(@"用户已经登录");
        block(YES);
        return YES;
    }
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *loginNav = [[UINavigationController alloc]
                                        initWithRootViewController:loginVC];
    loginVC.block = block;
    [kCurNavController presentViewController:loginNav animated:YES completion:^{
        
    }];
   
    return NO;
}

//登录成功之后调的方法
- (void)loginDidSuccess{
    
    [kCurNavController dismissViewControllerAnimated:YES completion:nil];
    
    if (self.block) {
        self.block(@(YES));
    }
}

+ (BOOL)isLogin{
    
    return !(kUserMoudle.user_Id == nil);
}
//返回按钮
- (void)goBackToPrevPage{
    
    [super goBackToPrevPage];
    
    if (self.block) {
        
        self.block(NO);
    }
    
}

- (void)loginBtnAction{
    
    //登录
    NSString *phoneString = self.phoneTextField.text;
    
    NSString *pwdString = self.passwordTextField.text;
    
    if (![phoneString isMobile]) {
        
        [JFTools showTipOnHUD:@"请输入正确格式的手机号码"];
        
        return;
    }
    
    if ([pwdString isEmptyString]) {
        [JFTools showTipOnHUD:@"请输入密码"];
        
        return;
    }
    
    [self.view endEditing:YES];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters safeSetObject:phoneString forKey:@"mobile"];
    [parameters safeSetObject:pwdString forKey:@"password"];
    
     [JFTools showLoadingHUD];
    [kJFClient login:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"login:%@",responseObject);
        [JFTools showSuccessHUDWithTip:@"登录成功"];
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        //保存返回来的数据
        kUserMoudle.user_mobile = phoneString;
        
        [kUserMoudle saveDataToUserMoudle:[dic objectForKeySafe:@"user"]];
        
        [self performSelector:@selector(loginDidSuccess) withObject:nil afterDelay:1.5];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];

}
- (void)forgetPasswordBtnAction{
    
    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc] init];
    [kCurNavController pushViewController:forgetVC animated:YES];
}
- (void)registBtnAction{
    
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [kCurNavController pushViewController:registVC animated:YES];
}

-(void)resignFirstResponserTap:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

#pragma mark - CustomLoginTextFieldDelegate

- (void)textFieldShouldReturn:(UITextField *) customTextField{
    
    [self.view endEditing:YES];
}

#pragma mark - notification

// 键盘弹出
- (void)keyboardShow:(NSNotification *) note{
    
    [UIView animateWithDuration:0.25 animations:^{
        
//        [self.phoneBkView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
//            make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
//            make.top.mas_equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT + 1);
//            make.height.mas_equalTo(35);
//        }];
    }];
    
}

// 键盘收起
- (void)keyboardHidden:(NSNotification *) note{
    
    [UIView animateWithDuration:0.25 animations:^{
        
//        [self.phoneBkView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
//            make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
//            make.top.mas_equalTo(self.view.mas_top).offset(200 * BiLi_SCREENHEIGHT_NORMAL);
//            make.height.mas_equalTo(35);
//        }];
    }];
}
- (void)setupNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
