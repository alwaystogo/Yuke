//
//  YYFPickView.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBtnHeight 50

typedef void(^OkBtnActionBlock)(NSInteger row, NSString *strValue);

@interface YYFPickView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIView *bkView;

@property(nonatomic,strong)UIPickerView *pickView;

@property (strong, nonatomic) UIButton  *cancelBtn;

@property (strong, nonatomic) UIButton *DetermineBtn;

@property(nonatomic,strong)NSArray *dataArray;

@property (strong, nonatomic) UIBezierPath   *bezierPath;

@property (strong, nonatomic) CAShapeLayer   *shapeLayer;

@property(nonatomic,strong) OkBtnActionBlock determineBtnBlock;

//dataArray 数据
- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray;

@end

