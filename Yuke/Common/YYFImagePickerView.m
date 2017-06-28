//
//  YYFImagePickerView.m
//  LinkFinance
//
//  Created by yangyunfei on 16/11/29.
//  Copyright © 2016年 JF. All rights reserved.
//

#import "YYFImagePickerView.h"

@implementation YYFImagePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithImagesUrlArray: (NSArray *)imgesUrlArray withCurrentPosition: (NSInteger)currentPositon{
    self = [super init];
    
    if (self){
        
        self.imagesUrlArray = imgesUrlArray;
        self.currentPosition = currentPositon;
        
        //初始化图片放大的尺寸
        self.maxImageSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

//点击imageView实现的方法
- (void)tapAction{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.contentSize = CGSizeMake( [UIScreen mainScreen].bounds.size.width * _imagesUrlArray.count, [UIScreen mainScreen].bounds.size.height);
    _scrollView.pagingEnabled = YES;
    AppDelegate * appDelegate = ((AppDelegate*)[[UIApplication sharedApplication] delegate]);
    [appDelegate.window addSubview:_scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollViewAction)];
    [_scrollView addGestureRecognizer:tap];

    
    for (int i = 0; i < _imagesUrlArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesUrlArray[i]] placeholderImage:[UIImage imageNamed:@"huodongPic"]];
        
        //获得image的尺寸(像素)
        CGSize imageSize = imageView.image.size;
        
        if (imageSize.width <= [UIScreen mainScreen].bounds.size.width && imageSize.height <= [UIScreen mainScreen].bounds.size.height) {
            
            //宽高都小于屏幕尺寸
            imageView.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width + ([UIScreen mainScreen].bounds.size.width - imageSize.width) / 2, ([UIScreen mainScreen].bounds.size.height - imageSize.height) / 2, imageSize.width, imageSize.height);

        }else if (imageSize.width > [UIScreen mainScreen].bounds.size.width && imageSize.height <= [UIScreen mainScreen].bounds.size.height){
            
            //宽大于屏幕尺寸，高小于屏幕尺寸
            CGFloat bili = [UIScreen mainScreen].bounds.size.width / imageSize.width;
            imageView.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - imageSize.height * bili) / 2, imageSize.width *bili, imageSize.height *bili);
        }else if (imageSize.width <= [UIScreen mainScreen].bounds.size.width && imageSize.height > [UIScreen mainScreen].bounds.size.height){
            
            //宽小于屏幕尺寸，高大于屏幕尺寸
            CGFloat bili = [UIScreen mainScreen].bounds.size.height / imageSize.height;
            imageView.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width + ([UIScreen mainScreen].bounds.size.width - imageSize.width * bili) / 2, 0 , imageSize.width *bili, imageSize.height *bili);
        }else{
            
            //宽大于屏幕尺寸，高大于屏幕尺寸
            CGFloat biliWidth = [UIScreen mainScreen].bounds.size.width / imageSize.width;
            CGFloat biliHeight = [UIScreen mainScreen].bounds.size.height / imageSize.height;
            CGFloat bili = biliWidth > biliHeight ? biliHeight : biliWidth;
            imageView.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width + ([UIScreen mainScreen].bounds.size.width - imageSize.width * bili) / 2, 0 + ([UIScreen mainScreen].bounds.size.height - imageSize.height * bili) / 2, imageSize.width *bili, imageSize.height *bili);
        }
        
        [_scrollView addSubview:imageView];
    }
    
    //定位到当前的图片
    _scrollView.contentOffset = CGPointMake((self.currentPosition - 1) * [UIScreen mainScreen].bounds.size.width, 0);
}

//点击scrollView实现的方法
- (void)tapScrollViewAction{
    
    [UIView animateWithDuration:1 animations:^{
        
        [self.scrollView removeFromSuperview];

    }];
    
}
@end
