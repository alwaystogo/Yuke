//
//  YuePhotoViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "CarouselScrollView.h"

@interface YuePhotoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIButton *yueBtn;
@property(nonatomic,strong)UIButton *yiBtn;
@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,strong)UIScrollView *bkScrollView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)CarouselScrollView *carouselSV;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;

@property(nonatomic,strong)NSArray *bannerArray;
@property(nonatomic,strong)NSArray *listArray;

@end
