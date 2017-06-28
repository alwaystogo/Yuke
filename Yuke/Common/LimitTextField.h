//
//  LimitTextField.h
//  LinkFinance
//
//  Created by ZhengYi on 16/7/19.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LimitTextField : UITextField

//限制字数
@property(assign, nonatomic) IBInspectable NSInteger limitNum;

//是否忽略标点符号
@property(assign, nonatomic) IBInspectable BOOL ignorePunctation;


@end
