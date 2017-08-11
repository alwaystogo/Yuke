//
//  HomepageViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "CarouselScrollView.h"

@interface HomepageViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIScrollView *bkScrollView;
@property(nonatomic,strong)CarouselScrollView *carouselSV;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *bannerArray;
@property(nonatomic,strong)NSArray *hotArray;
@end
