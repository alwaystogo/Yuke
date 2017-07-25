//
//  YanyuanCardsListViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/24.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface YanyuanCardsListViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSArray *mobanArray;
@property(nonatomic,assign)NSInteger selectedNum;

@end
