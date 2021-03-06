//
//  YanyuanCardsListViewController.m
//  Yuke
//
//  Created by yangyunfei on 2017/7/24.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "YanyuanCardsListViewController.h"
#import "YanyuanCardsCollectionViewCell.h"
#import "HotCollectionViewCell.h"
#import "EditViewController.h"
#import "TZImagePickerController.h"

@interface YanyuanCardsListViewController ()

@end

@implementation YanyuanCardsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_HEX(0xdddddd, 1);
    self.title = @"选择模板";
    self.mobanArray = @[@"模板一",@"模板二",@"模板三",@"模板四",@"模板五",@"模板六",@"模板七",@"模板八",@"模板九",@"模板十",@"模板十一",@"模板十二",@"模板十三",@"模板十四",@"模板十五"];
    [self setLeftBackNavItem];
    
    [self createUI];
}

- (void)createUI{
    
    if (is_iPhoneX) {
        CGFloat hotPicWidth = 80 * BiLi_SCREENWIDTH_NORMAL;
        CGFloat hotPicHeight = hotPicWidth *3582/2364+10;
        //创建collectionView 362
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(hotPicWidth, hotPicHeight);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.bottom - hotPicHeight-34, SCREEN_WIDTH, hotPicHeight) collectionViewLayout:layout];
        //self.collectionView.backgroundColor = [UIColor blueColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:self.collectionView];
        
        //注册单元格,相当于设置了闲置池
        UINib *nib = [UINib nibWithNibName:@"YanyuanCardsCollectionViewCell" bundle: [NSBundle mainBundle]];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"YanyuanCell"];
        
        
        CGFloat imageHeight = CGRectGetMinY(self.collectionView.frame) - 10 - NAVBAR_HEIGHT - 10 - 83;
        CGFloat imageWidth = imageHeight*2364/3582.0;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - imageWidth)/2.0, NAVBAR_HEIGHT + 10,imageWidth, imageHeight)];
        self.imageView.image = [UIImage imageNamed:@"1121_1"];
        self.imageView.userInteractionEnabled = YES;
        [self.view addSubview:self.imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction)];
        [self.imageView addGestureRecognizer:tap];
    }else{
        CGFloat hotPicWidth = 80 * BiLi_SCREENWIDTH_NORMAL;
        CGFloat hotPicHeight = hotPicWidth *3582/2364+10;
        //创建collectionView 362
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(hotPicWidth, hotPicHeight);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.bottom - hotPicHeight, SCREEN_WIDTH, hotPicHeight) collectionViewLayout:layout];
        //self.collectionView.backgroundColor = [UIColor blueColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:self.collectionView];
        
        //注册单元格,相当于设置了闲置池
        UINib *nib = [UINib nibWithNibName:@"YanyuanCardsCollectionViewCell" bundle: [NSBundle mainBundle]];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"YanyuanCell"];
        
        
        CGFloat imageHeight = CGRectGetMinY(self.collectionView.frame) - 10 - 64 - 10;
        CGFloat imageWidth = imageHeight*2364/3582.0;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - imageWidth)/2.0, 64 + 10,imageWidth, imageHeight)];
        self.imageView.image = [UIImage imageNamed:@"1121_1"];
        self.imageView.userInteractionEnabled = YES;
        [self.view addSubview:self.imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction)];
        [self.imageView addGestureRecognizer:tap];
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.mobanArray.count;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YanyuanCardsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YanyuanCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YanyuanCardsCollectionViewCell" owner:self options:nil] lastObject];
    }
    NSString *imageStr = [NSString stringWithFormat:@"1121_%ld",indexPath.row+1];
    cell.picImageView.image = [UIImage imageNamed:imageStr];
    cell.typeLabel.text = self.mobanArray[indexPath.row];
    if (indexPath.row == self.selectedNum) {
        
        cell.picImageView.layer.borderWidth = 3;
        cell.picImageView.layer.borderColor = COLOR_HEX(0xffa632,1).CGColor;
    }else{
        
        cell.picImageView.layer.borderWidth = 0;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击某列
    self.selectedNum = indexPath.row;
    NSString *imageStr = [NSString stringWithFormat:@"1121_%ld",indexPath.row+1];
    self.imageView.image = [UIImage imageNamed:imageStr];
    [self.collectionView reloadData];
}

- (void)tapImageViewAction{
    
    //竖
    [LoginViewController checkLogin:^(BOOL result) {
        
        if (result) {
            //[JFTools showTipOnHUD:@"登录成功"];
            NSInteger max = 0;
            if (self.selectedNum < 8) {
                max = 1;
            }
            if (self.selectedNum == 8) {
                max = 2;
            }
            if (self.selectedNum == 9) {
                max = 3;
            }
            if (self.selectedNum == 10) {
                max = 4;
            }
            if (self.selectedNum == 11) {
                max = 4;
            }
            if (self.selectedNum == 12) {
                max = 9;
            }
            if (self.selectedNum == 13) {
                max = 9;
            }
            if (self.selectedNum == 14) {
                max = 17;
            }
            
            WeakSelf
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:max columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
            imagePickerVc.minImagesCount = max;
            imagePickerVc.allowPickingVideo = NO;
            imagePickerVc.allowPickingImage = YES;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            imagePickerVc.sortAscendingByModificationDate = YES;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                EditViewController *editVC = [[EditViewController alloc] initWith:weakSelf.selectedNum+1 withImageArray:photos withType:0];
                editVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:editVC animated:YES];
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];

        }else{
            //[JFTools showTipOnHUD:@"登录失败"];
        }
    }];
    

}
@end
