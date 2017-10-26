//
//  VieoShowViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "CellMediaPlayer.h"

@interface VieoShowViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *videoPreImageViewArray;

@property(nonatomic,strong)NSArray *videoArray;

@property (nonatomic,strong) CellMediaPlayer *cgPlayer;

@end
