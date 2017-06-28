//
//  PXAlertView+Customization.m
//  PXAlertViewDemo
//
//  Created by Michal Zygar on 21.10.2013.
//  Copyright (c) 2013 panaxiom. All rights reserved.
//

#import "PXAlertView+Customization.h"
#import <objc/runtime.h>

void* const kCancelBGKey = (void* const) & kCancelBGKey;
void* const kNonSelectedCancelBGKey = (void* const) & kNonSelectedCancelBGKey;
void* const kOtherBGKey = (void* const) & kOtherBGKey;
void* const kNonSelectedOtherBGKey = (void* const) & kNonSelectedOtherBGKey;
void* const kAllBGKey = (void* const) & kAllBGKey;
void* const kNonSelectedAllBGKey = (void* const) & kNonSelectedAllBGKey;

@interface PXAlertView ()

@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIView *alertView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) UIButton *otherButton;
@property (nonatomic) NSArray *buttons;

@end

@implementation PXAlertView (Customization)

- (void)useDefaultIOS7Style {
    [self setTapToDismissEnabled:NO];
    UIColor *ios7BlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    [self setAllButtonsTextColor:ios7BlueColor];
    [self setTitleColor:[UIColor blackColor]];
    [self setMessageColor:[UIColor blackColor]];
    UIColor *defaultBackgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    [self setAllButtonsBackgroundColor:defaultBackgroundColor];
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)setCornerRadius:(CGFloat)radius {
    self.alertView.layer.cornerRadius = radius;
}

- (void)setCenter:(CGPoint)center {
    self.alertView.center = center;
}

- (void)setWindowTintColor:(UIColor*)color {
    self.backgroundView.backgroundColor = color;
}

- (void)setBackgroundColor:(UIColor *)color
{
    self.alertView.backgroundColor = color;
}

- (void)setTitleColor:(UIColor *)color
{
    self.titleLabel.textColor = color;
}

- (void)setTitleFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

- (void)setMessageColor:(UIColor *)color
{
    self.messageLabel.textColor = color;
}

- (void)setMessageFont:(UIFont *)font
{
    self.messageLabel.font = font;
}

#pragma mark -
#pragma mark Buttons Customization
#pragma mark Buttons Background Colors
- (void)setCustomBackgroundColorForButton:(id)sender
{
    if (sender == self.cancelButton && [self cancelButtonBackgroundColor]) {
        self.cancelButton.backgroundColor = [self cancelButtonBackgroundColor];
    } else if (sender == self.otherButton && [self otherButtonBackgroundColor]) {
        self.otherButton.backgroundColor = [self otherButtonBackgroundColor];
    } else if ([self allButtonsBackgroundColor]) {
        [sender setBackgroundColor:[self allButtonsBackgroundColor]];
    } else {
        [sender setBackgroundColor:[UIColor colorWithRed:94/255.0 green:196/255.0 blue:221/255.0 alpha:1]];
    }
}

- (void)setNonSelectedCustomBackgroundColorForButton:(id)sender {
    if (sender == self.cancelButton && [self nonSelectedCancelButtonBackgroundColor]) {
        self.cancelButton.backgroundColor = [self nonSelectedCancelButtonBackgroundColor];
    } else if (sender == self.otherButton && [self nonSelectedOtherButtonBackgroundColor]) {
        self.otherButton.backgroundColor = [self nonSelectedOtherButtonBackgroundColor];
    } else if ([self nonSelectedAllButtonsBackgroundColor]) {
        [sender setBackgroundColor:[self nonSelectedAllButtonsBackgroundColor]];
    } else {
        [sender setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)setCancelButtonBackgroundColor:(UIColor*)color {
    objc_setAssociatedObject(self, kCancelBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.cancelButton addTarget:self
                          action:@selector(setCustomBackgroundColorForButton:)
                forControlEvents:UIControlEventTouchDown];
    [self.cancelButton addTarget:self
                          action:@selector(setCustomBackgroundColorForButton:)
                forControlEvents:UIControlEventTouchDragEnter];
    [self.cancelButton addTarget:self
                          action:@selector(setNonSelectedCustomBackgroundColorForButton:)
                forControlEvents:UIControlEventTouchDragExit];
}

- (UIColor*)cancelButtonBackgroundColor {
    return objc_getAssociatedObject(self, kCancelBGKey);
}

- (void)setCancelButtonNonSelectedBackgroundColor:(UIColor*)color {
    objc_setAssociatedObject(self, kNonSelectedCancelBGKey, color,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.cancelButton.backgroundColor = color;
}

- (UIColor*)nonSelectedCancelButtonBackgroundColor {
    return objc_getAssociatedObject(self, kNonSelectedCancelBGKey);
}

- (void)setAllButtonsBackgroundColor:(UIColor*)color {
    objc_setAssociatedObject(self, kOtherBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kCancelBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kAllBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (UIButton* button in self.buttons) {
        [button addTarget:self
                      action:@selector(setCustomBackgroundColorForButton:)
            forControlEvents:UIControlEventTouchDown];
        [button addTarget:self
                      action:@selector(setCustomBackgroundColorForButton:)
            forControlEvents:UIControlEventTouchDragEnter];
        [button addTarget:self
                      action:@selector(setNonSelectedCustomBackgroundColorForButton:)
            forControlEvents:UIControlEventTouchDragExit];
    }
}

- (UIColor *)allButtonsBackgroundColor
{
    return objc_getAssociatedObject(self, kAllBGKey);
}

- (void)setAllButtonsNonSelectedBackgroundColor:(UIColor*)color {
    objc_setAssociatedObject(self, kNonSelectedOtherBGKey, color,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kNonSelectedCancelBGKey, color,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kNonSelectedAllBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (UIButton* button in self.buttons) {
        button.backgroundColor = color;
    }
}

- (UIColor*)nonSelectedAllButtonsBackgroundColor {
    return objc_getAssociatedObject(self, kNonSelectedAllBGKey);
}

- (void)setOtherButtonBackgroundColor:(UIColor*)color {
    objc_setAssociatedObject(self, kOtherBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.otherButton addTarget:self
                         action:@selector(setCustomBackgroundColorForButton:)
               forControlEvents:UIControlEventTouchDown];
    [self.otherButton addTarget:self
                         action:@selector(setCustomBackgroundColorForButton:)
               forControlEvents:UIControlEventTouchDragEnter];
    [self.otherButton addTarget:self
                         action:@selector(setNonSelectedCustomBackgroundColorForButton:)
               forControlEvents:UIControlEventTouchDragExit];
}

- (UIColor*)otherButtonBackgroundColor {
    return objc_getAssociatedObject(self, kOtherBGKey);
}

- (void)setOtherButtonNonSelectedBackgroundColor:(UIColor*)color {
    objc_setAssociatedObject(self, kNonSelectedOtherBGKey, color,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.otherButton.backgroundColor = color;
}

- (UIColor*)nonSelectedOtherButtonBackgroundColor {
    return objc_getAssociatedObject(self, kNonSelectedOtherBGKey);
}

#pragma mark Buttons Text Colors
- (void)setCancelButtonTextColor:(UIColor*)color {
    [self.cancelButton setTitleColor:color forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:color forState:UIControlStateHighlighted];
}

- (void)setAllButtonsTextColor:(UIColor *)color
{
    for (UIButton *button in self.buttons) {
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateHighlighted];
    }
}

- (void)setOtherButtonTextColor:(UIColor *)color
{
    [self.otherButton setTitleColor:color forState:UIControlStateNormal];
    [self.otherButton setTitleColor:color forState:UIControlStateHighlighted];
}

//additions

- (void)setAlertViewSize:(CGSize)size{
    CGRect tmpFrame = self.alertView.frame;
    tmpFrame.size = size;
    self.alertView.frame = tmpFrame;
    [self resizeAlertContent];
}
- (void)useLoginAndRegisterAlertStyle{
    if (self.buttons.count == 1) {
        UIButton *button = [self.buttons firstObject];
        CGRect newFrame = CGRectMake(self.alertView.frame.size.width / 4,
                                     button.frame.origin.y + 10,
                                     self.alertView.frame.size.width / 3 * 1.5,
                                     button.frame.size.height - 10);
        button.frame  = newFrame;
    }
    for (UIButton *button in self.buttons) {
        button.layer.cornerRadius = button.frame.size.height/2;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [[UIColor redColor] CGColor];
        [button setTitleColor:COLOR_HEX(0xff4444, 1.0) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [button setTitleColor:COLOR_HEX(0xff4444, 1.0) forState:UIControlStateHighlighted];
        [button removeTarget:self
                      action:@selector(setBackgroundColorForButton:)
            forControlEvents:UIControlEventTouchDown];
    }
    for (CALayer *layer in self.alertView.layer.sublayers) {
        layer.backgroundColor = [[UIColor clearColor] CGColor];
    }
    self.verticalLine.backgroundColor = [[UIColor clearColor] CGColor];
    [self setTitleColor:COLOR_HEX(0x333333, 1.0)];
    [self setTitleFont:[UIFont systemFontOfSize:17.0]];
    [self setMessageColor:COLOR_HEX(0x666666, 1.0)];
    [self setMessageFont:[UIFont systemFontOfSize:15.0]];
    [self setBackgroundColor:[UIColor whiteColor]];
    CGRect newAlertFrame = CGRectMake(self.alertView.frame.origin.x,
                                      self.alertView.frame.origin.y,
                                      self.alertView.frame.size.width,
                                      self.alertView.frame.size.height + 15);
    self.alertView.frame = newAlertFrame;
}

//重写了原有类的方法，为了改变alert中button周围的线的颜色
- (CALayer*)lineLayer {
    CALayer* lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [COLOR_HEX(0xececec, 1) CGColor];
    return lineLayer;
}

- (void)useCommonStyle{
    [self setTitleColor:COLOR_HEX(0x333333, 1.0)];
    [self setBackgroundColor:COLOR_HEX(0xffffff, 1)];
    [self setMessageColor:COLOR_HEX(0x333333, 1.0)];
    [self setCornerRadius:6.0];
    [self setAllButtonsBackgroundColor:COLOR_HEX(0xffffff, 1.0)];
    [self setCancelButtonTextColor:COLOR_HEX(0xff4444, 1.0)];
    [self setOtherButtonTextColor:COLOR_HEX(0x333333, 1.0)];
}

- (void)resizeAlertContent{
    NSInteger btnCount = self.buttons.count;
    UIButton *tempButton;
    for (UIButton *button in self.buttons) {
        NSInteger index = [self.buttons indexOfObject:button];
        CGFloat alertWidth = self.alertView.width - (btnCount - 1) * 1;
        button.width = alertWidth / btnCount;
        button.left = (button.width + 1) * index;
        button.top = self.alertView.height - button.height;
        button.backgroundColor = [UIColor redColor];
        if (index == 0) {
            tempButton = button;
        }
    }    
    self.titleLabel.centerX = self.alertView.width/2;
    self.messageLabel.centerX = self.titleLabel.centerX;
    self.messageLabel.backgroundColor = [UIColor orangeColor];
}



@end
