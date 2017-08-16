//
//  CardScrollView.h
//  Yuke
//
//  Created by yangyunfei on 2017/8/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardScrollView : UIScrollView

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UIImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage *)image;

@end
