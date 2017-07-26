//
//  FeedBackViewController.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/21.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
    self.view.backgroundColor = COLOR_RGB(236, 236, 236, 1);
    [self setLeftBackNavItem];
    [self setupRightNavButton:@"提交" withTextFont:FONT_REGULAR(16) withTextColor:COLOR_HEX(0xffa632, 1) target:self
                       action:@selector(tiJiaoBtnAction)];

    [self createTextView];
    
    self.photoTextField.delegate = self;
}

- (void)createTextView{
    
    _textView.maxLimitNum = 200;//限制输入的字符最多为200个
    _textView.showPlaceHolder = YES;//是否显示placeHolder
    _textView.placeHolderColor = COLOR_HEX(0x999999, 1);
    _textView.placeHolderStr = @"请填写您的问题或意见，我们将尽快改进。";
    
    _textView.layer.cornerRadius = 4;
    _textView.font = SYSTEM_FONT(14);
    _textView.textColor = COLOR_HEX(0x333333, 1);
    _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    _textView.limitDelegate = self;
}
- (void)tiJiaoBtnAction{
    
    if (self.textView.text.length == 0) {
        
        [JFTools showTipOnHUD:@"意见不能为空"];
        return;
    }
    
    NSDictionary *dic = @{@"content":NON(self.textView.text),@"mobile":NON(self.photoTextField.text)};
    [JFTools showLoadingHUD];
    [kJFClient feedback:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"fanjui- %@",responseObject);
        [JFTools HUDHide];
        [JFTools showSuccessHUDWithTip:@"提交成功"];
        [kCurNavController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
    
 }

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.photoTextField resignFirstResponder];
    [self.textView resignFirstResponder];
}

#pragma LimitTextView 代理方法
//还剩余多少个字可以输入
- (void)limitTextView:(LimitTextView *)textView remainCharactorNumDidChanged:(NSInteger)remainNum{
    
    self.zishuLabel.text = [NSString stringWithFormat:@"%ld/%ld",textView.maxLimitNum - remainNum,textView.maxLimitNum];
}
//输入最大字符数的时候调用
-(void)limitTextView:(LimitTextView *)textView textLengthDidReachMaxNUm:(NSInteger)maxNum{
    
    [JFTools showTipOnHUD:@"最多输入200个字"];
}

@end
