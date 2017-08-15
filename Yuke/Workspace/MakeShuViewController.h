//
//  MakeShuViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/8/15.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface MakeShuViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,assign)NSInteger mobanNum;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSDictionary *infoDic;

- (instancetype)initWith:(NSInteger)mobanNum withImageArray:(NSArray *)imageArray withInfo:(NSDictionary *)infoDic;
@end
