//
//  MeiriZuXunViewController.h
//  Yuke
//
//  Created by yangyunfei on 2017/7/17.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "BaseViewController.h"

@interface MeiriZuXunViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UIButton *dateBtn;
@property(nonatomic,strong)UITableView *typeTableView;
@property(nonatomic,strong)UITableView *dateTableView;

@property(nonatomic,strong)NSArray *typeArray;
@property(nonatomic,strong)NSArray *dateArray;

@property(nonatomic,assign)NSInteger selectType;
@property(nonatomic,assign)NSInteger selectDate;

@end
