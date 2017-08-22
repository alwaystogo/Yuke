//
//  WorkspaceViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "CarouselScrollView.h"
@interface WorkspaceViewController : BaseViewController

@property(nonatomic,strong)CarouselScrollView *carouselSV;
@property(nonatomic,strong)UIScrollView *bkScrollView;
@property(nonatomic,strong)UIImageView *moteBkImageView;
@property(nonatomic,strong)UIImageView *yanyuanBkImageView;
@property(nonatomic,strong)UIImageView *shipinBkImageView;

@property(nonatomic,strong)NSArray *bannerArray;
@end
