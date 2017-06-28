//
//  LimitTextField.m
//  LinkFinance
//
//  Created by ZhengYi on 16/7/19.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "LimitTextField.h"

@interface LimitTextField ()<UITextFieldDelegate>

@end

@implementation LimitTextField

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LimitTextFieldDidReceiveTextChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
        self.delegate = self;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LimitTextFieldDidReceiveTextChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    self.delegate = self;
}

- (void)LimitTextFieldDidReceiveTextChangeNotification:(NSNotification *)notification{
    
    UITextRange *markedRange = [self markedTextRange];
    
    UITextPosition *position = [self positionFromPosition:markedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (position && markedRange) {
        return;
    }
    if (self.ignorePunctation) {
        if (![JFTools checkIsWorldIncludeChinese:self.text]) {
            //NSLog(@"不符合 TEXT : %@",self.text);
            if (self.text.length > 0) {
                self.text = [self.text substringToIndex:self.text.length-1];
            }
            return;
        }
    }
    
    NSInteger existLen = self.text.length;
    
    if (existLen > self.limitNum) {
        self.text = [self.text substringToIndex:self.limitNum];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    @autoreleasepool {
        
        UITextRange *markedRange = [textField markedTextRange];
        
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:markedRange.start offset:0];
        
        if (markedRange && position) {
            NSInteger startOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:markedRange.start];
            NSInteger endOffset = [textField offsetFromPosition:textField.beginningOfDocument toPosition:markedRange.end];
            NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
            
            if (offsetRange.location < self.limitNum) {
                
                return YES;
                
            } else {
                
                return NO;
            }
        }
    }
    return YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
