//
//  YYFPickView.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBtnHeight 50

typedef void(^OkBtnBlock)(NSInteger oneId, NSInteger twoId, NSInteger threeId, NSString *oneName, NSString *twoName, NSString *threeName);

@interface YYFPickViewThree : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIView *bkView;

@property(nonatomic,strong)UIPickerView *pickView;

@property (strong, nonatomic) UIButton  *cancelBtn;

@property (strong, nonatomic) UIButton *DetermineBtn;

@property(nonatomic,strong)NSArray *dataOneArray;
@property(nonatomic,strong)NSArray *dataTwoArray;
@property(nonatomic,strong)NSArray *dataThreeArray;

@property (strong, nonatomic) UIBezierPath   *bezierPath;

@property (strong, nonatomic) CAShapeLayer   *shapeLayer;

@property(nonatomic,strong) OkBtnBlock determineBtnBlock;

//dataArray 数据
- (instancetype)initWithFrame:(CGRect)frame withOneArray:(NSArray *)oneArray withTwoArray:(NSArray *)twoArray withThreeArray:(NSArray *)threeArray;

@end

