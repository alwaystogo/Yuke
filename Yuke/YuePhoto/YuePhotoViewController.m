//
//  YuePhotoViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "YuePhotoViewController.h"

@interface YuePhotoViewController ()

@end

@implementation YuePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)createUI{
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 30)];
    self.topView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.topView];
    
    //
    self.yueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.yueBtn.frame = CGRectMake(0, 0, 100, 20);
    self.yueBtn.backgroundColor = COLOR_HEX(0xcccccc, 1);
    [self.yueBtn setTitle:@"预约拍摄" forState:UIControlStateNormal];
    [self.yueBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    self.yueBtn.titleLabel.font = FONT_REGULAR(15);
    [self.yueBtn addTarget:self action:@selector(yueBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.yueBtn];
    [self.yueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.topView.mas_left).offset(65 * BiLi_SCREENWIDTH_NORMAL);
        make.centerY.mas_equalTo(self.topView.centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

    self.yiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.yiBtn.frame = CGRectMake(0, 0, 100, 20);
    self.yiBtn.backgroundColor = COLOR_HEX(0xcccccc, 1);
    [self.yiBtn setTitle:@"预约拍摄" forState:UIControlStateNormal];
    [self.yiBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    self.yiBtn.titleLabel.font = FONT_REGULAR(15);
    [self.yiBtn addTarget:self action:@selector(yueBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.yiBtn];
    [self.yiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.topView.mas_left).offset(65 * BiLi_SCREENWIDTH_NORMAL);
        make.centerY.mas_equalTo(self.topView.centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

}

- (void)yueBtnAction{
    
}

- (void)yiBtnAction{
    
}
@end
