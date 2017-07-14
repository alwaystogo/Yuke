//
//  YirenViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/14.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface YirenViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;

@end
