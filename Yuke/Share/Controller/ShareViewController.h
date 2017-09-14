//
//  ShareViewController.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/8.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "BaseAlertViewController.h"

@interface ShareViewController : BaseAlertViewController

@property (nonatomic, copy) NSString *shareUrlString ;          // 分享的链接

@property (nonatomic, copy) NSString *shareTitleString ;        // 分享的标题
@property (nonatomic, copy) NSString *shareDescriptionString;   // 分享的描述

@property (nonatomic, strong) UIImage *shareImage ;             // 分享的图片

@end
