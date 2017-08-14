//
//  MakeHengViewController.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 2017/8/14.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "MakeHengViewController.h"

@interface MakeHengViewController ()

@property(nonatomic,strong)UIView *topBkView;
@property(nonatomic,strong)UIView *bottomBkView;
@property(nonatomic,strong)UIButton *fanhuiBtn;
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)UIButton *wanchengBtn;

@property(nonatomic,strong)UIButton *beijingBtn;
@property(nonatomic,strong)UIButton *shuiyinBtn;
@property(nonatomic,strong)UIButton *zitiBtn;

@end

@implementation MakeHengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(0, 0, 100, 30);
//    label.backgroundColor = [UIColor grayColor];
//    label.text = @"这是新闻页面";
//    [self.view addSubview:label];
//    
//    UILabel *label2 = [[UILabel alloc] init];
//    label2.frame = CGRectMake(0, 100, 100, 30);
//    label2.backgroundColor = [UIColor grayColor];
//    label2.text = @"这是新闻页面";
//    [self.view addSubview:label2];
    [self creatTopUI];
    [self createBottomUI];
}

- (void)creatTopUI{
    
    _topBkView = [[UIView alloc] init];
    self.topBkView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topBkView];
    [self.topBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(@44);
    }];
    self.fanhuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fanhuiBtn setImage:ImageNamed(kLeftNavImageName) forState:UIControlStateNormal];
    [self.fanhuiBtn addTarget:self action:@selector(fanhuiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topBkView addSubview:self.fanhuiBtn];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = FONT_REGULAR(15);
    [self.editBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topBkView addSubview:self.editBtn];
    
    self.wanchengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wanchengBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.wanchengBtn.titleLabel.font = FONT_REGULAR(15);
    [self.wanchengBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    [self.wanchengBtn addTarget:self action:@selector(wanchengBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topBkView addSubview:self.wanchengBtn];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = COLOR_HEX(0x333333, 1);
    titleLabel.text = @"制作卡片";
    titleLabel.font = FONT_REGULAR(17);
    [self.topBkView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBkView.mas_centerY);
        make.centerX.equalTo(self.topBkView.mas_centerX);
    }];

    [self.fanhuiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topBkView.mas_left).offset(10);
        make.centerY.equalTo(self.topBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.wanchengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topBkView.mas_right).offset(-20);
        make.centerY.equalTo(self.topBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wanchengBtn.mas_left).offset(-15);
        make.centerY.equalTo(self.topBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];

}
- (void)createBottomUI{
    
    _bottomBkView = [[UIView alloc] init];
    self.bottomBkView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomBkView];
    [self.bottomBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@28);
    }];

    self.beijingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.beijingBtn setTitle:@"选择背景" forState:UIControlStateNormal];
    self.beijingBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.beijingBtn.titleLabel.font = FONT_REGULAR(15);
    [self.beijingBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.beijingBtn addTarget:self action:@selector(beijingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBkView addSubview:self.beijingBtn];
    [self.beijingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomBkView.mas_left).offset(0);
        make.centerY.equalTo(self.bottomBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(self.view.height / 3, 28));
    }];
    
    self.zitiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.zitiBtn setTitle:@"更换字体" forState:UIControlStateNormal];
    self.zitiBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.zitiBtn.titleLabel.font = FONT_REGULAR(15);
    [self.zitiBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.zitiBtn addTarget:self action:@selector(zitiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBkView addSubview:self.zitiBtn];
    [self.zitiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomBkView.mas_right).offset(0);
        make.centerY.equalTo(self.bottomBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(self.view.height / 3, 28));
    }];

    self.shuiyinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shuiyinBtn setTitle:@"去掉水印" forState:UIControlStateNormal];
    self.shuiyinBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.shuiyinBtn.titleLabel.font = FONT_REGULAR(15);
    [self.shuiyinBtn setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    [self.shuiyinBtn addTarget:self action:@selector(shuiyinBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBkView addSubview:self.shuiyinBtn];
    [self.shuiyinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beijingBtn.mas_right).offset(0);
        make.right.equalTo(self.zitiBtn.mas_left).offset(0);
        make.top.equalTo(self.bottomBkView.mas_top);
        make.bottom.equalTo(self.bottomBkView.mas_bottom);
    }];


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3f animations:^{
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
        } completion:^(BOOL finished) {
            //隐藏bar
             [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //显示bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)fanhuiBtnAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)editBtnAction{
    
}
- (void)wanchengBtnAction{
    
}

- (void)beijingBtnAction{
    
}
- (void)shuiyinBtnAction{
    
}
- (void)zitiBtnAction{
    
}

@end
