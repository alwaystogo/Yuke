//
//  RegistViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/12.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "RegistViewController.h"

//距离左右的距离
#define leftAndRightDistance 33

@interface RegistViewController ()

@property(nonatomic,strong)UIView *phoneBkView;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UIView *passwordBkView;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UIView *checkPasswordBkView;
@property(nonatomic,strong)UITextField *checkPasswordTextField;

@property(nonatomic,strong)UIView *yanzhengmaBkView;
@property(nonatomic,strong)UITextField *yanzhengmaField;
@property(nonatomic,strong)CustomMessageCodeView *getMessageView;

@property(nonatomic,strong)UIButton *registBtn;

@property(nonatomic,strong)UIButton *xieyiBtn;
@property(nonatomic,strong)UILabel *xieyiLabel;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    //设置导航栏字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_HEX(0xffffff, 1),NSFontAttributeName : FONT_REGULAR(18)};
    [self setLeftBackNavItem];
    
    [self createUI];

    UITapGestureRecognizer *resignFirstResponserTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponserTap:)];
    [self.view addGestureRecognizer:resignFirstResponserTap];
    [self setupNotification];
}

- (void)createUI{
    
    UIImageView *bkImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bkImageView.image = [UIImage imageWithColor:[UIColor blackColor]];
    [self.view addSubview:bkImageView];
    
    self.phoneBkView = [[UIView alloc] init];
    self.phoneBkView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.phoneBkView.layer.cornerRadius = 5;
    [self.view addSubview:self.phoneBkView];
    [self.phoneBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
        make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
        make.top.mas_equalTo(self.view.mas_top).offset(150 * BiLi_SCREENHEIGHT_NORMAL);
        make.height.mas_equalTo(35);
    }];
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor blueColor]]];
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
    
    self.yanzhengmaBkView = [[UIView alloc] init];
    self.yanzhengmaBkView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.yanzhengmaBkView.layer.cornerRadius = 5;
    [self.view addSubview:self.yanzhengmaBkView];
    [self.yanzhengmaBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
        make.top.mas_equalTo(self.phoneBkView.mas_bottom).offset(30);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(130 * BiLi_SCREENWIDTH_NORMAL);
    }];
    self.yanzhengmaField = [[UITextField alloc] init];
    [self.yanzhengmaBkView addSubview:self.yanzhengmaField];
    [self.yanzhengmaField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yanzhengmaBkView.mas_left).offset(0);
        make.right.mas_equalTo(self.yanzhengmaBkView.mas_right).offset(0);
        make.centerY.mas_equalTo(self.yanzhengmaBkView.mas_centerY);
    }];
    
    self.getMessageView = [[CustomMessageCodeView alloc] init];
    self.getMessageView.delegate = self;
    self.getMessageView.backgroundColor = COLOR_HEX(0xffa632, 1.0);
    self.getMessageView.titleColor = COLOR_HEX(0x333333, 1);
    self.getMessageView.timerLableColor = COLOR_HEX(0x333333, 1);
    [self.view addSubview:self.getMessageView];
    [self.getMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
        make.top.mas_equalTo(self.phoneBkView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(125, 35));
    }];
    
    self.passwordBkView = [[UIView alloc] init];
    self.passwordBkView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.passwordBkView.layer.cornerRadius = 5;
    [self.view addSubview:self.passwordBkView];
    [self.passwordBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
        make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
        make.top.mas_equalTo(self.yanzhengmaBkView.mas_bottom).offset(30);
        make.height.mas_equalTo(35);
    }];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor blueColor]]];
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
    
    self.checkPasswordBkView = [[UIView alloc] init];
    self.checkPasswordBkView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.checkPasswordBkView.layer.cornerRadius = 5;
    [self.view addSubview:self.checkPasswordBkView];
    [self.checkPasswordBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
        make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
        make.top.mas_equalTo(self.passwordBkView.mas_bottom).offset(30);
        make.height.mas_equalTo(35);
    }];
    UIImageView *checkPasswordImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor blueColor]]];
    [self.checkPasswordBkView addSubview:checkPasswordImageView];
    [checkPasswordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkPasswordBkView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.checkPasswordBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    self.checkPasswordTextField = [[UITextField alloc] init];
    NSAttributedString *attrString5 = [[NSAttributedString alloc] initWithString:@"确认密码" attributes:
                                       @{NSForegroundColorAttributeName:COLOR_HEX(0xffffff, 1),NSFontAttributeName : FONT_REGULAR(14)}];
    self.checkPasswordTextField.attributedPlaceholder = attrString5;
    [self.checkPasswordBkView addSubview:self.checkPasswordTextField];
    [self.checkPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(checkPasswordImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.checkPasswordBkView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.checkPasswordBkView.mas_centerY);
    }];

    
    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registBtn.layer.cornerRadius = 20;
    self.registBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = FONT_REGULAR(18);
    [self.registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.checkPasswordTextField.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view.centerX).offset(0);
        make.size.mas_equalTo(CGSizeMake(250, 44));
    }];
    
    self.xieyiLabel = [[UILabel alloc] init];
    self.xieyiLabel.text = @"已阅读并同意用户协议隐私条款";
    self.xieyiLabel.font = FONT_REGULAR(14);
    self.xieyiLabel.textColor = COLOR_HEX(0xffffff, 1);
    self.xieyiLabel.textAlignment = NSTextAlignmentLeft;
    self.xieyiLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickXieyiAction)];
    [self.xieyiLabel addGestureRecognizer:tapGR];
    [self.view addSubview:self.xieyiLabel];
    [self.xieyiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.registBtn.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(10);
    }];
    
    self.xieyiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.xieyiBtn setImage:[UIImage imageNamed:@"yuandian-weixuanzhong"] forState:UIControlStateNormal];
    [self.xieyiBtn setImage:[UIImage imageNamed:@"yuandian"] forState:UIControlStateSelected];
    [self.xieyiBtn setBackgroundColor:[UIColor redColor]];
    [self.xieyiBtn addTarget:self action:@selector(chooseXieyiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.xieyiBtn];
    [self.xieyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.xieyiLabel.mas_centerY);
        make.right.mas_equalTo(self.xieyiLabel.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.yanzhengmaField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTextField.secureTextEntry  = YES;
    self.checkPasswordTextField.secureTextEntry = YES;
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

- (void)registBtnAction{

    NSString *phoneString = self.phoneTextField.text;
    NSString *code = self.yanzhengmaField.text;
    NSString *passwordString = self.passwordTextField.text;
    NSString *confirmPwdString = self.checkPasswordTextField.text;
    
    if (![phoneString isMobile]) {
        
        [JFTools showTipOnHUD:@"请输入正确格式的手机号码"];
        return;
    }
    
    if ([code isEmptyString]) {
        
        [JFTools showTipOnHUD:@"请先获取验证码并输入"];
        return;
    }
    
    if (![passwordString isEqualToString:confirmPwdString]) {
        [JFTools showTipOnHUD:@"两次密码不一致"];
        return;
    }
    
    if (!self.xieyiBtn.selected) {
        
        [JFTools showTipOnHUD:@"请阅读并同意服务协议"];
        return;
    }
    
    [self.view endEditing:YES];
    [JFTools showLoadingHUD];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters safeSetObject:phoneString forKey:@"mobile"];
    [parameters safeSetObject:passwordString forKey:@"password"];
    
    WeakSelf;
    [kJFClient regist:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"login:%@",responseObject);
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
    
}
//发送验证码
#pragma mark - CustomLoginTextFieldDelegate
- (void)customMessageCodeViewClickMessageCodeButton:(CustomMessageCodeView *) customMessageCodeView{
    
//    NSString *phoneString = self.phoneTextField.text;
//    if (![phoneString isMobile]) {
//        
//        [JFTools showTipOnHUD:@"请输入正确格式的手机号码"];
//        return;
//    }
    
    [customMessageCodeView beginTimer];
    
}

- (void)chooseXieyiBtnAction:(UIButton *)btn{
    
    btn.selected = !btn.selected;
}
- (void)clickXieyiAction{
    
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
        
                [self.phoneBkView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
                    make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
                    make.top.mas_equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT + 1);
                    make.height.mas_equalTo(35);
                }];
    }];
    
}

// 键盘收起
- (void)keyboardHidden:(NSNotification *) note{
    
    [UIView animateWithDuration:0.25 animations:^{
        
                [self.phoneBkView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.view.mas_left).offset(leftAndRightDistance);
                    make.right.mas_equalTo(self.view.mas_right).offset(-leftAndRightDistance);
                    make.top.mas_equalTo(self.view.mas_top).offset(150 * BiLi_SCREENHEIGHT_NORMAL);
                    make.height.mas_equalTo(35);
                }];
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
