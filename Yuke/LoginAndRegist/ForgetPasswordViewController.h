//
//  ForgetPasswordViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/12.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomMessageCodeView.h"

@interface ForgetPasswordViewController : BaseViewController<CustomMessageCodeViewDelegate>

@property(nonatomic,strong)NSString *yanzhengma;
@end
