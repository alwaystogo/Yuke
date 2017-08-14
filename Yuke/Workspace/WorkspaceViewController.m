//
//  WorkspaceViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "WorkspaceViewController.h"
#import "AppConfig.h"
#import "YanyuanCardsListViewController.h"
#import "MoteCardsListViewController.h"
#import "VieoMakerViewController.h"
#import "SavePicAndVideoViewController.h"
#import "SavePicViewController.h"
#import "MakeHengViewController.h"

@interface WorkspaceViewController ()

@end

@implementation WorkspaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
}

- (void)createUI{
    
    self.bkScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - NAVBAR_HEIGHT)];
    self.bkScrollView.backgroundColor = [UIColor whiteColor];
    self.bkScrollView.contentSize =CGSizeMake(SCREEN_WIDTH, 1000);
    self.bkScrollView.showsVerticalScrollIndicator = NO;
    self.bkScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bkScrollView];

    [self createLunBo];
    [self createThreeUI];
}
- (void)createLunBo{
    
    //轮播控件
    _carouselSV = [[CarouselScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) / 375 * 170)];
    _carouselSV.backgroundColor = [UIColor grayColor];
    [self.bkScrollView addSubview:_carouselSV];
    
    
    NSArray *dicArray = @[
                          //                          @{
                          //                              @"carouseUrl" : @"http://pic.58pic.com/58pic/17/27/03/07B58PIC3zg_1024.jpg"
                          //                              }
                          ];
    
    _carouselSV.click = ^(NSInteger index) {
        
        NSLog(@"点击了第%ld",index);
    };
    [_carouselSV setCarouseWithArray:dicArray];
}

- (void)createThreeUI{
    
    CGFloat width = (SCREEN_WIDTH - 25) / 2.0;
    CGFloat height = width;
    //左上
    self.yanyuanBkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.carouselSV.frame) + 10, width, height)];
    self.yanyuanBkImageView.userInteractionEnabled = YES;
    self.yanyuanBkImageView.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:self.yanyuanBkImageView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yanyuanTapAction)];
    [self.yanyuanBkImageView addGestureRecognizer:tap1];
    //左下
    self.shipinBkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.yanyuanBkImageView.frame) + 10, width, height)];
    self.shipinBkImageView.userInteractionEnabled = YES;
    self.shipinBkImageView.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:self.shipinBkImageView];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shipinTapAction)];
    [self.shipinBkImageView addGestureRecognizer:tap2];
    //右
    self.moteBkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.yanyuanBkImageView.frame) + 5, CGRectGetMaxY(self.carouselSV.frame) + 10, width, height *2 + 10)];
    self.moteBkImageView.userInteractionEnabled= YES;
    self.moteBkImageView.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:self.moteBkImageView];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moteTapAction)];
    [self.moteBkImageView addGestureRecognizer:tap3];
    
    self.bkScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.moteBkImageView.frame) + 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)yanyuanTapAction{
    YanyuanCardsListViewController *newVC = [[YanyuanCardsListViewController alloc] init];
    newVC.hidesBottomBarWhenPushed = YES;
    [kCurNavController pushViewController:newVC animated:YES];

}

- (void)shipinTapAction{
//    
//    VieoMakerViewController *newVC = [[VieoMakerViewController alloc] init];
//    newVC.hidesBottomBarWhenPushed = YES;
//    [kCurNavController pushViewController:newVC animated:YES];
//    SavePicViewController *vc = [[SavePicViewController alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [kCurNavController pushViewController:vc animated:YES];

    MakeHengViewController *vc = [[MakeHengViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];

}

- (void)moteTapAction{
    MoteCardsListViewController *newVC = [[MoteCardsListViewController alloc] init];
    newVC.hidesBottomBarWhenPushed = YES;
    [kCurNavController pushViewController:newVC animated:YES];

}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    VieoMakerViewController *newVC = [[VieoMakerViewController alloc] init];
//    newVC.hidesBottomBarWhenPushed = YES;
//    [kCurNavController pushViewController:newVC animated:YES];
//}
@end
