//
//  ShareViewControllerCell.h
//  OnlineFinancialer
//
//  Created by 007 on 2017/8/15.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kShareViewControllerCellImageViewWidthHeight = 34.0;

@interface ShareViewControllerCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageName ;
@property (nonatomic, copy) NSString *titleString ;

@end

UIKIT_EXTERN NSString *kShareViewControllerCellIdentifier ;

