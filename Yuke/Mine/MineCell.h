//
//  MineCell.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 17/2/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightPicImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftPicImageView;
@end
