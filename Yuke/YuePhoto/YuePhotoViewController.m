//
//  YuePhotoViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "YuePhotoViewController.h"
#import "YuePaisheTableViewCell.h"
#import "YiPaiCollectionViewCell.h"

#define LunboHeight  (CGRectGetWidth([UIScreen mainScreen].bounds) / 320 * 172)
@interface YuePhotoViewController ()

@end

@implementation YuePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    [self createBottomUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestBannerData];
    [self requestListData];
    [self requestYipaiData];
}
- (void)createUI{
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 33)];
    self.topView.userInteractionEnabled = YES;
    //self.topView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.topView];
    
    //
    self.yueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.yueBtn.frame = CGRectMake(0, 0, 100, 20);
    //self.yueBtn.backgroundColor = COLOR_HEX(0xcccccc, 1);
    [self.yueBtn setTitle:@"预约拍摄" forState:UIControlStateNormal];
    [self.yueBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    self.yueBtn.titleLabel.font = FONT_REGULAR(15);
    [self.yueBtn addTarget:self action:@selector(yueBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.yueBtn];
    [self.yueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.topView.mas_left).offset(65 * BiLi_SCREENWIDTH_NORMAL);
        make.centerY.mas_equalTo(self.topView.centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

    self.yiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.yiBtn.frame = CGRectMake(0, 0, 100, 20);
    //self.yiBtn.backgroundColor = COLOR_HEX(0xcccccc, 1);
    [self.yiBtn setTitle:@"已拍样片" forState:UIControlStateNormal];
    [self.yiBtn setTitleColor:COLOR_HEX(0x000000, 1) forState:UIControlStateNormal];
    self.yiBtn.titleLabel.font = FONT_REGULAR(15);
    [self.yiBtn addTarget:self action:@selector(yiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.yiBtn];
    [self.yiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.topView.mas_right).offset(-65 * BiLi_SCREENWIDTH_NORMAL);
        make.centerY.mas_equalTo(self.topView.centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = COLOR_HEX(0xffa632, 1);
    [self.topView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.yueBtn.mas_centerX);
        make.top.mas_equalTo(self.yueBtn.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 2));
    }];
}

- (void)createBottomUI{
    
    self.bkScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+3, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.topView.frame) - TABBAR_HEIGHT)];
    self.bkScrollView.backgroundColor = [UIColor whiteColor];
    self.bkScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, self.bkScrollView.height);
    self.bkScrollView.pagingEnabled = YES;
    self.bkScrollView.scrollEnabled = NO;
    [self.view addSubview:self.bkScrollView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bkScrollView.width, self.bkScrollView.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 220;
    //self.tableView.separatorStyle = NO;//去除分割线
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.bkScrollView addSubview:self.tableView];

    //创建collectionView 362
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = 10;
    _layout.minimumInteritemSpacing = 10;
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat bili = 300 / 172.0;
    _layout.itemSize = CGSizeMake((SCREEN_WIDTH - 30)/2.0, (SCREEN_WIDTH - 30)/2.0 *bili);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.bkScrollView.width + 10, 0, SCREEN_WIDTH - 20, SCREEN_HEIGHT - CGRectGetMaxY(self.topView.frame) - TABBAR_HEIGHT) collectionViewLayout:_layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.bkScrollView addSubview:self.collectionView];
    
    //注册单元格,相当于设置了闲置池
    UINib *nib = [UINib nibWithNibName:@"YiPaiCollectionViewCell" bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"YiPaiCollectionViewCell"];

}

- (void)yueBtnAction{
    
    [self.yueBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    [self.yiBtn setTitleColor:COLOR_HEX(0x000000, 1) forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.yueBtn.mas_centerX);
            make.top.mas_equalTo(self.yueBtn.mas_bottom).offset(3);
            make.size.mas_equalTo(CGSizeMake(60, 2));
        }];
        self.bkScrollView.contentOffset = CGPointMake(0, 0);
    }];
    
}

- (void)yiBtnAction{
    
    [self.yiBtn setTitleColor:COLOR_HEX(0xffa632, 1) forState:UIControlStateNormal];
    [self.yueBtn setTitleColor:COLOR_HEX(0x000000, 1) forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.yiBtn.mas_centerX);
            make.top.mas_equalTo(self.yiBtn.mas_bottom).offset(3);
            make.size.mas_equalTo(CGSizeMake(60, 2));
        }];
        self.bkScrollView.contentOffset = CGPointMake(self.bkScrollView.width, 0);
    }];
    
}

//组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//每个组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentify = @"YuePaisheTableViewCell";
    
    YuePaisheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YuePaisheTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.picImageView getImageWithUrl:[self.listArray[indexPath.row] objectForKeySafe:@"sm_thumb"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了-%ld",indexPath.row);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",kJFClient.baseUrl,[self.listArray[indexPath.row] objectForKeySafe:@"info_url"]];
    BaseWebViewViewController *webVc= [[BaseWebViewViewController alloc] initWithURL:strUrl];
    webVc.title = @"约拍摄详情";
    webVc.hidesBottomBarWhenPushed = YES;
    [kCurNavController pushViewController:webVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return LunboHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIScrollView *bkScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), LunboHeight)];
    bkScrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), LunboHeight);
    //轮播控件
     _carouselSV = [[CarouselScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), LunboHeight)];
    _carouselSV.backgroundColor = [UIColor blueColor];
    [bkScrollView addSubview:_carouselSV];
    WeakSelf
    _carouselSV.click = ^(NSInteger index) {
        
        NSLog(@"点击了第%ld",index);
        NSString *strUrl = [weakSelf.bannerArray[index] objectForKeySafe:@"url"];
        BaseWebViewViewController *webVc= [[BaseWebViewViewController alloc] initWithURL:strUrl];
        webVc.title = @"详情";
        webVc.hidesBottomBarWhenPushed = YES;
        [kCurNavController pushViewController:webVc animated:YES];
    };
    
    [_carouselSV setCarouseWithArray:self.bannerArray];

    return bkScrollView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1f;
}

#pragma UIcollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.yiPaiListArray.count;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YiPaiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YiPaiCollectionViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YiPaiCollectionViewCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.layer.cornerRadius = 5;
    cell.picImageView.layer.cornerRadius = 5;
    [cell.picImageView getImageWithUrl:[self.yiPaiListArray[indexPath.row] objectForKeySafe:@"thumb"] placeholderImage:[UIImage imageNamed:PlaceHolderPic]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击某列
    
}

- (void)requestBannerData{
    
    [kJFClient yuePaisheBanner:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"banner- %@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.bannerArray = responseObject;
            //[self.tableView reloadData];
            [_carouselSV setCarouseWithArray:self.bannerArray];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}

- (void)requestListData{
    
    [kJFClient yuePaisheList:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"yuepaisheList- %@",responseObject);

        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.listArray = responseObject;
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];
}

- (void)requestYipaiData{
    
    NSDictionary *dic = @{@"user_id":NON(kUserMoudle.user_Id)};
    
    [kJFClient yiPaiList:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"yiPaiList- %@",responseObject);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.yiPaiListArray = responseObject;
            [self.collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JFTools showFailureHUDWithTip:error.localizedDescription];
    }];

}
@end
