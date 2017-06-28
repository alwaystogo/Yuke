//
//  BaseWebViewViewController.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/3/30.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface BaseWebViewViewController : BaseViewController

@property(nonatomic, strong) NSString *str_URL;

@property (nonatomic, strong) WKWebView *webView ;

- (instancetype)initWithURL:(NSString *)url;

@end
