//
//  YirenViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/14.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "YirenViewController.h"
#import "YirenTableViewCell.h"
#import "HotCollectionViewCell.h"

#define tableHeaderHeight 260
#define hotPicWidth 160
#define hotPicHeight 220

@interface YirenViewController ()

@end

@implementation YirenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listArray = [NSMutableArray array];

    self.title = @"艺人专访";
    [self setLeftBackNavItem];
    [self createUI];

    [self requestHot];
    [self refreshAction];
}

- (void)createUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 220;
    //self.tableView.separatorStyle = NO;//去除分割线
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;//JFRefreshControl
    //self.tableView.mj_header = [MJRefreshHeader refreshControlWithTarget:self action:@selector(refreshAction)];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreAction)];
    [self.tableView closeEstimatedHeight];
    //[self.tableView closeContentInsetAdjustAutomaicCalculate];
    [self.view addSubview:self.tableView];

}
//组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArray.count;
}
//每个组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentify = @"YirenTableViewCell";
    
    YirenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YirenTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.picImageView getImageWithUrl:[self.listArray[indexPath.section] objectForKeySafe:@"thumb"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
    //cell.picImageView.image = [UIImage imageWithColor:[UIColor grayColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了-%ld",indexPath.row);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",kJFClient.baseUrl,[self.listArray[indexPath.section] objectForKeySafe:@"info_url"]];
    BaseWebViewViewController *webVc= [[BaseWebViewViewController alloc] initWithURL:strUrl];
    webVc.title = @"专访详情";
    [kCurNavController pushViewController:webVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return tableHeaderHeight+5;
    }else{
        
        return 0.1f;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tableHeaderHeight + 5)];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 17, 17)];
    imageView1.image = ImageNamed(@"remen");
    [headerView addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame)+10, CGRectGetMaxY(imageView1.frame)- 10, 60,14)];
    //label1.backgroundColor = [UIColor greenColor];
    label1.bottom = imageView1.bottom;
    label1.text = @"热门专访";
    label1.font = FONT_REGULAR(13);
    label1.textColor = COLOR_HEX(0x333333, 1);
    //label1.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:label1];
    
    //创建collectionView 362
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(hotPicWidth, hotPicHeight);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame)+3+5, SCREEN_WIDTH, hotPicHeight) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [headerView addSubview:self.collectionView];
    
    //注册单元格,相当于设置了闲置池
    UINib *nib = [UINib nibWithNibName:@"HotCollectionViewCell" bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"hotCell"];
    //headerView.height = CGRectGetMaxY(self.collectionView.frame) + 10;
    if (section == 0) {
        
        return headerView;
    }else{
        
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.0f;
}


#pragma UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.hotArray.count;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotCollectionViewCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.layer.cornerRadius = 10;
    cell.picImageView.layer.cornerRadius = 10;
    [cell.picImageView getImageWithUrl:[self.hotArray[indexPath.row] objectForKeySafe:@"thumb"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击某列
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",kJFClient.baseUrl,[self.hotArray[indexPath.row] objectForKeySafe:@"info_url"]];
    BaseWebViewViewController *webVc= [[BaseWebViewViewController alloc] initWithURL:strUrl];
    webVc.title = @"专访详情";
    [kCurNavController pushViewController:webVc animated:YES];
}

- (void)requestHot{
    
    [JFTools showLoadingHUD];
    [kJFClient getHomePageHot:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [JFTools HUDHide];
        NSLog(@"--- :%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.hotArray = responseObject;
            [self.collectionView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [JFTools showTipOnHUD:error.localizedDescription];
    }];
    
}

//下拉刷新
- (void)refreshAction{
    
    self.currentPage = 1;
    
    NSDictionary *dic = @{@"pager":[NSString stringWithFormat:@"%ld",self.currentPage]};
    [JFTools showLoadingHUD];
    [kJFClient zhuanfangList:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [JFTools HUDHide];
        NSLog(@"--- :%@",responseObject);
        [self.tableView.mj_header endRefreshing];
        [self.listArray removeAllObjects];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.listArray = responseObject;
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [JFTools showTipOnHUD:error.localizedDescription];
    }];

}
//上拉加载
-(void)loadMoreAction{
    
    if (self.currentPage < 2) {
        
        self.currentPage = 2;
    }
    
    NSDictionary *dic = @{@"pager":[NSString stringWithFormat:@"%ld",self.currentPage]};
    [JFTools showLoadingHUD];
    [kJFClient zhuanfangList:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [JFTools HUDHide];
        NSLog(@"--- :%@",responseObject);
        [self.tableView.mj_header endRefreshing];
        //[self.listArray removeAllObjects];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *array = (NSArray *)responseObject;
            if (array.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.listArray addObjectsFromArray:array];
                [self.tableView.mj_footer endRefreshing];
            }
          
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.currentPage++;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [JFTools showTipOnHUD:error.localizedDescription];
    }];

}

@end
