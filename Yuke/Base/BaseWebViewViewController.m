//
//  BaseWebViewViewController.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/3/30.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "BaseWebViewViewController.h"

@interface BaseWebViewViewController ()

    <
        WKNavigationDelegate,
        WKUIDelegate
    >

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation BaseWebViewViewController

- (instancetype)initWithURL:(NSString *)url{
    
    self = [super init];
    
    if (self) {
        
        self.str_URL = url;
    }
    
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setLeftBackNavItem];
    [self setupRightNavButton2:ImageNamed(@"fenxiang") target:self action:@selector(fenxiangAction)];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self loadRequest];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self.progressView setProgress:0.15 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    
    self.progressView.hidden = NO;
    
    [self.view bringSubviewToFront:self.progressView];
    
    //[self.webView.scrollView hiddenReloadView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    [self loadProgress];
    
    if (error.code == -1009) {
        //[self.webView.scrollView showReloadView];
    }
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败%@",error);
}

#pragma mark - WKUIDelegate     WKWebView将js的alert confirm 和 prompt函数的弹出事件做了拦截，需要手动控制js的弹出与否

-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    [JFTools showTipOnHUD:message];
    completionHandler();
}

-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    [JFTools showTipOnHUD:message];
    completionHandler(YES);
}

-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    [JFTools showTipOnHUD:defaultText];
    
    completionHandler(defaultText);
}

#pragma mark - UnnormalViewDelegate

// 重新加载本页
- (void)emptyDataReload:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self loadRequest];
}

#pragma mark - private method

- (void)loadProgress{
    [self.progressView setProgress:1.0 animated:YES];
    
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.progressView setAlpha:0.0f];
                     }
                     completion:^(BOOL finished) {
                         [self.progressView setProgress:0.0f animated:NO];
                     }];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.webView) {
        
        [self.progressView setAlpha:1.0f];
        
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        
        [self.progressView setProgress:self.webView.estimatedProgress
                              animated:animated];
        
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.5f
                                  delay:0.5f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progressView setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0.0f animated:NO];
                             }];
        }
    }
}

#pragma mark - private method

- (void)loadRequest{
    //防止url由于转码问题转换成nil
    
    _str_URL = [_str_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url =[NSURL URLWithString:_str_URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15.0];
    
    [self.webView loadRequest:request];
}

#pragma mark - getter

-(WKWebView *)webView{
    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds ];
        
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        //_webView.scrollView.unnormalViewDelegate = self;
    }
    return _webView;
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 2)];
        
        [_progressView setTrackTintColor:[UIColor clearColor]];
        _progressView.progressTintColor = COLOR_RGB(179.0, 0.0, 53.0, 1.0);
    }
    return _progressView;
}

- (void)fenxiangAction{
    //这里加到异步线程，否则ShareViewController的viewWillAppear会延迟调用
    WeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        //分享
        ShareViewController *shareViewController = [[ShareViewController alloc] init];
        shareViewController.shareUrlString = weakSelf.str_URL;
        shareViewController.shareTitleString = @"娱客";
        shareViewController.shareDescriptionString = @"点击查看内容";
//        UIImageView *imageView = [[UIImageView alloc] init];
//        [imageView getImageWithUrl:@"aaa" placeholderImage:[UIImage imageNamed:SharePic]];
//        shareViewController.shareImage = imageView.image;
        shareViewController.shareImage = ImageNamed(@"share111");
        
        [self presentViewController:shareViewController animated:YES completion:nil];
    });

}
@end
