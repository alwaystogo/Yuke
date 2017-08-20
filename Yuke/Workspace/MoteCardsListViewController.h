//
//  MoteCardsListViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/24.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface MoteCardsListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *mobanArray;
@property(nonatomic,assign)NSInteger selectedNum;

@end
