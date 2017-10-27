//
//  PicShowCell.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "PicShowCell.h"
#import "WSLPhotoZoom.h"

@implementation PicShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.picImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    self.picImageView.userInteractionEnabled = YES;
    [self.picImageView addGestureRecognizer:tap4];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tapImageView{
    WSLPhotoZoom *zm = [[WSLPhotoZoom alloc] initWithFrame:[UIScreen mainScreen].bounds];
    zm.imageNormalWidth = [UIScreen mainScreen].bounds.size.width;
    zm.imageNormalHeight = [UIScreen mainScreen].bounds.size.height;
    zm.imageView.image = self.picImageView.image;
    [[UIApplication sharedApplication].delegate.window addSubview:zm];
}
@end
