//
//  VieoShowCell.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VieoShowCell;
//代理
@protocol ViewCellDelegate <NSObject>

/**
 *  播放按钮被点击
 */
- (void) playButtonClick:(VieoShowCell *)viewCell;

@end

@interface VieoShowCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageVedioView;
@property (nonatomic, weak) id<ViewCellDelegate> delegate;

@end
