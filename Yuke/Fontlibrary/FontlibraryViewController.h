//
//  FontlibraryViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface FontlibraryViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;

@property(nonatomic,strong)NSArray *listArray;
@end
