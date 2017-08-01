//
//  VieoShowViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"
#import "CGPlayer.h"

@interface VieoShowViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *videoPreImageViewArray;
@end
