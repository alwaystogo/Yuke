//
//  CardScrollView.m
//  Yuke
//
//  Created by yangyunfei on 2017/8/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "CardScrollView.h"

@implementation CardScrollView

- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [self imageShowInScrollViewByScale:image withScrollViewSize:self.frame.size];
        self.contentSize = self.image.size;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
        self.imageView.image = self.image;
        [self addSubview:self.imageView];

    }
    return self;
}

//获取缩放后的图片
//将图片显示在scrollview中，以优先铺满一个维度为标准，另一个方向可以滑动。
- (UIImage *)imageShowInScrollViewByScale:(UIImage *)image withScrollViewSize:(CGSize)scrollViewSize{
    
    UIImage *newImage = nil;
    
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat scrollViewWidth = scrollViewSize.width;
    CGFloat scrollViewHeight = scrollViewSize.height;
    
    CGSize newSize;
    CGFloat widthBili = imageWidth / scrollViewWidth;
    CGFloat heightBili = imageHeight / scrollViewHeight;
    
    if (imageWidth >= scrollViewWidth && imageHeight >= scrollViewHeight) {
        //图片的宽高都大于scrollview的宽高：图片按最小比例缩小
        CGFloat bili = widthBili > heightBili ? heightBili : widthBili;
        newSize = CGSizeMake(imageWidth / bili, imageHeight / bili);
    }else if (imageWidth >= scrollViewWidth && imageHeight < scrollViewHeight){
        //图片的宽大于scrollview,图片的高小于scrollview：图片的高放大到scrollview高的长度，图片的宽也按此比例放大
        
        newSize = CGSizeMake(imageWidth / heightBili,scrollViewHeight);
    }else if (imageWidth < scrollViewWidth && imageHeight >= scrollViewHeight){
        //图片的宽小于scrollview,图片的高大于scrollview：图片的宽放大到scrollview宽的长度，图片的高也按此比例放大
        
        newSize = CGSizeMake(scrollViewWidth, imageHeight / widthBili);
    }else {
        //图片的宽小于scrollview,图片的高小于scrollview：图片按最大比例放大
        
        CGFloat bili = widthBili > heightBili ? heightBili : widthBili;
        newSize = CGSizeMake(imageWidth / bili, imageHeight / bili);
    }
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, SCALE);
    
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
