//
//  YYFImagePickerView.h
//  LinkFinance
//
//  Created by yangyunfei on 16/11/29.
//  Copyright © 2016年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片放大器
//按原始尺寸显示，大于屏幕尺寸的时候按比例收缩

@interface YYFImagePickerView : UIImageView

@property(nonatomic,strong)NSArray *imagesUrlArray;//所有图片的url
@property(nonatomic,assign)NSInteger currentPosition;//点击的图片所在的位置(从1开始)
@property(nonatomic,assign)CGSize maxImageSize;//点击图片放大时的尺寸
@property(nonatomic,strong)UIScrollView *scrollView;

//初始化方法
- (instancetype)initWithImagesUrlArray : (NSArray *)imgesUrlArray withCurrentPosition : (NSInteger)currentPositon;

@end
