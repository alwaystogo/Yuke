//
//  LimitTextView.m
//  LinkFinance
//
//  Created by ZhengYi on 16/6/3.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "LimitTextView.h"

#define default_max 120

@interface LimitTextView ()<UITextViewDelegate>

@property (nonatomic, assign) BOOL hasAlertMaxNum;

@end

@implementation LimitTextView

- (void)addDelegate:(id)object{
    self.limitDelegate = object;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    if ([_placeHolderColor isEqual:placeHolderColor]) {
        return;
    }
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay];
}

- (void)setPlaceHolderStr:(NSString *)placeHolderStr{
    if ([_placeHolderStr isEqualToString:placeHolderStr]) {
        return;
    }
    _placeHolderStr = placeHolderStr;
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initParams];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initParams];
}

- (void)initParams{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveTextChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
    self.maxLimitNum = default_max;
    self.maxNumAlertOnce = YES;
    self.hasAlertMaxNum = NO;
    self.delegate = self;
}

- (void)dealloc{
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)didBeginEditingNotification:(NSNotification *)notification{
    
}

- (void)didReceiveTextChangeNotification:(NSNotification*)notification{
    //[self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_showPlaceHolder && self.placeHolderStr && self.text.length == 0) {
        CGRect placeHolderRect = CGRectMake(8.0f,
                                            7.0f,
                                            rect.size.width - 16,
                                            rect.size.height);
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_0) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paragraphStyle.alignment = self.textAlignment;
            paragraphStyle.lineSpacing = 5.0;
        
            [self.placeHolderStr drawInRect:placeHolderRect
                          withAttributes:@{ NSFontAttributeName : self.font,
                                            NSForegroundColorAttributeName : self.placeHolderColor,
                                            NSParagraphStyleAttributeName : paragraphStyle,
                                            NSFontAttributeName : [UIFont systemFontOfSize:15]}];
        }
        else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [self.placeHolderStr drawInRect:placeHolderRect
                                withFont:self.font
                           lineBreakMode:NSLineBreakByTruncatingTail
                               alignment:self.textAlignment];
#pragma clang diagnostic pop
        }
    
    }
}

- (void)setMaxLimitNum:(NSInteger)maxLimitNum{
    if (maxLimitNum <= 0) {
        _maxLimitNum = default_max;
    } else {
        _maxLimitNum = maxLimitNum;
    }
}

- (void)textViewDidChange:(UITextView *)textView{

    [self setNeedsDisplay];
    @autoreleasepool {
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
        
        //如果在变化中是高亮部分在变，就不要计算字符了
        if (selectedRange && pos) {
            return;
        }
        
        NSString  *nsTextContent = textView.text;
        NSInteger existTextNum = nsTextContent.length;
        
        if (existTextNum >= self.maxLimitNum) {
            [self showMaxLimitAlert];
        }
        
        if (existTextNum > self.maxLimitNum)
        {
            //截取到最大位置的字符
            NSString *s = [nsTextContent substringToIndex:self.maxLimitNum];
            
            [textView setText:s];
        }
        if ([self.limitDelegate respondsToSelector:@selector(limitTextView:remainCharactorNumDidChanged:)]) {
            [self.limitDelegate limitTextView:self remainCharactorNumDidChanged:MAX(0, self.maxLimitNum - existTextNum)];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self setNeedsDisplay];
    
    @autoreleasepool {
        
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return YES;
        }
        
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
        //获取高亮部分内容
        //NSString * selectedtext = [textView textInRange:selectedRange];
        
        //如果有高亮且当前字数开始位置小于最大限制时允许输入
        if (selectedRange && pos) {
            NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
            NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
            NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
            
            if (offsetRange.location < self.maxLimitNum) {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
        
        NSInteger caninputlen = self.maxLimitNum - comcatstr.length;
        if (caninputlen >= 0)
        {
            return YES;
        }
        else
        {
            [self showMaxLimitAlert];
            NSInteger len = text.length + caninputlen;
            //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
            NSRange rg = {0,MAX(len,0)};
            
            if (rg.length > 0)
            {
                NSString *s = @"";
                //判断是否只普通的字符或asc码(对于中文和表情返回NO)
                BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
                if (asc) {
                    s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
                }
                else
                {
                    __block NSInteger idx = 0;
                    __block NSString  *trimString = @"";//截取出的字串
                    //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                    [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                             options:NSStringEnumerationByComposedCharacterSequences
                                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                              if (idx >= rg.length) {
                                                  *stop = YES; //取出所需要就break，提高效率
                                                  return ;
                                              }
                                              
                                              trimString = [trimString stringByAppendingString:substring];
                                              idx++;
                                          }];
                    
                    s = trimString;
                }
                //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
                [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
                //既然是超出部分截取了，哪一定是最大限制了。
                if ([self.limitDelegate respondsToSelector:@selector(limitTextView:remainCharactorNumDidChanged:)]) {
                    [self.limitDelegate limitTextView:self remainCharactorNumDidChanged:0];
                }
            }
            return NO;
        }
    }
}

- (void)showMaxLimitAlert{
    if ((self.hasAlertMaxNum == NO && self.maxNumAlertOnce == YES) ||
        self.maxNumAlertOnce == NO) {
        if ([self.limitDelegate respondsToSelector:@selector(limitTextView:textLengthDidReachMaxNUm:)]) {
            [self.limitDelegate limitTextView:self textLengthDidReachMaxNUm:self.maxLimitNum];
        }
        self.hasAlertMaxNum = YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.limitDelegate respondsToSelector:@selector(limitTextViewDidBeginEditing:)]) {
        [self.limitDelegate limitTextViewDidBeginEditing:self];
    }
}

@end
