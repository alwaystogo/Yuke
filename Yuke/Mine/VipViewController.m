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
        make.height.equalTo(@290);
        make.width.equalTo(@200);
    }];
    UITapGestureRecognizer *tapCen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCenAction)];
    [centerView addGestureRecognizer:tapCen];
    
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
    self.bkView1.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView1.layer.borderWidth = 1;
    [centerView addSubview:self.bkView1];
    [self.bkView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView.mas_left).offset(30);
        make.top.equalTo(topView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action)];
    [self.bkView1 addGestureRecognizer:tap1];

    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = COLOR_HEX(0x333333, 1);
    label1.text = @"1个月";
    label1.font = FONT_REGULAR(15);
    [self.bkView1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView1.mas_centerX);
        make.top.equalTo(self.bkView1.mas_top).offset(8);
    }];
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = COLOR_HEX(0xffa632, 1);
    label2.font = FONT_MEDIUM(18);
    label2.text = @"40元";
    [self.bkView1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView1.mas_centerX);
        make.top.equalTo(label1.mas_bottom).offset(0);
    }];

    self.bkView2 = [[UIView alloc] init];
    self.bkView2.layer.cornerRadius = 5;
    self.bkView2.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView2.layer.borderWidth = 1;
    [centerView addSubview:self.bkView2];
    [self.bkView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerView.mas_right).offset(-30);
        make.top.equalTo(topView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
    [self.bkView2 addGestureRecognizer:tap2];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.textColor = COLOR_HEX(0x333333, 1);
    label3.text = @"3个月";
    label3.font = FONT_REGULAR(15);
    [self.bkView2 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView2.mas_centerX);
        make.top.equalTo(self.bkView2.mas_top).offset(8);
    }];
    UILabel *label4 = [[UILabel alloc] init];
    label4.textColor = COLOR_HEX(0xffa632, 1);
    label4.font = FONT_MEDIUM(18);
    label4.text = @"113元";
    [self.bkView2 addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView2.mas_centerX);
        make.top.equalTo(label3.mas_bottom).offset(0);
    }];

    self.bkView3 = [[UIView alloc] init];
    self.bkView3.layer.cornerRadius = 5;
    self.bkView3.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView3.layer.borderWidth = 1;
    [centerView addSubview:self.bkView3];
    [self.bkView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView.mas_left).offset(30);
        make.top.equalTo(self.bkView1.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Action)];
    [self.bkView3 addGestureRecognizer:tap3];
    
    UILabel *label5 = [[UILabel alloc] init];
    label5.textColor = COLOR_HEX(0x333333, 1);
    label5.text = @"6个月";
    label5.font = FONT_REGULAR(15);
    [self.bkView3 addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView3.mas_centerX);
        make.top.equalTo(self.bkView3.mas_top).offset(8);
    }];
    UILabel *label6 = [[UILabel alloc] init];
    label6.textColor = COLOR_HEX(0xffa632, 1);
    label6.font = FONT_MEDIUM(18);
    label6.text = @"218元";
    [self.bkView3 addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView3.mas_centerX);
        make.top.equalTo(label5.mas_bottom).offset(0);
    }];

    self.bkView4 = [[UIView alloc] init];
    self.bkView4.layer.cornerRadius = 5;
    self.bkView4.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView4.layer.borderWidth = 1;
    [centerView addSubview:self.bkView4];
    [self.bkView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerView.mas_right).offset(-30);
        make.top.equalTo(self.bkView2.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4Action)];
    [self.bkView4 addGestureRecognizer:tap4];
    
    UILabel *label7 = [[UILabel alloc] init];
    label7.textColor = COLOR_HEX(0x333333, 1);
    label7.text = @"12个月";
    label7.font = FONT_REGULAR(15);
    [self.bkView4 addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView4.mas_centerX);
        make.top.equalTo(self.bkView4.mas_top).offset(8);
    }];
    UILabel *label8 = [[UILabel alloc] init];
    label8.textColor = COLOR_HEX(0xffa632, 1);
    label8.font = FONT_MEDIUM(18);
    label8.text = @"388元";
    [self.bkView4 addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bkView4.mas_centerX);
        make.top.equalTo(label7.mas_bottom).offset(0);
    }];

    [self tap1Action];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_REGULAR(13);
    btn.backgroundColor = COLOR_HEX(0xffa632, 1);
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerView.mas_centerX);
        make.bottom.equalTo(centerView.mas_bottom).offset(-20);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
}

- (void)tapAction{
    [self.bkView removeFromSuperview];
}
- (void)tapCenAction{
    NSLog(@"点击center");
}
- (void)tap1Action{
    self.selectType = 1;
    self.bkView1.layer.borderColor = COLOR_HEX(0xffa632, 1).CGColor;
    self.bkView2.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView3.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView4.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
}
- (void)tap2Action{
    self.selectType = 2;
    self.bkView2.layer.borderColor = COLOR_HEX(0xffa632, 1).CGColor;
    self.bkView1.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView3.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView4.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
}
- (void)tap3Action{
    self.selectType = 3;
    self.bkView3.layer.borderColor = COLOR_HEX(0xffa632, 1).CGColor;
    self.bkView2.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView1.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView4.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
}
- (void)tap4Action{
    self.selectType = 4;
    self.bkView4.layer.borderColor = COLOR_HEX(0xffa632, 1).CGColor;
    self.bkView2.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView3.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
    self.bkView1.layer.borderColor = COLOR_HEX(0xdddddd, 1).CGColor;
}
- (void)btnAction{
    
    if (self.selectType == 1) {
         [[AppPayManager manager] buyProductsWithId:Product_1yue andQuantity:1 withMyProductsNum:3];
    }
    if (self.selectType == 2) {
        [[AppPayManager manager] buyProductsWithId:Product_3yue andQuantity:1 withMyProductsNum:4];
    }
    if (self.selectType == 3) {
        [[AppPayManager manager] buyProductsWithId:Product_6yue andQuantity:1 withMyProductsNum:5];
    }
    if (self.selectType == 4) {
        [[AppPayManager manager] buyProductsWithId:Product_12yue andQuantity:1 withMyProductsNum:6];
    }
}
@end
