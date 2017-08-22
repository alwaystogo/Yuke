//
//  GuideViewController.m
//  LinkFinance
//
//  Created by yangyunfei on 16/5/27.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "GuideViewController.h"

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建ScrollView
    [self createScrollView];
}

- (void)createScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    //隐藏水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    //加载图片
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sp%d",(i + 1)]];
        imageView.image = image;
        
        if (i == 2) {
            
            //设置可交互
            imageView.userInteractionEnabled = YES;
            
            //第三个页面 立即开启 按钮
            UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            openBtn.frame = CGRectMake(0, 0, 150, 40);
            [openBtn setImage:[UIImage imageNamed:@"open_butten"] forState:UIControlStateNormal];
            [openBtn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:openBtn];
            
            //调整位置
            [openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(imageView.mas_centerX);
                make.bottom.equalTo(imageView.mas_bottom).offset(-(160 * BiLi_SCREENWIDTH));
            }];
        }
        [_scrollView addSubview:imageView];
    }
    
    [self.view addSubview:_scrollView];
}

- (void)openBtnAction:(UIButton *)sender{
    
    //NSLog(@"立即开启");
    
//    [NewUserGuideViewController showGuideForViewController:self completion:^{
//        kAppDelegate.window.rootViewController = kAppDelegate.tabBarController;
//    }];
    
    //设置rootViewController
    kAppDelegate.window.rootViewController = kAppDelegate.tabBarController;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
