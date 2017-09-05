//
//  VipViewController.m
//  Yuke
//
//  Created by 杨云飞 on 2017/9/4.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "VipViewController.h"

@interface VipViewController ()

@end

@implementation VipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setLeftBackNavItem];
    self.title = @"开通会员";
    self.picImageVie.layer.cornerRadius = 70;
    self.huiyuanBtn.layer.cornerRadius = 10;
}
- (IBAction)huiyuanBtnAction:(id)sender {
    
    self.bkView = [[UIView alloc] initWithFrame:self.view.frame];
    self.bkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.bkView addGestureRecognizer:tap];
     [kAppDelegate.window addSubview:self.bkView];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.layer.cornerRadius = 5;
    centerView.backgroundColor = WHITECOLOR;
    [self.bkView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView.mas_centerX);
        make.centerY.equalTo(self.bkView.mas_centerY);
        //make.size.mas_equalTo(CGSizeMake(250, 300));
        make.height.equalTo(@250);
        make.width.equalTo(@200);
    }];
    UIView*topView = [[UIView alloc] init];
    topView.backgroundColor = COLOR_HEX(0xffa632, 1);
    [centerView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView.mas_left);
        make.right.equalTo(centerView.mas_right);
        make.top.equalTo(centerView.mas_top);
        make.height.equalTo(@40);
    }];
    UILabel *kaiLabel = [[UILabel alloc] init];
    kaiLabel.text = @"开通会员";
    kaiLabel.font = FONT_REGULAR(13);
    [topView addSubview:kaiLabel];
    [kaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    self.bkView1 = [[UIView alloc] init];
    self.bkView1.layer.cornerRadius = 5;
    self.bkView1.layer.borderColor = COLOR_HEX(0x666666, 1).CGColor;
    self.bkView1.layer.borderWidth = 1;
    [self.bkView addSubview:self.bkView1];
    [self.bkView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView.mas_left).offset(30);
        make.top.equalTo(topView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"1个月";
    [self.bkView1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView1.mas_centerX);
        make.top.equalTo(self.bkView1.mas_top).offset(8);
    }];
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"40元";
    [self.bkView1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView1.mas_centerX);
        make.top.equalTo(label1.mas_bottom).offset(4);
    }];

}

- (void)tapAction{
    [self.bkView removeFromSuperview];
}
@end
