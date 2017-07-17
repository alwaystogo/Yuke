//
//  ZuXunCell.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/17.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "ZuXunCell.h"

@implementation ZuXunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.typeBtn.layer.cornerRadius = 5;
    self.typeBtn.layer.borderWidth = 1;
    self.typeBtn.layer.borderColor = COLOR_HEX(0xffa632, 1).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
