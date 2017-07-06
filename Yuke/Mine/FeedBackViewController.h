//
//  FeedBackViewController.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/21.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "BaseViewController.h"

@interface FeedBackViewController : BaseViewController<LimitTextViewDelegate,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet LimitTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *zishuLabel;
@property (weak, nonatomic) IBOutlet UITextField *photoTextField;

@end
