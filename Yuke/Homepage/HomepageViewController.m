//
//  HomepageViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "HomepageViewController.h"
#import "CarouselScrollView.h"

@interface HomepageViewController ()

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"SVN修改");
    
    //轮播控件
    CarouselScrollView *carouselSV = [[CarouselScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) / 320 * 160)];
    carouselSV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:carouselSV];
    
    
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
    
    carouselSV.click = ^(NSInteger index) {
        
        NSLog(@"点击了第%ld",index);
    };
    [carouselSV setCarouseWithArray:dicArray];

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
