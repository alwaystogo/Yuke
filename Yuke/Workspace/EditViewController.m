//
//  EditViewController.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "EditViewController.h"
#import "MakeShuViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (instancetype)initWith:(NSInteger)mobanNum withImageArray:(NSArray *)imageArray{
    self = [super init];
    if (self) {
        self.mobanNum = mobanNum;
        self.imageArray = imageArray;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加个人资料";
    
    [self setLeftBackNavItem];

    [self setupRightNavButton:@"下一步" withTextFont:FONT_REGULAR(15) withTextColor:COLOR_HEX(0x333333, 1) target:self action:@selector(rightNavBtnAction)];
        
    UITapGestureRecognizer *tapHangye = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hangyeTapAction)];
    self.hangyeLabel.userInteractionEnabled = YES;
    [self.hangyeLabel addGestureRecognizer:tapHangye];
    UITapGestureRecognizer *tapYears = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yearsTapAction)];
    self.yearsLabel.userInteractionEnabled = YES;
    [self.yearsLabel addGestureRecognizer:tapYears];
    UITapGestureRecognizer *tapAddress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTapAction)];
    self.addressLabel.userInteractionEnabled = YES;
    [self.addressLabel addGestureRecognizer:tapAddress];
    UITapGestureRecognizer *tapXiema = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xieMaTapAction)];
    self.xieMaLabel.userInteractionEnabled = YES;
    [self.xieMaLabel addGestureRecognizer:tapXiema];
    
    self.nickNameTextField.delegate = self;
    self.nickNameTextField.limitNum = 10;//最多输入10个字符
    self.jigouTextField.delegate = self;
    
    //初始化数据
    [self requestInitData];
    
    self.shengaoArray = [NSMutableArray array];
    for (NSInteger i = 20; i < 213; i++) {
        [self.shengaoArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    self.tizhongArray = [NSMutableArray array];
    for (NSInteger i = 10; i < 100; i++) {
        [self.tizhongArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    self.xieMaArray = [NSMutableArray array];
    for (NSInteger i = 30; i < 46; i++) {
        [self.xieMaArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }

}

- (YYFPickViewThree *)addressPickView{
    if (!_addressPickView) {
        
        _addressPickView = [[YYFPickViewThree alloc] init];
    }
    return _addressPickView;
}
- (void)hangyeTapAction{
    
    [self.jigouTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
    
    __weak typeof(self) weakSelf = self;
    YYFPickView *pickView = [[YYFPickView alloc] initWithFrame:self.view.bounds withData:self.shengaoArray];
    pickView.determineBtnBlock = ^(NSInteger row, NSString* value){
        
        weakSelf.hangyeLabel.text = value;
    };
    
    [self.view addSubview:pickView];
}
- (void)yearsTapAction{
    
    [self.jigouTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
    
    __weak typeof(self) weakSelf = self;
    YYFPickView *pickView = [[YYFPickView alloc] initWithFrame:self.view.bounds withData:self.tizhongArray];
    pickView.determineBtnBlock = ^(NSInteger row, NSString* value){
        
        weakSelf.yearsLabel.text = value;
    };
    
    [self.view addSubview:pickView];
}
- (void)addressTapAction{
    
    [self.jigouTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
    
    [self addressPickView];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 40; i < 120; i++) {
        [tempArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    __weak typeof(self) weakSelf = self;
    self.addressPickView = [[YYFPickViewThree alloc] initWithFrame:self.view.bounds withOneArray:tempArray withTwoArray:tempArray withThreeArray:tempArray];
    _addressPickView.determineBtnBlock = ^(NSInteger oneId, NSInteger twoId, NSInteger threeId, NSString *oneName, NSString *twoName, NSString *threeName) {
        
        weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@-%@-%@",oneName,twoName,threeName];
    };
    [self.view addSubview:self.addressPickView];
}

- (void)xieMaTapAction{
    
    [self.jigouTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
    
    __weak typeof(self) weakSelf = self;
    YYFPickView *pickView = [[YYFPickView alloc] initWithFrame:self.view.bounds withData:self.xieMaArray];
    pickView.determineBtnBlock = ^(NSInteger row, NSString* value){
        
        weakSelf.xieMaLabel.text = value;
    };
    
    [self.view addSubview:pickView];
}
- (void)rightNavBtnAction{
    NSLog(@"点击了下一步");
    
    NSString *sanwei = self.addressLabel.text;
    if (sanwei.length < 8) {
        [JFTools showTipOnHUD:@"三围信息不正确，请重新选择"];
        return ;
    }
    NSArray *array = [sanwei componentsSeparatedByString:@"-"];
    NSDictionary *infoDic = @{@"name":self.nickNameTextField.text,@"shengao":self.hangyeLabel.text
                              ,@"tizhong":self.yearsLabel.text
                              ,@"xiongwei":array[0]
                              ,@"yaowei":array[1]
                              ,@"tunwei":array[2]
                              ,@"sanwei":sanwei
                              ,@"xiema":self.xieMaLabel.text
                              ,@"diqu":self.jigouTextField.text};

    MakeShuViewController *vc = [[MakeShuViewController alloc] initWith:self.mobanNum withImageArray:self.imageArray withInfo:infoDic];
    [kCurNavController pushViewController:vc animated:YES];
}

- (void)requestInitData{
    
    [JFTools showLoadingHUD];
    NSDictionary *dic = @{@"user_id":NON(kUserMoudle.user_Id)};
    [kJFClient getUserInfo:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"xinxi- %@",responseObject);
        [JFTools HUDHide];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            self.userInfoDic = responseObject;
            self.nickNameTextField.text = [responseObject objectForKeySafe:@"name"];
            self.hangyeLabel.text = [responseObject objectForKeySafe:@"stature"];
            self.yearsLabel.text = [responseObject objectForKeySafe:@"weight"];
            self.addressLabel.text = [responseObject objectForKeySafe:@"bwh"];
            self.xieMaLabel.text = [responseObject objectForKeySafe:@"shoe_size"];
            self.jigouTextField.text = [responseObject objectForKeySafe:@"address"];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.jigouTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
}
- (IBAction)showBtnAction:(id)sender {
    
}

- (IBAction)noShowBtnAction:(id)sender {
    
}

@end
