//
//  CustomMessageCodeView.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/3/2.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "CustomMessageCodeView.h"

static CGFloat kCustomMessageCodeViewDefaultHeight = 35.0;
static CGFloat kCustomMessageCodeViewDefaultWidth = 125.0;

@interface CustomMessageCodeView ()

@property (nonatomic, strong) UIButton *messageCodeButton ;

@property (nonatomic, strong) UILabel *timerLabel ;

@property (nonatomic, strong) NSTimer *timer ;

@property (nonatomic, assign) NSUInteger timeInterval ;

@end

@implementation CustomMessageCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.timeInterval = 60;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kCustomMessageCodeViewDefaultWidth * BiLi_SCREENWIDTH_NORMAL, kCustomMessageCodeViewDefaultHeight * BiLi_SCREENHEIGHT_NORMAL));
        }];
        
        [self addSubview:self.messageCodeButton];
        [self addSubview:self.timerLabel];
        
        [self.messageCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self);
            make.top.equalTo(self);
            make.left.equalTo(self);
        }];
        
        [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self);
            make.top.equalTo(self);
            make.left.equalTo(self);
        }];
        
        self.layer.cornerRadius = 15.0;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.timeInterval = 60;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kCustomMessageCodeViewDefaultWidth * BiLi_SCREENWIDTH_NORMAL, kCustomMessageCodeViewDefaultHeight * BiLi_SCREENHEIGHT_NORMAL));
        }];
        
        [self addSubview:self.messageCodeButton];
        [self addSubview:self.timerLabel];
        
        [self.messageCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self);
            make.top.equalTo(self);
            make.left.equalTo(self);
        }];
        
        [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self);
            make.top.equalTo(self);
            make.left.equalTo(self);
        }];
        
        self.layer.cornerRadius = 15.0;
    }
    return self;
}

#pragma mark - event response

- (void)messageCodeButtonClick:(UIButton *) messageCodeButton{
    
    self.messageCodeButton.enabled = NO;

    if ([self.delegate respondsToSelector:@selector(customMessageCodeViewClickMessageCodeButton:)]) {
        [self.delegate customMessageCodeViewClickMessageCodeButton:self];
    }
    
}

#pragma mark - publci method

// 开始定时器倒数
- (void)beginTimer{
    [self startTimer];
}

- (void)resetButton{
    self.messageCodeButton.enabled = YES;
}

#pragma mark - private method

- (void)startTimer{
    
    if (self.timer) {
        return;
    }
    
    self.messageCodeButton.alpha = 0.0;
    self.timerLabel.text = @"60秒";
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimerLabel) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    
    self.timer = nil;
    self.timeInterval = 60;
}

- (void)updateTimerLabel{
    
    self.messageCodeButton.alpha = 0.0;
    self.timeInterval -= 1;
    self.timerLabel.text = [NSString stringWithFormat:@"%lu秒",(unsigned long)self.timeInterval];
    
    if (self.timeInterval == 0) {
        self.messageCodeButton.enabled = YES;

        [self.messageCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.messageCodeButton.alpha = 1.0;
        self.timerLabel.text = nil;
        [self stopTimer];
    }
}

#pragma mark - setter

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    
    self.layer.borderColor = borderColor.CGColor;
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    
    [self.messageCodeButton setTitleColor:titleColor forState:UIControlStateNormal];
}

-(void)setTimerLableColor:(UIColor *)timerLableColor{
    _timerLableColor = timerLableColor;
    
    self.timerLabel.textColor = timerLableColor;
}

#pragma mark - getter

-(UIButton *)messageCodeButton{
    if (!_messageCodeButton) {
        _messageCodeButton = [[UIButton alloc] init];
        
        [_messageCodeButton setTitle:@"获取短信验证" forState:UIControlStateNormal];
        [_messageCodeButton setTitleColor:COLOR_HEX(0x333333, 1) forState:UIControlStateNormal];
    
        [_messageCodeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        _messageCodeButton.titleLabel.font = FONT_REGULAR(14);
        
        [_messageCodeButton addTarget:self action:@selector(messageCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageCodeButton;
}

-(UILabel *)timerLabel{
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc] init];
        
        _timerLabel.textColor = COLOR_HEX(0x333333, 1.0);
        _timerLabel.font = FONT_REGULAR(14);
        _timerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timerLabel;
}


@end
