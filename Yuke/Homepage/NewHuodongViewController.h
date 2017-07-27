//
//  NewHuodongViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/14.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface NewHuodongViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray * listArray;

@end
