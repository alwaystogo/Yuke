//
//  AdvertiseViewController.m
//  zhibo
//
//  Created by 周焕强 on 16/5/17.
//  Copyright © 2016年 zhq. All rights reserved.
//

#import "AdvertiseViewController.h"

@interface AdvertiseViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    [self setLeftBackNavItem];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor whiteColor];
    if (!self.adUrl) {
        self.adUrl = @"";
    }
    
    [self request];
    
    [self.view addSubview:_webView];
}

- (void)setAdUrl:(NSString *)adUrl
{
    _adUrl = adUrl;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]];
    [_webView loadRequest:request];
}

- (void)request{
    
    [kJFClient haibao:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic = responseObject[0];
        NSString *url = [dic objectForKey:@"url"];
        self.adUrl = url;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
