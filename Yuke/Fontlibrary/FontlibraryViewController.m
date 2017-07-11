//
//  FontlibraryViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/6/27.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FontlibraryViewController.h"
#import "FontCollectionViewCell.h"

@interface FontlibraryViewController ()

@end

@implementation FontlibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [kCurNavController pushViewController:loginVC animated:YES];
}

- (void)createUI{
    
    //创建collectionView 362
     self.layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = 10;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat bili = 200 / 355.0;
    _layout.itemSize = CGSizeMake(SCREEN_WIDTH - 20, (SCREEN_WIDTH - 20)*bili);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 20 - 10 - TABBAR_HEIGHT) collectionViewLayout:_layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[FontCollectionViewCell class] forCellWithReuseIdentifier:@"FontCell"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FontCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FontCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FontCollectionViewCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.layer.cornerRadius = 5;
    cell.picImageView.layer.cornerRadius = 5;
    cell.picImageView.image = [UIImage imageWithColor:[UIColor greenColor]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击某列
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

@end
