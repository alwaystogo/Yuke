//
//  ShareViewControllerCell.m
//  OnlineFinancialer
//
//  Created by 007 on 2017/8/15.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "ShareViewControllerCell.h"


@interface ShareViewControllerCell ()

@property (nonatomic, strong) UIImageView *imageView ;
@property (nonatomic, strong) UILabel *descLabel ;

@end

@implementation ShareViewControllerCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.descLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kShareViewControllerCellImageViewWidthHeight * BiLi_SCREENHEIGHT_NORMAL, kShareViewControllerCellImageViewWidthHeight * BiLi_SCREENHEIGHT_NORMAL));
        }];
        
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(self.descLabel.height);
        }];
    }
    return self;
}

#pragma mark - setter

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName.copy;
    
    self.imageView.image = [UIImage imageNamed:_imageName];
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString.copy;
    
    self.descLabel.text = _titleString;
    [self.descLabel sizeToFit];
    
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.descLabel.height);
    }];
}

#pragma mark - getter

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        
        _descLabel.font = SYSTEM_FONT(12.0);
        _descLabel.textColor = COLOR_HEX(0x666666, 1.0);
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel;
}

@end

NSString *kShareViewControllerCellIdentifier = @"kShareViewControllerCellIdentifier" ;



