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
    
    
}

@end
