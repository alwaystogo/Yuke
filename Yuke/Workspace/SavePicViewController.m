//
//  SavePicAndVideoViewController.m
//  Yuke
//
//  Created by 杨云飞 on 2017/7/30.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "SavePicViewController.h"
#import "WeiboActivity.h"
#import "FriendActivity.h"
#import "WeixinActivity.h"

@interface SavePicViewController ()

@end

@implementation SavePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"保存与分享";
    [self setLeftBackNavItem];
    [self setupRightNavButton:@"首页" withTextFont:FONT_REGULAR(15) withTextColor:COLOR_HEX(0xffa632, 1) target:self action:@selector(rightNavBtnAction)];
    
    self.weixinImageView.userInteractionEnabled = YES;
    self.friendImageView.userInteractionEnabled = YES;
    self.weiboImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weixinAction)];
    [self.weixinImageView addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friendAction)];
    [self.friendImageView addGestureRecognizer:tap2];

    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weiboAction)];
    [self.weiboImageView addGestureRecognizer:tap3];

    self.picImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.picImageView.image = _picImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBackToPrevPage{
    [kAppDelegate.tabBarController setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)rightNavBtnAction{
    
    [self goBackToHomePage];
}

- (void)weixinAction{
    
    NSLog(@"点击了weixin");
    WeixinActivity *weiA = [[WeixinActivity alloc] init];
    [weiA shareImageWithImage:self.picImage];
}
- (void)friendAction{
    
    NSLog(@"点击了pengyouquan");
    FriendActivity *friendA = [[FriendActivity alloc] init];
    [friendA shareImageWithImage:self.picImage];
}
- (void)weiboAction{
    
    NSLog(@"点击了weibo");
    WeiboActivity *weiboA = [[WeiboActivity alloc] init];
    [weiboA shareImageWithImage:self.picImage];
}
- (void)setPicImage:(UIImage *)picImage{
    _picImage = picImage;
}
@end
