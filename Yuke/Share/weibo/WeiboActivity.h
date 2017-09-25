//
//  WeiboActivity.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/7/5.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

@interface WeiboActivity : UIActivity<WBMediaTransferProtocol,WBHttpRequestDelegate>
@property (nonatomic, strong) WBMessageObject *messageObject;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

- (void)shareImageWithImage:(UIImage *)image;

- (void)shareVideoWithVideoUrl:(NSURL *)videoUrl;
@end
