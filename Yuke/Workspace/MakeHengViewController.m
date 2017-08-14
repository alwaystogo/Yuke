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

@property(nonatomic,strong)UIView *beijingBkView;
@property(nonatomic,strong)UIView *shuiyinBkView;
@property(nonatomic,strong)UIView *zitiBkView;
@property(nonatomic,strong)UIImageView *beijingImageView1;
@property(nonatomic,strong)UIImageView *beijingImageView2;
@property(nonatomic,strong)UIImageView *shuiyinImageView1;
@property(nonatomic,strong)UIImageView *shuiyinImageView2;

@property(nonatomic,assign)NSInteger selectEditType;
@property(nonatomic,assign)NSInteger selectBeijing;
@property(nonatomic,assign)NSInteger selectShuiyin;
@property(nonatomic,assign)NSInteger selectZiti;

@end

@implementation MakeHengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_HEX(0x999999, 1);
    
    self.selectEditType = 1;
    self.selectBeijing = 1;
    self.selectShuiyin = 1;
    self.selectZiti = 1;
    [self creatTopUI];
    [self createBottomUI];
    [self createxuanzeBeijingUI];
    [self createshuiyinUI];
    [self createzitiUI];
    self.bottomBkView.hidden =YES;
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = YES;
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
- (void)createxuanzeBeijingUI{
    
    self.beijingBkView = [[UIView alloc] init];
    self.beijingBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:self.beijingBkView];
    [self.beijingBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBkView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
     self.beijingImageView1 = [[UIImageView alloc] init];
    self.beijingImageView1.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.beijingBkView addSubview:self.beijingImageView1];
    [self.beijingImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.beijingBkView.mas_centerX).offset(-50);
        make.centerY.equalTo(self.beijingBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(125, 93));
    }];
    self.beijingImageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beijingImageView1Action)];
    [self.beijingImageView1 addGestureRecognizer:tap1];
    
    self.beijingImageView2 = [[UIImageView alloc] init];
    self.beijingImageView2.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.beijingBkView addSubview:self.beijingImageView2];
    [self.beijingImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beijingBkView.mas_centerX).offset(50);
        make.centerY.equalTo(self.beijingBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(125, 93));
    }];
    self.beijingImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beijingImageView2Action)];
    [self.beijingImageView2 addGestureRecognizer:tap2];
}
- (void)createshuiyinUI{
   
    self.shuiyinBkView = [[UIView alloc] init];
    self.shuiyinBkView.backgroundColor = COLOR_HEX(0xdddddd, 1);
    [self.view addSubview:self.shuiyinBkView];
    [self.shuiyinBkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomBkView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
    }];
    
    self.shuiyinImageView1 = [[UIImageView alloc] init];
    self.shuiyinImageView1.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.shuiyinBkView addSubview:self.shuiyinImageView1];
    [self.shuiyinImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shuiyinBkView.mas_centerX).offset(-50);
        make.centerY.equalTo(self.shuiyinBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(125, 93));
    }];
    self.shuiyinImageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shuiyinImageView1Action)];
    [self.shuiyinImageView1 addGestureRecognizer:tap1];
    
    self.shuiyinImageView2 = [[UIImageView alloc] init];
    self.shuiyinImageView2.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.shuiyinBkView addSubview:self.shuiyinImageView2];
    [self.shuiyinImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shuiyinBkView.mas_centerX).offset(50);
        make.centerY.equalTo(self.shuiyinBkView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(125, 93));
    }];
    self.shuiyinImageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shuiyinImageView2Action)];
    [self.shuiyinImageView2 addGestureRecognizer:tap2];
}
- (void)createzitiUI{
    
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
    if (self.bottomBkView.hidden) {
        //如果隐藏了，就显示出来
        self.bottomBkView.hidden = NO;
        [self beijingBtnAction];
        
    }else{
        //隐藏起来
        self.bottomBkView.hidden = YES;
        self.beijingBkView.hidden = YES;
        self.zitiBkView.hidden = YES;
        self.shuiyinBkView.hidden = YES;
    }
}
- (void)wanchengBtnAction{
    
}

- (void)beijingBtnAction{
    self.beijingBkView.hidden = NO;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = YES;
    self.beijingBtn.backgroundColor = COLOR_HEX(0xff9000, 1);
    self.shuiyinBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.zitiBtn.backgroundColor = COLOR_HEX(0xffa632, 1);

    if (self.selectBeijing == 1) {
        self.beijingImageView1.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.beijingImageView1.layer.borderWidth = 2;
        self.beijingImageView2.layer.borderWidth = 0;
    }else{
        self.beijingImageView2.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.beijingImageView2.layer.borderWidth = 2;
        self.beijingImageView1.layer.borderWidth = 0;
    }

}
- (void)shuiyinBtnAction{
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = NO;
    self.zitiBkView.hidden = YES;
    self.beijingBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.shuiyinBtn.backgroundColor = COLOR_HEX(0xff9000, 1);
    self.zitiBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    if (self.selectShuiyin == 1) {
        self.shuiyinImageView1.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.shuiyinImageView1.layer.borderWidth = 2;
        self.shuiyinImageView2.layer.borderWidth = 0;
    }else{
        self.shuiyinImageView2.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
        self.shuiyinImageView2.layer.borderWidth = 2;
        self.shuiyinImageView1.layer.borderWidth = 0;
    }

}
- (void)zitiBtnAction{
    self.beijingBkView.hidden = YES;
    self.shuiyinBkView.hidden = YES;
    self.zitiBkView.hidden = NO;
    self.beijingBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.shuiyinBtn.backgroundColor = COLOR_HEX(0xffa632, 1);
    self.zitiBtn.backgroundColor = COLOR_HEX(0xff9000, 1);
}

- (void)beijingImageView1Action{
    self.selectBeijing = 1;
    [self beijingBtnAction];
}
- (void)beijingImageView2Action{
    self.selectBeijing = 2;
    [self beijingBtnAction];
}
- (void)shuiyinImageView1Action{
    self.selectShuiyin = 1;
    [self shuiyinBtnAction];
}
- (void)shuiyinImageView2Action{
    self.selectShuiyin = 2;
    [self shuiyinBtnAction];
}
@end
