//
//  YYFPickView.m
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "YYFPickViewThree.h"

@implementation YYFPickViewThree

- (instancetype)initWithFrame:(CGRect)frame withOneArray:(NSArray *)oneArray withTwoArray:(NSArray *)twoArray withThreeArray:(NSArray *)threeArray{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COLOR_HEX(0x000000, 0.3);
        self.dataOneArray = oneArray;
        self.dataTwoArray = twoArray;
        self.dataThreeArray = threeArray;
        
        self.bkView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, kPickerViewHeight)];
        self.bkView.backgroundColor = WHITECOLOR;
        [self addSubview:self.bkView];
        
        //左上角和右上角加圆角效果
        [self bezierPath];
        [self shapeLayer];
        
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kBtnHeight, SCREEN_WIDTH , self.bkView.height - kBtnHeight)];
        self.pickView.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
        [self.bkView addSubview:self.pickView];
        
        [self.bkView addSubview:self.DetermineBtn];
        [self.bkView addSubview:self.cancelBtn];
        
        //动画效果
        [self showInView:self.bkView];
        
        
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.dataOneArray.count;
    }
    if (component == 1) {
        return self.dataTwoArray.count;
    }
    if (component == 2) {
        return self.dataThreeArray.count;
    }
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.dataOneArray[row];
    }
    if (component == 1) {
        return self.dataTwoArray[row];
    }
    if (component == 2) {
        return self.dataThreeArray[row];
    }

    return @"";
}
// 设置row字体，颜色
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel            = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel                 = [[UILabel alloc] init];
        pickerLabel.textAlignment   = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        pickerLabel.font            = [UIFont systemFontOfSize:20.0];
    }
    
    pickerLabel.text                = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, kBtnHeight, kBtnHeight);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)DetermineBtn {
    if (!_DetermineBtn) {
        _DetermineBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _DetermineBtn.frame = CGRectMake(SCREEN_WIDTH - kBtnHeight, 0, kBtnHeight, kBtnHeight);
        [_DetermineBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_DetermineBtn addTarget:self action:@selector(determineBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _DetermineBtn;
}

- (void)showInView:(UIView *)view {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGPoint point = view.center;
        point.y      -= kPickerViewHeight;
        view.center   = point;
        
    } completion:^(BOOL finished) {
    
    }];
}

- (void)determineBtnAction:(UIButton *)button {
    
    NSInteger oneRow = [_pickView selectedRowInComponent:0];
    NSInteger twoRow   = [_pickView selectedRowInComponent:1];
    NSInteger threeRow  = [_pickView selectedRowInComponent:2];
    
    if (self.determineBtnBlock) {
        if (self.dataOneArray != nil && self.dataOneArray.count != 0 && self.dataTwoArray != nil && self.dataTwoArray.count != 0 && self.dataThreeArray != nil && self.dataThreeArray.count != 0) {
            
            self.determineBtnBlock(oneRow, twoRow, threeRow, self.dataOneArray[oneRow], self.dataTwoArray[twoRow], self.dataThreeArray[threeRow]);
        }
    }
    
    [self dismiss];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGPoint point = self.bkView.center;
        point.y      += kPickerViewHeight;
        self.bkView.center   = point;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bkView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    }
    return _bezierPath;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = self.bkView.bounds;
        _shapeLayer.path = _bezierPath.CGPath;
        self.bkView.layer.mask = _shapeLayer;
    }
    return _shapeLayer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismiss];
}
@end
