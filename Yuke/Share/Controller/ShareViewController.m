//
//  ShareViewController.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/8.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareView.h"

@interface ShareViewController ()

    <
        ShareViewDelegate
    >

@property (nonatomic, strong) UIButton *coverButton ;

@property (nonatomic, strong) ShareView *bottomView ;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.coverButton];
    
    [self.view addSubview:self.bottomView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self show];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - event response

- (void)coverButtonClick:(UIButton *) coverbutton{
    
    [self dismiss];
}

#pragma mark - ShareViewDelegate

-(void)shareView:(ShareView *)shareView didClickActivity:(UIActivity *)activity{
    
    [activity prepareWithActivityItems:@[self.shareTitleString , self.shareDescriptionString , self.shareUrlString , self.shareImage]];
    [self dismiss];
}

#pragma mark - private method

- (void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.coverButton.alpha = 1.0;
        
        self.bottomView.top = SCREEN_HEIGHT - kShareViewControllerBottomViewHeight * BiLi_SCREENHEIGHT_NORMAL - self.bottomSafeMargin;
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.coverButton.alpha = 0.0;
        
        self.bottomView.top = SCREEN_HEIGHT ;
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - getter

-(UIButton *)coverButton{
    if (!_coverButton) {
        _coverButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        _coverButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        [_coverButton addTarget:self action:@selector(coverButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _coverButton.alpha = 0.0;
    }
    return _coverButton;
}

-(ShareView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[ShareView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, kShareViewControllerBottomViewHeight * BiLi_SCREENHEIGHT_NORMAL + self.bottomSafeMargin)];
        _bottomView.delegate = self;
    }
    return _bottomView ;
}

@end
