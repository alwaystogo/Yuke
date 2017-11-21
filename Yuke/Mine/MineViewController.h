//
//  MineViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "ShareView.h"

@interface MineViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource
>
@property(nonatomic,strong)UIScrollView *bkScrollView;
@property(nonatomic,strong)UIImageView *photoImageView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UIButton *editBtn;
@end
