//
//  MakeHengViewController.h
//  OnlineFinancialer
//
//  Created by yangyunfei on 2017/8/14.
//  Copyright © 2017年 wkj. All rights reserved.
//

#import "BaseViewController.h"

@interface MakeHengViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,assign)NSInteger mobanNum;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSDictionary *infoDic;

- (instancetype)initWith:(NSInteger)mobanNum withImageArray:(NSArray *)imageArray withInfo:(NSDictionary *)infoDic;

@end
