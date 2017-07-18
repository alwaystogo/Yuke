//
//  ModifyPasswordViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyPasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldOld;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNew1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNew2;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@end
