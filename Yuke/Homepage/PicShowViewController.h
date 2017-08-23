//
//  PicShowViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface PicShowViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *listArray;

@end
