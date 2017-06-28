//
//  BaseNavigationController.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置状态栏为白色
    self.navigationBar.barStyle = UIBarStyleBlack;
    //导航栏背景颜色
    self.navigationBar.backgroundColor = COLOR_HEX(0x666666, 0.5);
    //设置导航栏字体
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_HEX(0xffffff, 1),NSFontAttributeName : FONT_REGULAR(18)};

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
