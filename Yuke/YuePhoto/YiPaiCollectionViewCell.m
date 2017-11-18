//
//  YiPaiCollectionViewCell.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/10.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "YiPaiCollectionViewCell.h"
#import "WSLPhotoZoom.h"

@implementation YiPaiCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    self.picImageView.userInteractionEnabled = YES;
    [self.picImageView addGestureRecognizer:tap4];
}
- (void)tapImageView{
    WSLPhotoZoom *zm = [[WSLPhotoZoom alloc] initWithFrame:[UIScreen mainScreen].bounds];
    zm.imageNormalWidth = [UIScreen mainScreen].bounds.size.width;
    zm.imageNormalHeight = [UIScreen mainScreen].bounds.size.height;
    zm.imageView.image = self.picImageView.image;
    [[UIApplication sharedApplication].delegate.window addSubview:zm];
}
@end
