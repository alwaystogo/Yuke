//
//  HomepageViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "HomepageViewController.h"

#define fourWidth 27
@interface HomepageViewController ()

@property(nonatomic,assign)CGFloat label1MaxY;
@property(nonatomic,assign)CGFloat picImageViewMaxY;

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"SVN修改");
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];

}

- (void)createUI{
    
    self.bkScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - 20)];
    self.bkScrollView.backgroundColor = [UIColor redColor];
    self.bkScrollView.contentSize =CGSizeMake(SCREEN_WIDTH, 1000);
    //self.bkScrollView.showsVerticalScrollIndicator = NO;
    //self.bkScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bkScrollView];
    
    [self createLunBo];
    [self createFour];
    [self createInfoShow];
    [self createHot];
}
-(void)createFour{
    
    CGFloat jianju = (SCREEN_WIDTH - 66 - fourWidth * 4) / 3;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(33, CGRectGetMaxY(self.carouselSV.frame) + 15, fourWidth, fourWidth)];
    imageView1.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame) + jianju, CGRectGetMaxY(self.carouselSV.frame) + 15, fourWidth, fourWidth)];
    imageView2.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame) + jianju, CGRectGetMaxY(self.carouselSV.frame) + 15, fourWidth, fourWidth)];
    imageView3.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView3.frame) + jianju, CGRectGetMaxY(self.carouselSV.frame) + 15, fourWidth, fourWidth)];
    imageView4.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView4];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label1.centerX = imageView1.centerX;
    label1.text = @"每日组讯";
    label1.font = FONT_REGULAR(12);
    label1.textColor = COLOR_HEX(0x333333, 1);
    label1.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label1];
    
    self.label1MaxY = CGRectGetMaxY(label1.frame);
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label2.centerX = imageView2.centerX;
    label2.text = @"艺人专访";
    label2.font = FONT_REGULAR(12);
    label2.textColor = COLOR_HEX(0x333333, 1);
    label2.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label3.centerX = imageView3.centerX;
    label3.text = @"最新活动";
    label3.font = FONT_REGULAR(12);
    label3.textColor = COLOR_HEX(0x333333, 1);
    label3.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label3];

    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), 60,30)];
    label4.centerX = imageView4.centerX;
    label4.text = @"商务合作";
    label4.font = FONT_REGULAR(12);
    label4.textColor = COLOR_HEX(0x333333, 1);
    label4.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label4];
}

- (void)createInfoShow{
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.label1MaxY + 15, 17, 17)];
    imageView1.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame)+10, CGRectGetMaxY(imageView1.frame)- 10, 50,14)];
    //label1.backgroundColor = [UIColor greenColor];
    label1.bottom = imageView1.bottom;
    label1.text = @"资料预览";
    label1.font = FONT_REGULAR(13);
    label1.textColor = COLOR_HEX(0x333333, 1);
    label1.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label1];
    
    CGFloat imageWidth = (SCREEN_WIDTH - 30)/2;
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView1.frame) + 3, imageWidth, 272/2 * (imageWidth/ (345/2)))];
    imageView2.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView2];
    
    self.picImageViewMaxY = CGRectGetMaxY(imageView2.frame);
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame) + 10, CGRectGetMaxY(imageView1.frame) + 3, imageWidth, 272/2 * (imageWidth/ (345/2)))];
    imageView3.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView3];
}

- (void)createHot{
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.picImageViewMaxY + 11, 17, 17)];
    imageView1.image = [UIImage imageWithColor:[UIColor grayColor]];
    [self.bkScrollView addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame)+10, CGRectGetMaxY(imageView1.frame)- 10, 50,14)];
    //label1.backgroundColor = [UIColor greenColor];
    label1.bottom = imageView1.bottom;
    label1.text = @"热门专访";
    label1.font = FONT_REGULAR(13);
    label1.textColor = COLOR_HEX(0x333333, 1);
    label1.textAlignment = NSTextAlignmentCenter;
    [self.bkScrollView addSubview:label1];

}
- (void)createLunBo{
    
    //轮播控件
    _carouselSV = [[CarouselScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) / 320 * 160)];
    _carouselSV.backgroundColor = [UIColor grayColor];
    [self.bkScrollView addSubview:_carouselSV];
    
    
    NSArray *dicArray = @[
                          @{
                              @"carouseUrl" : @"http://pic.58pic.com/58pic/17/27/03/07B58PIC3zg_1024.jpg"
                              },
                          @{
                              @"carouseUrl" : @"http://pic.58pic.com/58pic/13/56/99/88f58PICuBh_1024.jpg"
                              },
                          @{
                              @"carouseUrl" : @"http://pic.58pic.com/58pic/17/77/53/558d11422a923_1024.png"
                              },
                          @{
                              @"carouseUrl" : @"http://pic.58pic.com/58pic/13/18/14/87m58PICVvM_1024.jpg"
                              },
                          @{
                              @"carouseUrl" : @"http://pic.qiantucdn.com/58pic/17/79/77/41N58PICaMu_1024.jpg"
                              }
                          ];
    
    _carouselSV.click = ^(NSInteger index) {
        
        NSLog(@"点击了第%ld",index);
    };
    [_carouselSV setCarouseWithArray:dicArray];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}


@end
